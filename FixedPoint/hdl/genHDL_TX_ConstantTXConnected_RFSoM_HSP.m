%--------------------------------------------------------------------------
% HDL Workflow Script
% Generated with MATLAB 9.3 (R2017b) at 14:20:07 on 02/11/2017
% This script was generated using the following parameter values:
%     Filename  : '/backup/modem-fix/FixedPoint/genHDL_TX_ConstantTXConnected_RFSoM_HSP.m'
%     Overwrite : true
%     Comments  : true
%     Headers   : true
%     DUT       : 'Transmitter/Tx Under Test'
% To view changes after modifying the workflow, run the following command:
% >> hWC.export('DUT','Transmitter/Tx Under Test');
%--------------------------------------------------------------------------

%% Load the Model
load_system('Transmitter');

%% Restore the Model to default HDL parameters
%hdlrestoreparams('Transmitter/Tx Under Test');

%% Model HDL Parameters
%% Set Model 'Transmitter' HDL parameters
hdlset_param('Transmitter', 'HDLSubsystem', 'Transmitter/Tx Under Test');
hdlset_param('Transmitter', 'ReferenceDesign', 'Transmit path');
hdlset_param('Transmitter', 'ReferenceDesignParameter', {'ChannelMapping','1','DUTSynthFreqMHz','20'});
hdlset_param('Transmitter', 'SynthesisTool', 'Xilinx Vivado');
hdlset_param('Transmitter', 'SynthesisToolChipFamily', 'Zynq');
hdlset_param('Transmitter', 'SynthesisToolDeviceName', 'xc7z035i');
hdlset_param('Transmitter', 'SynthesisToolPackageName', 'fbg676');
hdlset_param('Transmitter', 'SynthesisToolSpeedValue', '-2L');
hdlset_param('Transmitter', 'TargetDirectory', 'hdl_prj_tx/hdlsrc');
hdlset_param('Transmitter', 'TargetPlatform', 'ADI RF SOM');
hdlset_param('Transmitter', 'Workflow', 'IP Core Generation');

% Set SubSystem HDL parameters
hdlset_param('Transmitter/Tx Under Test', 'ProcessorFPGASynchronization', 'Free running');

% Set Inport HDL parameters
hdlset_param('Transmitter/Tx Under Test/In1', 'IOInterface', 'Tx data Valid In');
hdlset_param('Transmitter/Tx Under Test/In1', 'IOInterfaceMapping', '[0]');

% Set Inport HDL parameters
hdlset_param('Transmitter/Tx Under Test/r ', 'IOInterface', 'Tx data I1 In [0:15]');
hdlset_param('Transmitter/Tx Under Test/r ', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('Transmitter/Tx Under Test/i', 'IOInterface', 'Tx data Q1 In [0:15]');
hdlset_param('Transmitter/Tx Under Test/i', 'IOInterfaceMapping', '[0:15]');

% Set SubSystem HDL parameters
hdlset_param('Transmitter/Tx Under Test/Transmitter HDL', 'ProcessorFPGASynchronization', 'Free running');

% Set Inport HDL parameters
hdlset_param('Transmitter/Tx Under Test/Transmitter HDL/bytesIn', 'IOInterface', 'Tx data I1 In [0:15]');
hdlset_param('Transmitter/Tx Under Test/Transmitter HDL/bytesIn', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('Transmitter/Tx Under Test/Transmitter HDL/validIn', 'IOInterface', 'Tx data Valid In');
hdlset_param('Transmitter/Tx Under Test/Transmitter HDL/validIn', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('Transmitter/Tx Under Test/Transmitter HDL/Packet Generation/trueData', 'IOInterface', 'Tx data Valid Out');
hdlset_param('Transmitter/Tx Under Test/Transmitter HDL/Packet Generation/trueData', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('Transmitter/Tx Under Test/Transmitter HDL/real', 'IOInterface', 'Tx data I1 Out [0:15]');
hdlset_param('Transmitter/Tx Under Test/Transmitter HDL/real', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('Transmitter/Tx Under Test/Transmitter HDL/imag', 'IOInterface', 'Tx data Q1 Out [0:15]');
hdlset_param('Transmitter/Tx Under Test/Transmitter HDL/imag', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('Transmitter/Tx Under Test/Transmitter HDL/validOut', 'IOInterface', 'Tx data Valid Out');
hdlset_param('Transmitter/Tx Under Test/Transmitter HDL/validOut', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('Transmitter/Tx Under Test/Transmitter HDL/Need Data', 'IOInterface', 'No Interface Specified');
hdlset_param('Transmitter/Tx Under Test/Transmitter HDL/Need Data', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('Transmitter/Tx Under Test/Out1', 'IOInterface', 'Tx data I1 Out [0:15]');
hdlset_param('Transmitter/Tx Under Test/Out1', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('Transmitter/Tx Under Test/Out2', 'IOInterface', 'Tx data Q1 Out [0:15]');
hdlset_param('Transmitter/Tx Under Test/Out2', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('Transmitter/Tx Under Test/Out3', 'IOInterface', 'Tx data Valid Out');
hdlset_param('Transmitter/Tx Under Test/Out3', 'IOInterfaceMapping', '[0]');


%% Workflow Configuration Settings
% Construct the Workflow Configuration Object with default settings
hWC = hdlcoder.WorkflowConfig('SynthesisTool','Xilinx Vivado','TargetWorkflow','IP Core Generation');

% Specify the top level project directory
hWC.ProjectFolder = 'hdl_prj_tx';
hWC.ReferenceDesignToolVersion = '2016.4';
hWC.IgnoreToolVersionMismatch = false;

% Set Workflow tasks to run
hWC.RunTaskGenerateRTLCodeAndIPCore = true;
hWC.RunTaskCreateProject = true;
hWC.RunTaskGenerateSoftwareInterfaceModel = false;
hWC.RunTaskBuildFPGABitstream = true;
hWC.RunTaskProgramTargetDevice = false;

% Set properties related to 'RunTaskGenerateRTLCodeAndIPCore' Task
hWC.IPCoreRepository = '';
hWC.GenerateIPCoreReport = true;

% Set properties related to 'RunTaskCreateProject' Task
hWC.Objective = hdlcoder.Objective.None;
hWC.AdditionalProjectCreationTclFiles = '';
hWC.EnableIPCaching = false;

% Set properties related to 'RunTaskGenerateSoftwareInterfaceModel' Task
hWC.OperatingSystem = '';

% Set properties related to 'RunTaskBuildFPGABitstream' Task
hWC.RunExternalBuild = false;
hWC.TclFileForSynthesisBuild = hdlcoder.BuildOption.Default;
hWC.CustomBuildTclFile = '';

% Set properties related to 'RunTaskProgramTargetDevice' Task
%hWC.ProgrammingMethod = hdlcoder.ProgrammingMethod.Download;

% Validate the Workflow Configuration Object
hWC.validate;

%% Run the workflow
hdlcoder.runWorkflow('Transmitter/Tx Under Test', hWC);

%% Check passed timing
checkTimingReport(hWC.ProjectFolder);

%% Close model
close_system('Transmitter',0);
