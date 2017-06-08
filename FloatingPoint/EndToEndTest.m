clear all; close all;
% Set random number generator for repeatability
hStream   = RandStream.create('mt19937ar', 'seed', 12345);

%% Frame parameters
Rsym      = 1e6;  % Symbol rate (Hz)
nAGCTrain = 100;  % Number of training symbols
nTrain    = 250;  % Number of training symbols
nPayload  = 4e4;  % Number of payload symbols
nTail     = 400;  % Number of tail symbols (enough to flush filters)

%% Frame start marker
barker = comm.BarkerCode('SamplesPerFrame', 14);
seq = barker()+1;
preamble = repmat(seq,2,1);

%% Modulation
bitsPerSym = 2;                              % Number of bits per PSK symbol
M = 2^bitsPerSym;                            % Modulation order
hPSKMod   = comm.PSKModulator(M, ...
    'PhaseOffset',0, ...
    'SymbolMapping','Binary',...
    'BitInput', true);
hPSKDemod = comm.PSKDemodulator(M, ...
    'PhaseOffset',0, ...
    'SymbolMapping','Binary',...
    'BitOutput', true);
hPSKModPreamble   = comm.PSKModulator(M, ...
    'PhaseOffset',0, ...
    'SymbolMapping','Binary');
hPSKModTrain   = comm.PSKModulator(M, ...
    'PhaseOffset',0, ...
    'SymbolMapping','Binary');
PSKConstellation = constellation(hPSKMod).'; % PSK constellation

%% Training
xAGCTrainData = randi(hStream, [0 M-1], nAGCTrain, 1);
xTrainData = randi(hStream, [0 M-1], nTrain, 1);
xTailData  = randi(hStream, [0 M-1], nTail, 1);

xPreamble  = step(hPSKModTrain,preamble);
xAGCTrain  = step(hPSKModTrain,xAGCTrainData);
xTrain     = step(hPSKModTrain,xTrainData);
xTail      = step(hPSKModTrain,xTailData);

%% Filters
chanFilterSpan = 128;  % Filter span in symbols
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
FrequencyOffset = 1000;

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
        rx.SamplesPerFrame = 2^20;
        tx=sdrtx('Pluto');
        rx.CenterFrequency = rx.CenterFrequency + FrequencyOffset;
        
end


%% CFO Correct
DampingFactor = 0.9;
NormalizedLoopBandwidth =  0.1;
csync = comm.CarrierSynchronizer( ...
    'DampingFactor', DampingFactor, ...
    'NormalizedLoopBandwidth', NormalizedLoopBandwidth, ...
    'SamplesPerSymbol', 1,...sampPerSymChan/2
    'Modulation','QPSK',...
    'ModulationPhaseOffset','Custom');

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

%% Channel coding and scrambler
trellis = poly2trellis(7,[171 133]);
tbl = 32;
rate = 1/2;
N = 2;
scr  = comm.Scrambler(N, '1 + z^-2 + z^-3 + z^-5 + z^-7',...
    'InitialConditions',[0 1 0 0 0 1 0]);
descr = comm.Descrambler(N, '1 + z^-2 + z^-3 + z^-5 + z^-7',...
    'InitialConditions',[0 1 0 0 0 1 0]);


%% Visuals
constd = comm.ConstellationDiagram('SamplesPerSymbol', 1,...
    'Name','constd','ReferenceConstellation',PSKConstellation,...
    'MeasurementInterval',1024);
constd2 = comm.ConstellationDiagram('SamplesPerSymbol', 1,...
    'Name','constd2','ReferenceConstellation',PSKConstellation,...
    'MeasurementInterval',1024);

%% Simulation
nBlocks = 1;  % Number of transmission blocks in simulation
BERvect = zeros(nBlocks,1);
for block = 1:nBlocks
    % Generate data
    txData = randi(hStream, [0 1], nPayload*log2(hPSKMod.ModulationOrder)*rate, 1);
    % Convolutionally encode the data
    txDataEnc = convenc(txData,trellis);
    % Scramble
    txDataScram = scr(txDataEnc);
    % Modulate
    xPayload = step(hPSKMod, txDataScram);
    % Build frame
    x = [xAGCTrain; xPreamble; xPreamble; xTrain; xPayload; xTail];  % Transmitted block
    
    % TX filtering
    txSig  = step(hTxFilt, x);            % Transmit filter
    
    % Channel
    switch channel
        case 'qpsk'
            txSigDelayed = [zeros(100*4,1);txSig];
            rxSig = qpskChan(txSigDelayed,block);
        case 'radio'
            tx.transmitRepeat(txSig);
            %tx(txSig);
            for i=1:3
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
    
    % Packet detect
    sigFilt = hRxFiltPD(rxSig);
    found = PacketDetector(sigFilt,xPreamble);
    
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
    frame = FindFrameStart(rxSampFC, [xPreamble;xPreamble]);
    
    if useEqualizer
        % Equalize using equalizer object. First select training and payload
        % samples, accounting for filter delay and equalizer delay.
        rxTrainPlusPayload = frame;
        chanFilterDelay = length(xPreamble)*2;
        rxTrainPayloadSym = dfe_frac(frame, xTrain, 7, 3, 1, PSKConstellation, chanFilterDelay);
        %[rxTrainPayloadSym, ~, err] = equalize(eqObj, rxTrainPayloadSamp, xTrain);
        % Extract and evaluate payload
        rxPayloadEq = rxTrainPayloadSym(chanFilterDelay + nTrain + (1:nPayload));
    else
        rxPayloadEq = frame(length(xPreamble)*2 + nTrain + (1:nPayload));
    end
    
    %% Visualize constellations
    inds = constd.MeasurementInterval;
    for k=1:inds:length(rxPayloadEq)-inds
        constd(rxSig(k:k+inds-1));
        constd2(rxPayloadEq(k:k+inds-1));
        pause(0.1);
    end
    
    %% Demodulate and decode
    rxData = step(hPSKDemod, rxPayloadEq);
    % Descramble
    rxDescram = descr(rxData);
    % Viterbi decode the demodulated data
    dataHard = vitdec(rxDescram,trellis,tbl,'cont','hard');
    % Removing coding delay
    rxData = dataHard(tbl+1:end);
    
    %% Evaluate errors
    plot(cumsum(txData(1:end-tbl)~=rxData));xlabel('Samples');ylabel('Total Errors');
    %[~, BEREq] = biterr(txData, rxData);
    %yErrEq = nan(nPayload, 1);
    %yErrEq(rxData ~= txData) = rxPayloadEq(rxData ~= txData);
    BEREq = mean(txData(1:end-tbl)~=rxData);
    fprintf('Incorrect bits %d\n',sum(txData(1:end-tbl)~=rxData));
    BERvect(block) = BEREq;
end
avgBER3 = mean(BERvect);
disp(['Means BER: ',num2str(avgBER3)]);

