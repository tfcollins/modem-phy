clear all; close all;
% Set random number generator for repeatability
hStream   = RandStream.create('mt19937ar', 'seed', 12345);

%% Frame parameters
Rsym      = 1e6;  % Symbol rate (Hz)
nAGCTrain = 100;  % Number of training symbols
nTrain    = 250;  % Number of training symbols
nPayload  = 8*1400;  % Number of payload bits
nTail     = 40+68;  % Number of tail symbols (enough to flush filters and handle viterbi lag)

%% Frame start marker
barker = comm.BarkerCode('SamplesPerFrame', 28, 'Length', 11);
preamble = barker()+1;

%% Modulation
bitsPerSym = 2;                              % Number of bits per PSK symbol
M = 2^bitsPerSym;                            % Modulation order
PO = pi/4;
hPSKMod   = comm.PSKModulator(M, ...
    'PhaseOffset',PO, ...
    'SymbolMapping','Binary',...
    'BitInput', true);
hPSKDemod = comm.PSKDemodulator(M, ...
    'PhaseOffset',PO, ...
    'SymbolMapping','Binary',...
    'BitOutput', true);
hPSKModPreamble   = comm.PSKModulator(M, ...
    'PhaseOffset',PO, ...
    'SymbolMapping','Binary');
hPSKModTrain   = comm.PSKModulator(M, ...
    'PhaseOffset',PO, ...
    'SymbolMapping','Binary');
PSKConstellation = constellation(hPSKMod).'; % PSK constellation

%% Training
xAGCTrainData = randi(hStream, [0 M-1], nAGCTrain, 1);
xTrainData = randi(hStream, [0 M-1], nTrain, 1);
xTailData  = randi(hStream, [0 M-1], nTail, 1);

xPreamble  = step(hPSKModTrain,preamble);
xTail      = step(hPSKModTrain,xTailData);

%% AGC Preamble
reps = 10;
barker = comm.BarkerCode('SamplesPerFrame', 16, 'Length', 13);
seq = barker()+1;
AGCPreamble = repmat(seq,reps,1);
xAGCTrain  = step(hPSKModTrain,AGCPreamble);

%% DFE training data
modulatedSymbols = 250;
bitsPerSample = 2;
pnseq = comm.PNSequence('Polynomial', 'z^5 + z^3 + z^1 + 1', ...
    'SamplesPerFrame', modulatedSymbols*bitsPerSample, 'InitialConditions', [1 1 1 0 0]);
DFETraining = pnseq();
xTrain     = step(hPSKMod,DFETraining);

%% Channel coding and scrambler
trellis = poly2trellis(7,[171 133]);
tbl = 32;
rate = 1/2;
N = 2;
scr  = comm.Scrambler(N, '1 + z^-1 + z^-3 + z^-5+ z^-7',...
    'InitialConditions',[0 1 0 0 0 1 0]);
descr = comm.Descrambler(N,'1 + z^-1 + z^-3 + z^-5+ z^-7',...
    'InitialConditions',[0 1 0 0 0 1 0]);

%% CRC
crcEnc = comm.CRCGenerator('Polynomial','z^32 + z^26 + z^23 + z^22 + z^16 + z^12 + z^11 + z^10 + z^8 + z^7 + z^5 + z^4 + z^2 + z + 1');
crcDec = comm.CRCDetector ('Polynomial','z^32 + z^26 + z^23 + z^22 + z^16 + z^12 + z^11 + z^10 + z^8 + z^7 + z^5 + z^4 + z^2 + z + 1');
crcLen = 32;

%% Header
HeaderLen = 16; % Bits
PayloadCodedLen = (nPayload+crcLen+nTail)/rate;
HeaderData = bitget(PayloadCodedLen,1:HeaderLen).';
HeaderDataPad = reshape([HeaderData HeaderData].',1,HeaderLen*2).';
xHeader = step(hPSKMod,HeaderDataPad);

maxFrameLength = 2^16;

%% Filters
chanFilterSpan = 8;  % Filter span in symbols
sampPerSymChan = 4;  % Samples per symbol through channels
hTxFilt = comm.RaisedCosineTransmitFilter( ...
    'RolloffFactor',0.5, ...
    'FilterSpanInSymbols',chanFilterSpan, ...
    'OutputSamplesPerSymbol',sampPerSymChan);

hRxFilt = comm.RaisedCosineReceiveFilter( ...
    'RolloffFactor',0.5, ...
    'FilterSpanInSymbols',chanFilterSpan, ...
    'InputSamplesPerSymbol',sampPerSymChan, ...
    'DecimationFactor',1);

hRxFiltPD = comm.RaisedCosineReceiveFilter( ...
    'RolloffFactor',0.5, ...
    'FilterSpanInSymbols',chanFilterSpan, ...
    'InputSamplesPerSymbol',sampPerSymChan, ...
    'DecimationFactor',sampPerSymChan);

% Calculate the samples per symbol after the receive filter
sampPerSymPostRx = sampPerSymChan/hRxFilt.DecimationFactor;
% Calculate the delay in samples from both channel filters
chanFilterDelay = chanFilterSpan*sampPerSymPostRx;

%% Channel
hAWGNChan = comm.AWGNChannel( ...
    'NoiseMethod','Signal to noise ratio (Es/No)', ...
    'EsNo',10, ...
    'SamplesPerSymbol',sampPerSymChan);

% Configure a frequency-flat Rayleigh channel System object with the
% RandomStream property set to 'mt19937ar with seed' for repeatability.
hRayleighChan = comm.RayleighChannel( ...
    'SampleRate',Rsym, ...
    'MaximumDopplerShift',30);

% Frequency Offset
trueOffset = 0;
fo = comm.PhaseFrequencyOffset('SampleRate', Rsym,...
    'FrequencyOffset', trueOffset);
% Timing offset
vd = dsp.VariableFractionalDelay;

%% Channel
channel = 'radio';
FrequencyOffset = 400;

switch channel
    case 'qpsk'
        DelayType = 'Triangle';
        FilterSpan = chanFilterSpan;
        PhaseOffset = 45;
        FrameSize = nPayload;
        UpSample = sampPerSymChan;
        EbNo = 15;
        BitsPerSymbol = 2;
        frameCount = 10;
        
        % Create and configure the AWGN channel System object
        qpskChan = QPSKChannel('DelayType', DelayType, ...
            'RaisedCosineFilterSpan', FilterSpan, ...
            'PhaseOffset', PhaseOffset, ...
            'SignalPower', 1/UpSample, ...
            'FrameSize', FrameSize/10, ...
            'UpsamplingFactor', UpSample, ...
            'EbNo', EbNo, ...
            'BitsPerSymbol', BitsPerSymbol, ...
            'FrequencyOffset', FrequencyOffset, ...
            'SampleRate', Rsym);
        
    case 'radio'
        % Setup radios
        rx=sdrrx('Pluto');
        rx.OutputDataType = 'double';
        rx.GainSource='Manual';
        rx.Gain = 20;
        rx.SamplesPerFrame = 1e5;
        tx=sdrtx('Pluto');
        tx.Gain = -30;
        rx.CenterFrequency = rx.CenterFrequency + FrequencyOffset;
        
end


%% CFO Correct
DampingFactor = 0.9;
NormalizedLoopBandwidth =  0.1;
csync = comm.CarrierSynchronizer( ...
    'DampingFactor', DampingFactor, ...
    'NormalizedLoopBandwidth', NormalizedLoopBandwidth, ...
    'SamplesPerSymbol', 1,...
    'Modulation','QPSK',...
    'ModulationPhaseOffset','Custom',...
    'CustomPhaseOffset', PO);

%% Timing
symsync = comm.SymbolSynchronizer( ...
    'TimingErrorDetector','Gardner (non-data-aided)',...
    'SamplesPerSymbol', sampPerSymChan, ...
    'DampingFactor', sqrt(2)/2, ...
    'NormalizedLoopBandwidth', 0.01);

%% Equalization
useEqualizer = true;
% Configure an adaptive equalizer object
stepSize = 0.1; % Step size for LMS algorithm
alg = lms(stepSize);  % Adaptive algorithm object
%forgetFactor = 0.99;  % RLS algorithm forgetting factor
%alg = rls(forgetFactor);  % RLS algorithm object
nFwdWeights = 6;  % Number of feedforward equalizer weights
nFbkWeights = 2;  % Number of feedback filter weights
sampPerSymPostRx = 1;
eqObj = dfe(nFwdWeights, nFbkWeights,alg,PSKConstellation,sampPerSymPostRx);
eqObj.RefTap = 3;
eqDelayInSym = (eqObj.RefTap-1)/sampPerSymPostRx;


%% Visuals
constd = comm.ConstellationDiagram('SamplesPerSymbol', 1,...
    'Name','constd','ReferenceConstellation',PSKConstellation);
constd2 = comm.ConstellationDiagram('SamplesPerSymbol', 1,...
    'Name','constd2','ReferenceConstellation',PSKConstellation);

%% Simulation
nBlocks = 5;  % Number of transmission blocks in simulation
BERvect = zeros(nBlocks,1);
for block = 1:nBlocks
    % Generate data
    txData = randi(hStream, [0 1], nPayload, 1);
    % Add CRC
    txDataWithCRC = crcEnc(txData);
    % Convolutionally encode the data
    txDataEnc = convenc(txDataWithCRC,trellis);
    % Scramble
    txDataScram = scr(txDataEnc);
    % Modulate
    xPayload = step(hPSKMod, txDataScram);
    % Build frame
    x = [xAGCTrain; xPreamble; xTrain; xHeader; xPayload; xTail];  % Transmitted block
    
    % TX filtering
    txSig  = step(hTxFilt, x);            % Transmit filter
    
    % Channel
    switch channel
        case 'qpsk'
            txSigDelayed = [zeros(100*4,1);txSig];
            rxSig = qpskChan(txSigDelayed,block);
        case 'radio'
            tx.release();rx.release();
%            tx = sdrtx('Pluto','Gain',tx.Gain);
            tx.transmitRepeat(txSig);
            %tx(txSig);
            for i=1:3 % Settle AGC
                rxSig = rx();
            end
        case 'basic'
            % Add random delay
            txSigDelayed = [zeros(100,1);txSig];
            %chOut  = step(hRayleighChan, txSig);  % Rayleigh multipath channel
            chOut = fo(txSigDelayed);
            %chOut = filter([zeros(chanFilterDelay,1);1;0;0], 1, txSig);
            chanDelay = vd(chOut, 1); % Variable delay
            rxSig  = step(hAWGNChan, chanDelay);      % AWGN channel
    end
        
    % RX filtering
    rxSamp = step(hRxFilt, rxSig);        % Receive filter
    
    % Timing recover
    rxSampTC = symsync(rxSamp);
    
    % Frequency Correct
    [rxSampFC,phase] = csync(rxSampTC);
    instantaneous_frequency = convertPhaseToFrequency(phase,Rsym,1);
    plot(instantaneous_frequency);
    hold on; plot(1.*ones(size(instantaneous_frequency)).*trueOffset,'r');hold off;
    
    % Locate start of frame
    frame = FindFrameStart(rxSampFC, xPreamble);
    
    if useEqualizer
        % Equalize using equalizer object. First select training and payload
        % samples, accounting for filter delay and equalizer delay.
        rxTrainPlusPayload = frame;
        chanFilterDelay = length(xPreamble)*1;
        rxTrainPayloadSym = dfe_frac(frame, xTrain, 7, 3, 1, PSKConstellation, chanFilterDelay, 4);
        %[rxTrainPayloadSym, ~, err] = equalize(eqObj, rxTrainPayloadSamp, xTrain);
        % Extract and evaluate payload
        %rxPayloadEq = rxTrainPayloadSym(chanFilterDelay + nTrain + (1:nPayload));
        rxPayloadEq = rxTrainPayloadSym((chanFilterDelay + nTrain + 1):end);
    else
        rxPayloadEq = frame((length(xPreamble)*1 + nTrain + 1):end);
    end
    
    %% Visualize constellations
    %inds = constd.MeasurementInterval;
    inds = 1024;
    for k=1:inds:length(rxPayloadEq)-inds
        constd(rxSig(k:k+inds-1));
        constd2(rxPayloadEq(k:k+inds-1));
        pause(0.1);
    end

    %% Demodulate and decode
    rxData = step(hPSKDemod, rxPayloadEq);
    % Decode header and extract payload
    payloadLenA = bi2de(rxData(1:2:32).');
    payloadLenB = bi2de(rxData(2:2:32).');
    if payloadLenA~=payloadLenB
        disp('Header not decoded correctly')
        disp(payloadLenA); disp(payloadLenB);
        continue
    else
        fprintf('Packet Length: %d (Expected %d)\n',payloadLenA,PayloadCodedLen);
    end
    rxData = rxData(33:32+payloadLenA+tbl/rate);
    %rxData = [txDataScram;randi([0 1],2*length(xTail)+tbl/rate,1)];
    % Descramble
    rxDescram = descr(rxData);
    % Viterbi decode the demodulated data
    dataHard = vitdec(rxDescram,trellis,tbl,'cont','hard');
    % Removing coding delay
    rxDataWithTail = dataHard(tbl+1:end);
    % Remove tail bits
    rxDataWithCRC = rxDataWithTail(1:end-nTail);
    % Check CRC
    [rxData,e] = crcDec(rxDataWithCRC);
    if e; disp('CRC Failed'); end
    
    %% Evaluate errors
    plot(cumsum(txData~=rxData));xlabel('Samples');ylabel('Total Errors');
    BEREq = mean(txData~=rxData);
    fprintf('Incorrect bits %d\n',sum(txData~=rxData));
    BERvect(block) = BEREq;
end
avgBER3 = mean(BERvect);
disp(['Mean BER: ',num2str(avgBER3)]);

