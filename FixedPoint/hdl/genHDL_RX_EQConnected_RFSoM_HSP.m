%--------------------------------------------------------------------------
% HDL Workflow Script
% Generated with MATLAB 9.3 (R2017b) at 13:53:18 on 02/11/2017
% This script was generated using the following parameter values:
%     Filename  : '/backup/modem-fix/FixedPoint/genHDL_RX_EQConnected_RFSoM_HSP.m'
%     Overwrite : true
%     Comments  : true
%     Headers   : true
%     DUT       : 'Receiver/Receiver HDL'
% To view changes after modifying the workflow, run the following command:
% >> hWC.export('DUT','Receiver/Receiver HDL');
%--------------------------------------------------------------------------

%% Load the Model
load_system('Receiver');

%% Restore the Model to default HDL parameters
%hdlrestoreparams('Receiver/Receiver HDL');

%% Model HDL Parameters
%% Set Model 'Receiver' HDL parameters
hdlset_param('Receiver', 'BalanceDelays', 'off');
hdlset_param('Receiver', 'CriticalPathEstimation', 'on');
hdlset_param('Receiver', 'HDLGenerateWebview', 'on');
hdlset_param('Receiver', 'HDLSubsystem', 'Receiver/Receiver HDL');
hdlset_param('Receiver', 'OptimizationReport', 'on');
hdlset_param('Receiver', 'ReferenceDesign', 'Receive path');
hdlset_param('Receiver', 'ReferenceDesignParameter', {'ChannelMapping','1','DUTSynthFreqMHz','20'});
hdlset_param('Receiver', 'SynthesisTool', 'Xilinx Vivado');
hdlset_param('Receiver', 'SynthesisToolChipFamily', 'Zynq');
hdlset_param('Receiver', 'SynthesisToolDeviceName', 'xc7z035i');
hdlset_param('Receiver', 'SynthesisToolPackageName', 'fbg676');
hdlset_param('Receiver', 'SynthesisToolSpeedValue', '-2L');
hdlset_param('Receiver', 'TargetDirectory', 'hdl_prj_rx/hdlsrc');
hdlset_param('Receiver', 'TargetPlatform', 'ADI RF SOM');
hdlset_param('Receiver', 'Workflow', 'IP Core Generation');

% Set SubSystem HDL parameters
hdlset_param('Receiver/Receiver HDL', 'ProcessorFPGASynchronization', 'Free running');

% Set Inport HDL parameters
hdlset_param('Receiver/Receiver HDL/re', 'IOInterface', 'Rx data I1 In [0:15]');
hdlset_param('Receiver/Receiver HDL/re', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('Receiver/Receiver HDL/Im', 'IOInterface', 'Rx data Q1 In [0:15]');
hdlset_param('Receiver/Receiver HDL/Im', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('Receiver/Receiver HDL/Enable', 'IOInterface', 'Rx data Valid In');
hdlset_param('Receiver/Receiver HDL/Enable', 'IOInterfaceMapping', '[0]');

% Set SubSystem HDL parameters
hdlset_param('Receiver/Receiver HDL/CRC Check and DMA Pack', 'BalanceDelays', 'on');

% Set SubSystem HDL parameters
hdlset_param('Receiver/Receiver HDL/Frame Recover', 'BalanceDelays', 'on');

% Set Outport HDL parameters
hdlset_param('Receiver/Receiver HDL/bytesOut', 'IOInterface', 'No Interface Specified');
hdlset_param('Receiver/Receiver HDL/bytesOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('Receiver/Receiver HDL/validOut', 'IOInterface', 'No Interface Specified');
hdlset_param('Receiver/Receiver HDL/validOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('Receiver/Receiver HDL/sync', 'IOInterface', 'No Interface Specified');
hdlset_param('Receiver/Receiver HDL/sync', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('Receiver/Receiver HDL/payloadLenOut', 'IOInterface', 'No Interface Specified');
hdlset_param('Receiver/Receiver HDL/payloadLenOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('Receiver/Receiver HDL/dataRe', 'IOInterface', 'Rx data I1 Out [0:15]');
hdlset_param('Receiver/Receiver HDL/dataRe', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('Receiver/Receiver HDL/dataIm', 'IOInterface', 'Rx data Q1 Out [0:15]');
hdlset_param('Receiver/Receiver HDL/dataIm', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('Receiver/Receiver HDL/validEQ', 'IOInterface', 'Rx data Valid Out');
hdlset_param('Receiver/Receiver HDL/validEQ', 'IOInterfaceMapping', '[0]');


%% Workflow Configuration Settings
% Construct the Workflow Configuration Object with default settings
hWC = hdlcoder.WorkflowConfig('SynthesisTool','Xilinx Vivado','TargetWorkflow','IP Core Generation');

% Specify the top level project directory
hWC.ProjectFolder = 'hdl_prj_rx';
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
hWC.ProgrammingMethod = hdlcoder.ProgrammingMethod.Download;

% Validate the Workflow Configuration Object
hWC.validate;

%% Run the workflow
hdlcoder.runWorkflow('Receiver/Receiver HDL', hWC);

%% Check passed timing
checkTimingReport(hWC.ProjectFolder);

%% Close Model
close_system('Receiver',0)

