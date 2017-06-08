%% Test Packet Detector

clear all; close all;
% Set random number generator for repeatability
hStream   = RandStream.create('mt19937ar', 'seed', 12345);

%% Frame parameters
Rsym      = 1e6;  % Symbol rate (Hz)
nAGCTrain = 100;  % Number of training symbols
nTrain    = 1000;  % Number of training symbols
nPayload  = 1e4;  % Number of payload symbols
nTail     = 20;   % Number of tail symbols

%% Frame start marker
barker = comm.BarkerCode('SamplesPerFrame', 14);
seq = barker()+1;
preamble = repmat(seq,2,1);

%% Modulation
bitsPerSym = 2;                              % Number of bits per PSK symbol
M = 2^bitsPerSym;                            % Modulation order
hPSKMod   = comm.PSKModulator(M, ...
    'PhaseOffset',0, ...
    'SymbolMapping','Binary');
hPSKDemod = comm.PSKDemodulator(M, ...
    'PhaseOffset',0, ...
    'SymbolMapping','Binary');
hPSKModPreamble   = comm.PSKModulator(M, ...
    'PhaseOffset',0, ...
    'SymbolMapping','Binary');
PSKConstellation = constellation(hPSKMod).'; % PSK constellation

%% Training
xAGCTrainData = randi(hStream, [0 M-1], nAGCTrain, 1);
xTrainData = randi(hStream, [0 M-1], nTrain, 1);
xTailData  = randi(hStream, [0 M-1], nTail, 1);

xPreamble  = step(hPSKMod,preamble);
xAGCTrain  = step(hPSKMod,xAGCTrainData);
xTrain     = step(hPSKMod,xTrainData);
xTail      = step(hPSKMod,xTailData);

%% Filters
chanFilterSpan = 5;  % Filter span in symbols
sampPerSymChan = 4;  % Samples per symbol through channels
hTxFilt = comm.RaisedCosineTransmitFilter( ...
    'RolloffFactor',0.5, ...
    'FilterSpanInSymbols',chanFilterSpan, ...
    'OutputSamplesPerSymbol',sampPerSymChan);

hRxFilt = comm.RaisedCosineReceiveFilter( ...
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
    'EsNo',30, ...
    'SamplesPerSymbol',sampPerSymChan);

% Configure a frequency-flat Rayleigh channel System object with the
% RandomStream property set to 'mt19937ar with seed' for repeatability.
hRayleighChan = comm.RayleighChannel( ...
    'SampleRate',Rsym, ...
    'MaximumDopplerShift',30);

% Frequency Offset
trueOffset = 1000;
fo = comm.PhaseFrequencyOffset('SampleRate', Rsym,...
    'FrequencyOffset', trueOffset);
% Timing offset
vd = dsp.VariableFractionalDelay;

%% Channel
channel = 'qpsk';
FrequencyOffset = 1000;

switch channel
    case 'qpsk'
        DelayType = 'Triangle';
        FilterSpan = chanFilterSpan;
        PhaseOffset = 45;
        FrameSize = nPayload;
        UpSample = sampPerSymChan;
        EbNo = 130;
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

%% Simulation
nBlocks = 10;  % Number of transmission blocks in simulation
frequencyOffsets = 0:100:4000;
snrs = -10:2:10;
errors = zeros(length(frequencyOffsets),nBlocks,length(snrs));
for s = 1:length(snrs)
for f = 1:length(frequencyOffsets)
for block = 1:nBlocks
    % Generate data
    txData = randi(hStream, [0 hPSKMod.ModulationOrder-1], nPayload, 1);
    xPayload = step(hPSKMod, txData);  % Payload symbols
    x = [xAGCTrain; xPreamble; xPreamble; xTrain; xPayload; xTail];  % Transmitted block
    
    % TX filtering
    txSig  = step(hTxFilt, x);            % Transmit filter
    
    % Add random offset
    trueOffset = 1e3;%randi([25,1e3])*sampPerSymChan;
    txSig = [zeros(trueOffset*sampPerSymChan,1); txSig]; %#ok<AGROW>
    
    % Channel
    switch channel
        case 'qpsk'
            qpskChan.release();
            qpsk.EbNo = snrs(s);
            qpskChan.FrequencyOffset = frequencyOffsets(f);
            rxSig = qpskChan(txSig,frameCount);
        case 'radio'
            tx.transmitRepeat(txSig);
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
    
    % RX filtering
    rxSamp = step(hRxFilt, rxSig);
    
    % Locate start of frame
    [frame, startIndx] = FindFrameStart(rxSamp, [xPreamble; xPreamble]);
    
    errors(f,block,s) = abs(startIndx - (nAGCTrain+trueOffset));
    
end
end
end
%% Plot
plot(frequencyOffsets, squeeze(mean(errors,2)));
xlabel('Frequency Offset (Hz)');
ylabel('Estimation Error (Samples)');
str = {};
for i=1:length(snrs)
    str = {str{:},['EbNo ',num2str(snrs(i))]};
end
legend(str);



