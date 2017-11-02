%--------------------------------------------------------------------------
% HDL Workflow Script
% Generated with MATLAB 9.3 (R2017b) at 14:53:11 on 02/11/2017
% This script was generated using the following parameter values:
%     Filename  : '/backup/modem-fix/FixedPoint/hdl/genHDL_TXRX_EQConnected_TXConstant_RFSoM_HSP.m'
%     Overwrite : true
%     Comments  : true
%     Headers   : true
%     DUT       : 'combinedTxRx/Combined TX and RX'
% To view changes after modifying the workflow, run the following command:
% >> hWC.export('DUT','combinedTxRx/Combined TX and RX');
%--------------------------------------------------------------------------

%% Load the Model
load_system('combinedTxRx');

%% Restore the Model to default HDL parameters
%hdlrestoreparams('combinedTxRx/Combined TX and RX');

%% Model HDL Parameters
%% Set Model 'combinedTxRx' HDL parameters
hdlset_param('combinedTxRx', 'BalanceDelays', 'off');
hdlset_param('combinedTxRx', 'HDLSubsystem', 'combinedTxRx/Combined TX and RX');
hdlset_param('combinedTxRx', 'ReferenceDesign', 'Receive and transmit path');
hdlset_param('combinedTxRx', 'ReferenceDesignParameter', {'ChannelMapping','1','DUTSynthFreqMHz','20'});
hdlset_param('combinedTxRx', 'SynthesisTool', 'Xilinx Vivado');
hdlset_param('combinedTxRx', 'SynthesisToolChipFamily', 'Zynq');
hdlset_param('combinedTxRx', 'SynthesisToolDeviceName', 'xc7z035i');
hdlset_param('combinedTxRx', 'SynthesisToolPackageName', 'fbg676');
hdlset_param('combinedTxRx', 'SynthesisToolSpeedValue', '-2L');
hdlset_param('combinedTxRx', 'TargetDirectory', 'hdl_prj_txrx/hdlsrc');
hdlset_param('combinedTxRx', 'TargetPlatform', 'ADI RF SOM');
hdlset_param('combinedTxRx', 'Workflow', 'IP Core Generation');

% Set SubSystem HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX', 'ProcessorFPGASynchronization', 'Free running');

% Set Inport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/ValidInTx', 'IOInterface', 'Tx data Valid In');
hdlset_param('combinedTxRx/Combined TX and RX/ValidInTx', 'IOInterfaceMapping', '[0]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/rInTx', 'IOInterface', 'Tx data I1 In [0:15]');
hdlset_param('combinedTxRx/Combined TX and RX/rInTx', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/iInTx', 'IOInterface', 'Tx data Q1 In [0:15]');
hdlset_param('combinedTxRx/Combined TX and RX/iInTx', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/FromRadioR', 'IOInterface', 'Rx data I1 In [0:15]');
hdlset_param('combinedTxRx/Combined TX and RX/FromRadioR', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/FromRadioI', 'IOInterface', 'Rx data Q1 In [0:15]');
hdlset_param('combinedTxRx/Combined TX and RX/FromRadioI', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/FromRadioValidIn', 'IOInterface', 'Rx data Valid In');
hdlset_param('combinedTxRx/Combined TX and RX/FromRadioValidIn', 'IOInterfaceMapping', '[0]');

% Set SubSystem HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL', 'ProcessorFPGASynchronization', 'Free running');

% Set Inport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/re', 'IOInterface', 'Rx data I1 In [0:15]');
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/re', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/Im', 'IOInterface', 'Rx data Q1 In [0:15]');
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/Im', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/Enable', 'IOInterface', 'Rx data Valid In');
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/Enable', 'IOInterfaceMapping', '[0]');

% Set SubSystem HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/CRC Check and DMA Pack', 'BalanceDelays', 'on');

% Set SubSystem HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/Frame Recover', 'BalanceDelays', 'on');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/bytesOut', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/bytesOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/validOut', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/validOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/sync', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/sync', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/payloadLenOut', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/payloadLenOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/dataRe', 'IOInterface', 'Rx data I1 Out [0:15]');
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/dataRe', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/dataIm', 'IOInterface', 'Rx data Q1 Out [0:15]');
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/dataIm', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/validEQ', 'IOInterface', 'Rx data Valid Out');
hdlset_param('combinedTxRx/Combined TX and RX/Receiver HDL/validEQ', 'IOInterfaceMapping', '[0]');

% Set SubSystem HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1', 'BalanceDelays', 'on');
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1', 'ProcessorFPGASynchronization', 'Free running');

% Set Inport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/In1', 'IOInterface', 'Tx data Valid In');
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/In1', 'IOInterfaceMapping', '[0]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/r ', 'IOInterface', 'Tx data I1 In [0:15]');
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/r ', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/i', 'IOInterface', 'Tx data Q1 In [0:15]');
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/i', 'IOInterfaceMapping', '[0:15]');

% Set SubSystem HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Transmitter HDL', 'ProcessorFPGASynchronization', 'Free running');

% Set Inport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Transmitter HDL/bytesIn', 'IOInterface', 'Tx data I1 In [0:15]');
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Transmitter HDL/bytesIn', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Transmitter HDL/validIn', 'IOInterface', 'Tx data Valid In');
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Transmitter HDL/validIn', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Transmitter HDL/Packet Generation/trueData', 'IOInterface', 'Tx data Valid Out');
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Transmitter HDL/Packet Generation/trueData', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Transmitter HDL/real', 'IOInterface', 'Tx data I1 Out [0:15]');
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Transmitter HDL/real', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Transmitter HDL/imag', 'IOInterface', 'Tx data Q1 Out [0:15]');
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Transmitter HDL/imag', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Transmitter HDL/validOut', 'IOInterface', 'Tx data Valid Out');
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Transmitter HDL/validOut', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Transmitter HDL/Need Data', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Transmitter HDL/Need Data', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Out1', 'IOInterface', 'Tx data I1 Out [0:15]');
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Out1', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Out2', 'IOInterface', 'Tx data Q1 Out [0:15]');
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Out2', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Out3', 'IOInterface', 'Tx data Valid Out');
hdlset_param('combinedTxRx/Combined TX and RX/Tx Under Test1/Out3', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/ToRadioR', 'IOInterface', 'Tx data I1 Out [0:15]');
hdlset_param('combinedTxRx/Combined TX and RX/ToRadioR', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/ToRadioI', 'IOInterface', 'Tx data Q1 Out [0:15]');
hdlset_param('combinedTxRx/Combined TX and RX/ToRadioI', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/ToRadioValid', 'IOInterface', 'Tx data Valid Out');
hdlset_param('combinedTxRx/Combined TX and RX/ToRadioValid', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/BytesOutRx', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx/Combined TX and RX/BytesOutRx', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/payloadLenOutRx', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx/Combined TX and RX/payloadLenOutRx', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/ValidOutRx', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx/Combined TX and RX/ValidOutRx', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/syncRx', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx/Combined TX and RX/syncRx', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/dataReRx', 'IOInterface', 'Rx data I1 Out [0:15]');
hdlset_param('combinedTxRx/Combined TX and RX/dataReRx', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/dataImRx', 'IOInterface', 'Rx data Q1 Out [0:15]');
hdlset_param('combinedTxRx/Combined TX and RX/dataImRx', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx/Combined TX and RX/validEQRx', 'IOInterface', 'Rx data Valid Out');
hdlset_param('combinedTxRx/Combined TX and RX/validEQRx', 'IOInterfaceMapping', '[0]');


%% Workflow Configuration Settings
% Construct the Workflow Configuration Object with default settings
hWC = hdlcoder.WorkflowConfig('SynthesisTool','Xilinx Vivado','TargetWorkflow','IP Core Generation');

% Specify the top level project directory
hWC.ProjectFolder = 'hdl_prj_txrx';
hWC.ReferenceDesignToolVersion = '2016.4';
hWC.IgnoreToolVersionMismatch = false;

% Set Workflow tasks to run
hWC.RunTaskGenerateRTLCodeAndIPCore = true;
hWC.RunTaskCreateProject = true;
hWC.RunTaskGenerateSoftwareInterfaceModel = false;
hWC.RunTaskBuildFPGABitstream = true;
hWC.RunTaskProgramTargetDevice = true;

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
hdlcoder.runWorkflow('combinedTxRx/Combined TX and RX', hWC);
