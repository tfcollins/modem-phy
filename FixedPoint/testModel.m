%% User parameters
packetsToRecover = 10;
allowedMissedPackets = 2;
testFilenames = {'Pluto_0kHz_off.bb','Pluto_1kHz_off.bb',...
    'Pluto_2kHz_off.bb','Pluto_3kHz_off.bb','Pluto_4kHz_off.bb',...
    'Pluto_5kHz_off.bb'};


% Notes for changes
% Get Parameters
% get_param('RadioReceiver_FP_clean_Test/BBSource','DialogParameters')

%% PCT Setup
model = 'RadioReceiver_FP_clean_Test';
load_system(model);
parpool;
spmd
    % Setup tempdir and cd into it
    currDir = pwd;
    addpath(currDir);
    tmpDir = tempname;
    mkdir(tmpDir);
    cd(tmpDir);
    % Load the model on the worker
    load_system(model);
end



parfor testNum = 1:length(testFilenames)
    % Run Sim
    [gotPackets,allCRCValid,numRecovered,crcVals,crcHDL] = ...
        runModel(testFilenames{testNum},packetsToRecover,allowedMissedPackets);
    % Evaluate Results
    if gotPackets && allCRCValid
        % All CRC checks passed
        disp(['Passed checks: ', testFilenames{testNum}]);
        disp(['Recovered: ',num2str(numRecovered)]);
        disp(['CRC: ',num2str(crcVals.')]);
        disp(['CRCHDL: ',num2str(squeeze(crcHDL).')]);
    else
        % CRC Errors
        disp(['Failed checks: ', testFilenames{testNum}]);
        disp(['Recovered: ',num2str(numRecovered)]);
        disp(['CRC: ',num2str(crcVals.')]);
        disp(['CRCHDL: ',num2str(squeeze(crcHDL).')]);
    end
end


spmd
    cd(currDir);
    rmdir(tmpDir,'s');
    rmpath(currDir);
    close_system(model, 0);
end

close_system(model, 0);
delete(gcp('nocreate'));

