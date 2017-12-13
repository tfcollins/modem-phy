%% Transmitter for simulink model
%clear all;
%% AGC Preamble
reps = 10;
barker = comm.BarkerCode('SamplesPerFrame', 16, 'Length', 13);
seq = barker()+1;
AGCPreamble = repmat(seq,reps,1);

%% Fine timing recovery preamble
barker = comm.BarkerCode('SamplesPerFrame', 28, 'Length', 11);
TimingPreamble = barker()+1;

%% DFE training data
modulatedSymbols = 250;
bitsPerSample = 2;
pnseq = comm.PNSequence('Polynomial', 'z^5 + z^3 + z^1 + 1', ...
    'SamplesPerFrame', modulatedSymbols*bitsPerSample, 'InitialConditions', [1 1 1 0 0]);
DFETraining = pnseq();

%% Payload
M = 4;
nPayloadSymbols  = 8*200;  % Number of payload symbols (QPSK and 1/2 rate coding==bits)
rate = 1/2;
%txData = randi([0 1], nPayloadSymbols*log2(M)*rate, 1);
txData = repmat([0;1], nPayloadSymbols*log2(M)*rate/2, 1); % Repeating [0 1]

%txData(1:64) = zeros(64,1);
%txData(1) = 1;
%txData(end-63:end) = ones(64,1);

% Add end sequence to check at receiver
xTailData = repmat([1 0 1 1 0 0 1 1 1 1].',4,1);
% Add bits to deal with viterbi lag
tbl = 34;
lagBits = randi([0 1],1*tbl/rate,1);
crc = comm.CRCGenerator('Polynomial','z^32 + z^26 + z^23 + z^22 + z^16 + z^12 + z^11 + z^10 + z^8 + z^7 + z^5 + z^4 + z^2 + z + 1');
frame = [crc(txData); xTailData; lagBits];
%frame = [crc(txData)];
disp(length([crc(txData); xTailData]));

% Convolutionally encode the data
trellis = poly2trellis(7,[171 133]);
txDataEnc = convenc(frame,trellis);
% Scramble
N = 2;
scr  = comm.Scrambler(N, '1 + z^-1 + z^-3 + z^-5+ z^-7',...
    'InitialConditions',[0 1 0 0 0 1 0]);
txDataScram = scr(txDataEnc);

%% Header
HeaderLen = 16; % Bits
PayloadCodedLen = (length(frame)+0)/rate;
%PayloadCodedLen = 3480;
HeaderData = bitget(PayloadCodedLen,1:HeaderLen).';

% Repeatatively encode bits
HeaderDataPad = reshape([HeaderData HeaderData].',1,HeaderLen*2).';


%% Last packet pad
endPad = 1e3;
padDataEnd = randi([0 3],endPad,1);

%% Modulate
qBits = comm.QPSKModulator('BitInput',true,'SymbolMapping','Binary');
qInts = comm.QPSKModulator('BitInput',false,'SymbolMapping','Binary');

fullFrame = [qInts(AGCPreamble);...
    qInts(TimingPreamble);...
    qBits(DFETraining);...
    qBits(HeaderDataPad);...
    qBits(txDataScram);...
    qInts(padDataEnd)];

%% Filter
chanFilterSpan = 8;  % Filter span in symbols
sampPerSymChan = 4;  % Samples per symbol through channels
hTxFilt = comm.RaisedCosineTransmitFilter( ...
    'RolloffFactor',0.5, ...
    'FilterSpanInSymbols',chanFilterSpan, ...
    'OutputSamplesPerSymbol',sampPerSymChan);

fullFrameFilt = hTxFilt(fullFrame);

%% Save to mat files
HeaderBytes = bitget(nPayloadSymbols/8,1:HeaderLen).';
words16bits = bi2de(reshape([HeaderBytes;txData],16,length([HeaderBytes;txData])/16).','right-msb');
HeaderBytes = bitget(nPayloadSymbols/8,1:64).';
words64bits = bi2de(reshape([HeaderBytes;txData],64,length([HeaderBytes;txData])/64).','right-msb');
save('words16bits.mat','words16bits');
save('words64bits.mat','words64bits');
save('IQData.mat','fullFrameFilt');


% %% Radio
% % Setup radios
% centerFreq = 2.42e9;%950e6;
% tx=sdrtx('ZC706 and FMCOMMS2/3/4', 'BasebandSampleRate', 20e6);tx.BypassUserLogic = true;
% %tx=sdrtx('Pluto', 'RadioID', 'usb:0', 'BasebandSampleRate', 20e6,'Gain',-20);
% tx.CenterFrequency = centerFreq;
% tx.transmitRepeat(fullFrameFilt);
% pause(1);
% 
% %rx=sdrrx('ZC706 and FMCOMMS2/3/4', 'BasebandSampleRate', 20e6);rx.BypassUserLogic = true;
% rx=sdrrx('Pluto', 'RadioID', 'usb:0', 'BasebandSampleRate', 20e6);
% rx.CenterFrequency = centerFreq; rx.SamplesPerFrame = 2^16;
% %data = rx();data = rx();data = rx();
% data = rx();%data = rx();
% a = comm.BasebandFileWriter;
% a(data);
% a.release();
% clear rx tx



