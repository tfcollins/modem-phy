% This test evaluates the deployed TX and RX designs with the DMA model
% embedded in the TX design where we only control the packet lengths

centerFreq = 2.4e9;
packetLen = 8*12;

%% Setup and Start TX
load_system('tx');
set_param('tx/PacketBytes','Value',['int16(',num2str(int16(packetLen)),')'])
set_param('tx','SimulationCommand','start')
while ~strcmp(get_param('tx','SimulationStatus'),'running')
    pause(0.1);
end
pause(4);

%% Setup RX
rx=sdrrx('ZC706 and FMCOMMS2/3/4', 'BasebandSampleRate', 20e6);rx.BypassUserLogic = false;
rx.CenterFrequency = centerFreq; rx.SamplesPerFrame = 2^16;

%% Evaluate
validPackets = 0;
errorPackets = 0;
badPacketsLengths = 0;

for n=1:1e4
    d = rx();
    r = real(d);
    i = imag(d);
    
    loc = find(r~=1);
        
    errorPackets = errorPackets + sum(r(loc)==4);
    validPackets = validPackets + sum(r(loc)==3);
    badPacketsLengths = badPacketsLengths + sum(i(loc)~=packetLen);    
end
clear rx;

fprintf('Valid %d | Failures %d | Bad Lengths %d\n',validPackets,errorPackets,badPacketsLengths);

%% Stop TX
set_param('tx','SimulationCommand','stop')
close_system('tx',false);
