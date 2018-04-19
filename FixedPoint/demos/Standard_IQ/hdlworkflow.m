%--------------------------------------------------------------------------
% HDL Workflow Script
% Generated with MATLAB 9.3 (R2017b) at 20:01:04 on 18/04/2018
% This script was generated using the following parameter values:
%     Filename  : 'C:\MathWorkSeminar\modem-phy\FixedPoint\demos\Standard_IQ\hdlworkflow.m'
%     Overwrite : true
%     Comments  : true
%     Headers   : true
%     DUT       : 'combinedTxRx_StandardIQ/Combined TX and RX'
% To view changes after modifying the workflow, run the following command:
% >> hWC.export('DUT','combinedTxRx_StandardIQ/Combined TX and RX');
%--------------------------------------------------------------------------

%% Load the Model
load_system('combinedTxRx_StandardIQ');

%% Restore the Model to default HDL parameters
%hdlrestoreparams('combinedTxRx_StandardIQ/Combined TX and RX');

%% Model HDL Parameters
%% Set Model 'combinedTxRx_StandardIQ' HDL parameters
hdlset_param('combinedTxRx_StandardIQ', 'HDLSubsystem', 'combinedTxRx_StandardIQ/Combined TX and RX');
hdlset_param('combinedTxRx_StandardIQ', 'ReferenceDesign', 'Receive and transmit path');
hdlset_param('combinedTxRx_StandardIQ', 'ReferenceDesignParameter', {'ChannelMapping','1','DUTSynthFreqMHz','20'});
hdlset_param('combinedTxRx_StandardIQ', 'SynthesisTool', 'Xilinx Vivado');
hdlset_param('combinedTxRx_StandardIQ', 'SynthesisToolChipFamily', 'Zynq');
hdlset_param('combinedTxRx_StandardIQ', 'SynthesisToolDeviceName', 'xc7z035i');
hdlset_param('combinedTxRx_StandardIQ', 'SynthesisToolPackageName', 'fbg676');
hdlset_param('combinedTxRx_StandardIQ', 'SynthesisToolSpeedValue', '-2L');
hdlset_param('combinedTxRx_StandardIQ', 'TargetDirectory', 'hdl_prj\hdlsrc');
hdlset_param('combinedTxRx_StandardIQ', 'TargetPlatform', 'ADI RF SOM');
hdlset_param('combinedTxRx_StandardIQ', 'Workflow', 'IP Core Generation');

% Set SubSystem HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX', 'ProcessorFPGASynchronization', 'Free running');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/ValidInTx', 'IOInterface', 'Tx data Valid In');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/ValidInTx', 'IOInterfaceMapping', '[0]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/rInTx', 'IOInterface', 'Tx data I1 In [0:15]');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/rInTx', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/iInTx', 'IOInterface', 'Tx data Q1 In [0:15]');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/iInTx', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/FromRadioR', 'IOInterface', 'Rx data I1 In [0:15]');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/FromRadioR', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/FromRadioI', 'IOInterface', 'Rx data Q1 In [0:15]');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/FromRadioI', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/FromRadioValidIn', 'IOInterface', 'Rx data Valid In');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/FromRadioValidIn', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/IQ Interface Mapper/real', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/IQ Interface Mapper/real', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/IQ Interface Mapper/imag', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/IQ Interface Mapper/imag', 'IOInterfaceMapping', '');

% Set SubSystem HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL', 'ProcessorFPGASynchronization', 'Free running');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/re', 'IOInterface', 'Rx data I1 In [0:15]');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/re', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/Im', 'IOInterface', 'Rx data Q1 In [0:15]');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/Im', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/Enable', 'IOInterface', 'Rx data Valid In');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/Enable', 'IOInterfaceMapping', '[0]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/FRLoopBW', 'IOInterface', 'Rx data Valid In');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/FRLoopBW', 'IOInterfaceMapping', '[0]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/EQmu', 'IOInterface', 'Rx data Valid In');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/EQmu', 'IOInterfaceMapping', '[0]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/Scope Select', 'IOInterface', 'Rx data Valid In');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/Scope Select', 'IOInterfaceMapping', '[0]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/DebugSelector', 'IOInterface', 'Rx data Valid In');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/DebugSelector', 'IOInterfaceMapping', '[0]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/EQBypass', 'IOInterface', 'Rx data Valid In');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/EQBypass', 'IOInterfaceMapping', '[0]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/EnableDecode', 'IOInterface', 'Rx data Valid In');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/EnableDecode', 'IOInterfaceMapping', '[0]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/PDThreshold', 'IOInterface', 'Rx data Valid In');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/PDThreshold', 'IOInterfaceMapping', '[0]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/BypassCoding', 'IOInterface', 'Rx data Valid In');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/BypassCoding', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/bytesOut', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/bytesOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/validOut', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/validOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/sync', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/sync', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/payloadLenOut', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/payloadLenOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/dataRe', 'IOInterface', 'Rx data I1 Out [0:15]');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/dataRe', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/dataIm', 'IOInterface', 'Rx data Q1 Out [0:15]');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/dataIm', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/validIQ', 'IOInterface', 'Rx data Valid Out');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/validIQ', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/DebugSelection', 'IOInterface', 'Rx data Valid Out');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/DebugSelection', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/RxTransferComplete', 'IOInterface', 'Rx data Valid Out');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Receiver HDL/RxTransferComplete', 'IOInterfaceMapping', '[0]');

% Set SubSystem HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL', 'ProcessorFPGASynchronization', 'Free running');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL/bytesIn', 'IOInterface', 'Tx data I1 In [0:15]');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL/bytesIn', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL/validIn', 'IOInterface', 'Tx data Valid In');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL/validIn', 'IOInterfaceMapping', '[0]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL/BypassEncode', 'IOInterface', 'Tx data Valid In');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL/BypassEncode', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL/Packet Generation/trueData', 'IOInterface', 'Tx data Valid Out');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL/Packet Generation/trueData', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL/real', 'IOInterface', 'Tx data I1 Out [0:15]');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL/real', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL/imag', 'IOInterface', 'Tx data Q1 Out [0:15]');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL/imag', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL/validOut', 'IOInterface', 'Tx data Valid Out');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL/validOut', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL/Need Data', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL/Need Data', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL/TxTransferComplete', 'IOInterface', 'Tx data Valid Out');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/Transmitter HDL/TxTransferComplete', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/ToRadioR', 'IOInterface', 'Tx data I1 Out [0:15]');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/ToRadioR', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/ToRadioI', 'IOInterface', 'Tx data Q1 Out [0:15]');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/ToRadioI', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/ToRadioValid', 'IOInterface', 'Tx data Valid Out');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/ToRadioValid', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/FromIPR', 'IOInterface', 'Rx data I1 Out [0:15]');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/FromIPR', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/FromIPI', 'IOInterface', 'Rx data Q1 Out [0:15]');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/FromIPI', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/FromIPvalid', 'IOInterface', 'Rx data Valid Out');
hdlset_param('combinedTxRx_StandardIQ/Combined TX and RX/FromIPvalid', 'IOInterfaceMapping', '[0]');


%% Workflow Configuration Settings
% Construct the Workflow Configuration Object with default settings
hWC = hdlcoder.WorkflowConfig('SynthesisTool','Xilinx Vivado','TargetWorkflow','IP Core Generation');

% Specify the top level project directory
hWC.ProjectFolder = 'hdl_prj';
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
hWC.OperatingSystem = 'Linux';

% Set properties related to 'RunTaskBuildFPGABitstream' Task
hWC.RunExternalBuild = true;
hWC.TclFileForSynthesisBuild = hdlcoder.BuildOption.Default;
hWC.CustomBuildTclFile = '';

% Set properties related to 'RunTaskProgramTargetDevice' Task
hWC.ProgrammingMethod = hdlcoder.ProgrammingMethod.Download;

% Validate the Workflow Configuration Object
hWC.validate;

%% Run the workflow
hdlcoder.runWorkflow('combinedTxRx_StandardIQ/Combined TX and RX', hWC);
