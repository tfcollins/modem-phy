function [gotPackets,allCRCValid,recoveredPackets,crcDebug,crcHDL] = runModel(fn,packetsToRecover,allowedMissedPackets)

sampleRate = 1e6;
modelName = 'RadioReceiver_FP_clean_Test';
disp(fn);

%% Drive model with different inputs
packetLen = length(TransmitData());
runTime = packetLen*packetsToRecover/sampleRate;

% Change input file
fileSourceName = 'BBSource';
set_param([modelName,'/',fileSourceName],'Filename',fn);

orig_state = warning;
warning('off','all')

% Start sim
options=simset('SrcWorkspace','current','DstWorkspace','current'); 
sim(modelName, [0 runTime], options);
warning(orig_state);

% set_param(modelName,'SimulationCommand','start');
% simTime = get_param(modelName,'SimulationTime');
% sLen = 0;
% while simTime<runTime
%     pause(0.01);
%     fprintf(repmat('\b',1,sLen));
%     simTime = get_param(modelName,'SimulationTime');
%     str = sprintf('Model Tme: %1.5f | Target %1.5f',simTime,runTime);
%     fprintf(str);
%     sLen = length(str);
% end
% fprintf('\n');
% 
% % Stop simulation
% set_param(modelName,'SimulationCommand','stop');

% Check results
recoveredPackets = length(crcConditions.signals.values);
allCRCValid = sum(crcConditions.signals.values) == recoveredPackets;
crcHDL = crcHDL.signals.values;
crcDebug = crcConditions.signals.values;

% Eval packets in data
%bb = comm.BasebandFileReader('Filename',fn);
%numSamples = bb.info.NumSamplesInData;
%packetsToRecover = floor(numSamples/packetLen);
gotPackets = recoveredPackets >= (packetsToRecover-allowedMissedPackets);

%%
if gotPackets && allCRCValid
    % All CRC checks passed
    disp('Passed checks');
else
    % CRC Errors
    disp('Failed checks');
end

%% Set workspace back to original
%simset(old_opt,'DstWorkspace','base');

