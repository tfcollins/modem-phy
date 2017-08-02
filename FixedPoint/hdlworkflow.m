%--------------------------------------------------------------------------
% HDL Workflow Script
% Generated with MATLAB 9.2 (R2017a) at 15:01:10 on 02/08/2017
% This script was generated using the following parameter values:
%     Filename  : '/home/tcollins/git/modem-phy/FixedPoint/hdlworkflow22.m'
%     Overwrite : true
%     Comments  : true
%     Headers   : true
%     DUT       : 'RadioReceiver_FP_clean/Receiver'
% To view changes after modifying the workflow, run the following command:
% >> hWC.export('DUT','RadioReceiver_FP_clean/Receiver');
%--------------------------------------------------------------------------

%% Load the Model
load_system('RadioReceiver_FP_clean');

%% Restore the Model to default HDL parameters
%hdlrestoreparams('RadioReceiver_FP_clean/Receiver');

%% Model HDL Parameters
%% Set Model 'RadioReceiver_FP_clean' HDL parameters
hdlset_param('RadioReceiver_FP_clean', 'BalanceDelays', 'off');
hdlset_param('RadioReceiver_FP_clean', 'CriticalPathEstimation', 'on');
hdlset_param('RadioReceiver_FP_clean', 'HDLGenerateWebview', 'on');
hdlset_param('RadioReceiver_FP_clean', 'HDLSubsystem', 'RadioReceiver_FP_clean/Receiver');
hdlset_param('RadioReceiver_FP_clean', 'OptimizationReport', 'on');
hdlset_param('RadioReceiver_FP_clean', 'ReferenceDesign', 'Receive path');
hdlset_param('RadioReceiver_FP_clean', 'ReferenceDesignParameter', {'ChannelMapping','1','DUTSynthFreqMHz','1'});
hdlset_param('RadioReceiver_FP_clean', 'SynthesisTool', 'Xilinx Vivado');
hdlset_param('RadioReceiver_FP_clean', 'SynthesisToolChipFamily', 'Zynq');
hdlset_param('RadioReceiver_FP_clean', 'SynthesisToolDeviceName', 'xc7z045');
hdlset_param('RadioReceiver_FP_clean', 'SynthesisToolPackageName', 'ffg900');
hdlset_param('RadioReceiver_FP_clean', 'SynthesisToolSpeedValue', '-2');
hdlset_param('RadioReceiver_FP_clean', 'TargetDirectory', 'hdl_prj/hdlsrc');
hdlset_param('RadioReceiver_FP_clean', 'TargetPlatform', 'ZC706 and FMCOMMS2/3/4');
hdlset_param('RadioReceiver_FP_clean', 'Workflow', 'IP Core Generation');

% Set SubSystem HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver', 'ProcessorFPGASynchronization', 'Free running');

% Set Inport HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/re', 'IOInterface', 'Rx data I1 In [0:15]');
hdlset_param('RadioReceiver_FP_clean/Receiver/re', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/Im', 'IOInterface', 'Rx data Q1 In [0:15]');
hdlset_param('RadioReceiver_FP_clean/Receiver/Im', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/Enable', 'IOInterface', 'Rx data Valid In');
hdlset_param('RadioReceiver_FP_clean/Receiver/Enable', 'IOInterfaceMapping', '[0]');

% Set SubSystem HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/Frame Sync and  Decode/Barker Locate', 'BalanceDelays', 'on');

% Set SubSystem HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/Frame Sync and  Decode/Equalization and Demodulation/CRC Check', 'BalanceDelays', 'on');

% Set SubSystem HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/Frame Sync and  Decode/Equalization and Demodulation/DFE', 'BalanceDelays', 'on');

% Set SubSystem HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/Frame Sync and  Decode/Equalization and Demodulation/DMA Interface', 'BalanceDelays', 'on');

% Set SubSystem HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/Frame Sync and  Decode/Equalization and Demodulation/Descramble and Decode/2 Bit Descrambler', 'BalanceDelays', 'on');

% Set SubSystem HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/Frequency Recovery', 'BalanceDelays', 'on');

% Set SubSystem HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/Gardner Timing Recovery', 'BalanceDelays', 'on');

% Set Gain HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/Gardner Timing Recovery/Loop Filt', 'ConstMultiplierOptimization', 'csd');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/byteOut', 'IOInterface', 'No Interface Specified');
hdlset_param('RadioReceiver_FP_clean/Receiver/byteOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/validOut', 'IOInterface', 'No Interface Specified');
hdlset_param('RadioReceiver_FP_clean/Receiver/validOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/sync', 'IOInterface', 'No Interface Specified');
hdlset_param('RadioReceiver_FP_clean/Receiver/sync', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/payloadLenOut', 'IOInterface', 'No Interface Specified');
hdlset_param('RadioReceiver_FP_clean/Receiver/payloadLenOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/dataRe', 'IOInterface', 'No Interface Specified');
hdlset_param('RadioReceiver_FP_clean/Receiver/dataRe', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/dataIm', 'IOInterface', 'No Interface Specified');
hdlset_param('RadioReceiver_FP_clean/Receiver/dataIm', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/validEQ', 'IOInterface', 'No Interface Specified');
hdlset_param('RadioReceiver_FP_clean/Receiver/validEQ', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/endFlag', 'IOInterface', 'Rx data Valid Out');
hdlset_param('RadioReceiver_FP_clean/Receiver/endFlag', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/errCRC', 'IOInterface', 'Rx data I1 Out [0:15]');
hdlset_param('RadioReceiver_FP_clean/Receiver/errCRC', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/packLen', 'IOInterface', 'Rx data Q1 Out [0:15]');
hdlset_param('RadioReceiver_FP_clean/Receiver/packLen', 'IOInterfaceMapping', '[0:15]');


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
hdlcoder.runWorkflow('RadioReceiver_FP_clean/Receiver', hWC);
