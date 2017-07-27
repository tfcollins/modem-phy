%--------------------------------------------------------------------------
% HDL Workflow Script
% Generated with MATLAB 9.2 (R2017a) at 18:44:13 on 26/07/2017
% This script was generated using the following parameter values:
%     Filename  : '/home/tcollins/git/modem-phy/FixedPoint/hdlworkflow.m'
%     Overwrite : true
%     Comments  : true
%     Headers   : true
%     DUT       : 'RadioReceiver_FP_clean_Test/Receiver'
% To view changes after modifying the workflow, run the following command:
% >> hWC.export('DUT','RadioReceiver_FP_clean_Test/Receiver');
%--------------------------------------------------------------------------

%% Load the Model
load_system('RadioReceiver_FP_clean_Test');

%% Restore the Model to default HDL parameters
%hdlrestoreparams('RadioReceiver_FP_clean_Test/Receiver');

%% Model HDL Parameters
%% Set Model 'RadioReceiver_FP_clean_Test' HDL parameters
hdlset_param('RadioReceiver_FP_clean_Test', 'CriticalPathEstimation', 'on');
hdlset_param('RadioReceiver_FP_clean_Test', 'HDLGenerateWebview', 'on');
hdlset_param('RadioReceiver_FP_clean_Test', 'HDLSubsystem', 'RadioReceiver_FP_clean_Test/Receiver');
hdlset_param('RadioReceiver_FP_clean_Test', 'OptimizationReport', 'on');
hdlset_param('RadioReceiver_FP_clean_Test', 'ReferenceDesign', 'Receive path');
hdlset_param('RadioReceiver_FP_clean_Test', 'ReferenceDesignParameter', {'ChannelMapping','1','DUTSynthFreqMHz','20'});
hdlset_param('RadioReceiver_FP_clean_Test', 'SynthesisTool', 'Xilinx Vivado');
hdlset_param('RadioReceiver_FP_clean_Test', 'SynthesisToolChipFamily', 'Zynq');
hdlset_param('RadioReceiver_FP_clean_Test', 'SynthesisToolDeviceName', 'xc7z045');
hdlset_param('RadioReceiver_FP_clean_Test', 'SynthesisToolPackageName', 'ffg900');
hdlset_param('RadioReceiver_FP_clean_Test', 'SynthesisToolSpeedValue', '-2');
hdlset_param('RadioReceiver_FP_clean_Test', 'TargetDirectory', 'hdl_prj/hdlsrc');
hdlset_param('RadioReceiver_FP_clean_Test', 'TargetPlatform', 'ZC706 and FMCOMMS2/3/4');
hdlset_param('RadioReceiver_FP_clean_Test', 'Workflow', 'IP Core Generation');

% Set SubSystem HDL parameters
hdlset_param('RadioReceiver_FP_clean_Test/Receiver', 'ProcessorFPGASynchronization', 'Free running');

% Set Inport HDL parameters
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/re', 'IOInterface', 'Rx data I1 In [0:15]');
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/re', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/Im', 'IOInterface', 'Rx data Q1 In [0:15]');
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/Im', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/Enable', 'IOInterface', 'Rx data Valid In');
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/Enable', 'IOInterfaceMapping', '[0]');

% Set Gain HDL parameters
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/Gardner Timing Recovery/Loop Filt', 'ConstMultiplierOptimization', 'csd');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/dataOut', 'IOInterface', 'No Interface Specified');
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/dataOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/startOut', 'IOInterface', 'No Interface Specified');
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/startOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/endOut', 'IOInterface', 'No Interface Specified');
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/endOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/validOut', 'IOInterface', 'No Interface Specified');
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/validOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/err', 'IOInterface', 'No Interface Specified');
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/err', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/dataRe', 'IOInterface', 'Rx data I1 Out [0:15]');
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/dataRe', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/dataIm', 'IOInterface', 'Rx data Q1 Out [0:15]');
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/dataIm', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/validEQ', 'IOInterface', 'Rx data Valid Out');
hdlset_param('RadioReceiver_FP_clean_Test/Receiver/validEQ', 'IOInterfaceMapping', '[0]');


%% Workflow Configuration Settings
% Construct the Workflow Configuration Object with default settings
hWC = hdlcoder.WorkflowConfig('SynthesisTool','Xilinx Vivado','TargetWorkflow','IP Core Generation');

% Specify the top level project directory
hWC.ProjectFolder = 'hdl_prj';
hWC.ReferenceDesignToolVersion = '2016.2';
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
hWC.RunExternalBuild = true;
hWC.TclFileForSynthesisBuild = hdlcoder.BuildOption.Default;
hWC.CustomBuildTclFile = '';

% Set properties related to 'RunTaskProgramTargetDevice' Task
hWC.ProgrammingMethod = hdlcoder.ProgrammingMethod.Download;

% Validate the Workflow Configuration Object
hWC.validate;

%% Run the workflow
hdlcoder.runWorkflow('RadioReceiver_FP_clean_Test/Receiver', hWC);
