%% Transmitter for simulink model
clear all;
%% AGC Preamble
reps = 10;
barker = comm.BarkerCode('SamplesPerFrame', 16, 'Length', 13);
seq = barker()+1;
%preamble = zeros(16*reps,1);
AGCPreamble = repmat(seq,reps,1);

%% Fine timing recovery preamble
barker = comm.BarkerCode('SamplesPerFrame', 28, 'Length', 11);
TimingPreamble = barker()+1;

%% DFE training data
modulatedSymbols = 250;
bitsPerSample = 2;
pnseq = comm.PNSequence('Polynomial', 'z^3 + z^2 + 1', ...
    'SamplesPerFrame', modulatedSymbols*bitsPerSample, 'InitialConditions', [0 0 1]);
DFETraining = pnseq();

%% Payload
M = 4;
nPayloadSymbols  = 8*200;  % Number of payload symbols (QPSK and 1/2 rate coding==bits)
rate = 1/2;
txData = randi([0 1], nPayloadSymbols*log2(M)*rate, 1);
% Add end sequence to check at receiver
xTailData = repmat([1 0 1 1 0 0 1 1 1 1].',4,1);
% Add bits to deal with viterbi lag
tbl = 34;
lagBits = randi([0 1],1*tbl/rate,1);
crc = comm.CRCGenerator('Polynomial','z^32 + z^26 + z^23 + z^22 + z^16 + z^12 + z^11 + z^10 + z^8 + z^7 + z^5 + z^4 + z^2 + z + 1');
%b=[1 1 1 0 1 1 0 1 1 0 1 1 1 0 0 0 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 0 1]
%
%a=[1 0 0 0 0 0 1 0 0 1 1 0 0 0 0 0 1 0 0 0 1 1 1 0 1 1 0 1 1 0 1 1 1]

%txData(end-15:end) = ones(16,1);
txData((1:32)+0) = ones(32,1);
frame = [crc(txData); xTailData; lagBits];
disp(length([crc(txData); xTailData]));

% Convolutionally encode the data
trellis = poly2trellis(7,[171 133]);
txDataEnc = convenc(frame,trellis);
% Scramble
N = 2;
scr  = comm.Scrambler(N, '1 + z^-1 + z^-3 + z^-5+ z^-7',...
    'InitialConditions',[0 1 0 0 0 1 0]);
txDataScram = scr(txDataEnc);
%txDataScram = scr(frame);
%txDataScram = frame;

%% Test
crcD = comm.CRCDetector('Polynomial','z^32 + z^26 + z^23 + z^22 + z^16 + z^12 + z^11 + z^10 + z^8 + z^7 + z^5 + z^4 + z^2 + z + 1');
[~,e] = crcD(frame(1:length(crc(txData))));


%% Header
HeaderLen = 16; % Bits
PayloadCodedLen = (length(frame)+0)/rate;
HeaderData = bitget(PayloadCodedLen,1:HeaderLen).';
%de = comm.DifferentialEncoder;
%HeaderData = de(HeaderData);
%de.reset();
% Differential reset to front of header
%HeaderDataPad = [ 0; 0; HeaderData];
%HeaderDataPad = HeaderData;

% Repeatatively encode bits
HeaderDataPad = reshape([HeaderData HeaderData].',1,HeaderLen*2).';



%% Modulate
qBits = comm.QPSKModulator('BitInput',true,'SymbolMapping','Binary');
qInts = comm.QPSKModulator('BitInput',false,'SymbolMapping','Binary');

fullFrame = [qInts(AGCPreamble);...
    qInts(TimingPreamble);...
    qBits(DFETraining);...
    qBits(HeaderDataPad);...
    qBits(txDataScram)];

%% Filter
chanFilterSpan = 8;  % Filter span in symbols
sampPerSymChan = 4;  % Samples per symbol through channels
hTxFilt = comm.RaisedCosineTransmitFilter( ...
    'RolloffFactor',0.5, ...
    'FilterSpanInSymbols',chanFilterSpan, ...
    'OutputSamplesPerSymbol',sampPerSymChan);

fullFrame = hTxFilt(fullFrame);
%% Radio
% Setup radios
centerFreq = 900e6;
tx=sdrtx('Pluto','RadioID','usb:0');
tx.CenterFrequency = centerFreq;
tx.transmitRepeat(fullFrame);

