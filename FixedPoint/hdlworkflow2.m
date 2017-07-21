%--------------------------------------------------------------------------
% HDL Workflow Script
% Generated with MATLAB 9.2 (R2017a) at 18:55:39 on 20/07/2017
% This script was generated using the following parameter values:
%     Filename  : '/home/tcollins/git/modem-phy/FixedPoint/hdlworkflow2.m'
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
hdlset_param('RadioReceiver_FP_clean', 'HDLSubsystem', 'RadioReceiver_FP_clean/Receiver');
hdlset_param('RadioReceiver_FP_clean', 'ReferenceDesign', 'Receive path');
hdlset_param('RadioReceiver_FP_clean', 'SynthesisTool', 'Xilinx Vivado');
hdlset_param('RadioReceiver_FP_clean', 'SynthesisToolChipFamily', 'Zynq');
hdlset_param('RadioReceiver_FP_clean', 'SynthesisToolDeviceName', 'xc7z035i');
hdlset_param('RadioReceiver_FP_clean', 'SynthesisToolPackageName', 'fbg676');
hdlset_param('RadioReceiver_FP_clean', 'SynthesisToolSpeedValue', '-2L');
hdlset_param('RadioReceiver_FP_clean', 'TargetDirectory', 'hdl_prj/hdlsrc');
hdlset_param('RadioReceiver_FP_clean', 'TargetPlatform', 'PicoZed SDR');
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

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/dataOut', 'IOInterface', 'No Interface Specified');
hdlset_param('RadioReceiver_FP_clean/Receiver/dataOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/startOut', 'IOInterface', 'No Interface Specified');
hdlset_param('RadioReceiver_FP_clean/Receiver/startOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/endOut', 'IOInterface', 'No Interface Specified');
hdlset_param('RadioReceiver_FP_clean/Receiver/endOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/validOut', 'IOInterface', 'Rx data Valid Out');
hdlset_param('RadioReceiver_FP_clean/Receiver/validOut', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('RadioReceiver_FP_clean/Receiver/err', 'IOInterface', 'No Interface Specified');
hdlset_param('RadioReceiver_FP_clean/Receiver/err', 'IOInterfaceMapping', '');


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
