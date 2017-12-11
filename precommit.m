
hdlCheck = false;
models = [...
    struct('folder','FixedPoint','name','combinedTxRx','HDLSubsystem','Combined TX and RX');...
    struct('folder','FixedPoint','name','combinedTxRx_ADIDMA','HDLSubsystem','Combined TX and RX');...
    struct('folder','FixedPoint','name','Receiver','HDLSubsystem','Receiver HDL');...
    struct('folder','FixedPoint','name','Transmitter','HDLSubsystem','Tx Under Test');...
    struct('folder','FloatingPoint','name','RadioReceiver','HDLSubsystem','');...
    struct('folder','test','name','Receiver_UnderTest_Float','HDLSubsystem','');...
    struct('folder','test','name','Receiver_UnderTest_Fixed','HDLSubsystem','Receiver HDL')...
    ];

%% Check models to make sure they compile without errors
for m = 1:length(models)
    cd(models(m).folder)
    fprintf('Checking model: %s\n',models(m).name);
    open_system(models(m).name,'loadonly');
    set_param(models(m).name,'SimulationCommand','Update');
    close_system(models(m).name);
    cd ..
end

%% Check models to make sure they can generate HDL (without synthesis)
if hdlCheck
    for m = 1:length(models)
        if ~strfind(models(m).folder,'Fixed')
            continue;
        end
        cd(models(m).folder)
        fprintf('Checking model HDL compatibility: %s\n',models(m).name);
        open_system(models(m).name,'loadonly');
        makehdl([models(m).name,'/',models(m).HDLSubsystem]);
        close_system(models(m).name);
        cd ..
    end
end
