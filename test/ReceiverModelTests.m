classdef (Abstract) ReceiverModelTests < matlab.unittest.TestCase
    % Test QPSK receiver model
    %
    % Example call:
    %  test = ReceiverModelTests;
    %  test.run()
    
    properties
        radioObject = [];
        SampleRate = 1e6;
        CenterFrequency = 1e9;
        FPMATLABReceiverFunctionName = 'ReceiverFloatingPoint';
        XPSimulinkReceiverModelName = 'Receiver_UnderTest_Fixed';
        FPSimulinkReceiverModelName = 'Receiver_UnderTest_Float';
        FramesToReceive = 4;
        ScopesToDisable = {'Constellation','Scope','Spectrum'};
        EnableVisuals = true;
        HardwareCheck = false;
    end
    
    properties (Constant)
       RadioDefaultRXGainConfig=struct('Gain',20,'Mode','AGC Slow Attack'); 
       RadioDefaultTXGain = -30; 
    end
    
    properties (Access = private)
        warningState
        Radio
    end
    
    methods(TestClassSetup)
        % Load example settings from mat file
        function DisableWarnings(testCase)
            disp('Loading');
            testCase.warningState = warning;
            warning('off','all');
        end
        
        function findRadio(testCase)
            r = findPlutoRadio;
            if isempty(r) && testCase.HardwareCheck
                error('No radio attached');
            end
            testCase.Radio = r;
        end
    end
    
    methods(TestClassTeardown)
        function EnableOriginalWarnings(testCase)
            disp('Cleanup');
            warning(testCase.warningState);
        end
    end
    
    methods (Static)
        
        % Scale double data for fixed-point model
        function input = ScaleInput(input)
            input = int16((2^10-1).*input);
        end
        % Disable scopes
        function DisableScopes(modelname,blocktypes)
            for block = blocktypes
                scopes = find_system(modelname,'CaseSensitive','off',...
                    'regexp','on','LookUnderMasks','all',...
                    'blocktype',block{:});
                delete_block(scopes);
            end
        end
        
    end
    
    methods % Non-Static Test Scaffolding
        
        % Check receiver struct results
        function checkResults(testCase,results)
            % Check results
            testCase.assertGreaterThanOrEqual(results.packetsFound,....
                testCase.FramesToReceive);
            for i = 1:results.packetsFound
                testCase.assertEqual(results.crcChecks(i),0,'CRC Failed in packet');
            end
        end
        % Test MATLAB based receiver
        function testPacketRecoveryMATLAB(testCase,RxIQ,functionName)
            % Run receiver
            rh = str2func(functionName);
            results = rh(testCase,RxIQ);
            % Check results
            testCase.checkResults(results)
        end
        % Test Simulink based receiver
        function testPacketRecoverySimulink(testCase,RxIQ,modelname)
            % Save data to file for model
            bb = comm.BasebandFileWriter('Filename','example.bb',...
                'CenterFrequency',testCase.CenterFrequency,...
                'SampleRate',testCase.SampleRate);
            % Cast to fixed if necessary and save data
            bb(RxIQ);
            bb.release();
            % Set model parameters
            open(modelname);
            if ~testCase.EnableVisuals
                testCase.DisableScopes(modelname,testCase.ScopesToDisable);
            end
            %CloseAllScopes(modelname);
            set_param([modelname,'/Baseband File Reader'],...
                'SamplesPerFrame',num2str(length(RxIQ)));
            set_param([modelname,'/Baseband File Reader'],...
                'Filename','example.bb');
            stopTime = length(RxIQ)*1.1/testCase.SampleRate;
            set_param(modelname,'StopTime',num2str(stopTime))
            % Run receiver
            simOut = sim(modelname);
            close_system(modelname, false);
            % Pack results
            results = struct('packetsFound',packetsFound.Data(end),...
                'crcChecks',crcChecks.Data(:,:,end),'failures',failures.Data(:,:,end));
            % Check results
            testCase.checkResults(results);
        end
        % Call receiver
        function runSpecificReceiver(testCase,RxIQ_many_offset,sink)
            % Run and check receiver
            switch sink
                case 'FloatingPointSimulink'
                    testCase.testPacketRecoverySimulink(...
                        RxIQ_many_offset,...
                        testCase.FPSimulinkReceiverModelName);
                case 'FixedPointSimulink'
                    testCase.testPacketRecoverySimulink(...
                        RxIQ_many_offset,...
                        testCase.XPSimulinkReceiverModelName);
                case 'FloatingPointMATLAB'
                    testCase.testPacketRecoveryMATLAB(...
                        RxIQ_many_offset,...
                        testCase.FPMATLABReceiverFunctionName);
                otherwise
                    error(['Unknown case ',sink]);
            end
        end
        % Loop through receiver
        function RxIQ_many_offset = passThroughRadio(testCase,RxIQ,isfixed,RXGainConfig,TXGain)
            if isfixed
                odt = 'int16';
            else
                odt = 'double';
            end
            % TX
            if isempty(TXGain)
                Gain = testCase.RadioDefaultTXGain;
            else
                Gain = TXGain;
            end
            tx = sdrtx('Pluto','BasebandSampleRate',testCase.SampleRate,...
                'CenterFrequency',testCase.CenterFrequency,...
                'Gain',Gain);
            % RX
            if isempty(RXGain)
                Gain = testCase.RadioDefaultRXGainConfig.Gain;
                GainMode = testCase.RadioDefaultRXGainConfig.Mode;
            else
                Gain = RXGainConfig.Gain;
                GainMode = RXGainConfig.Mode;
            end
            rx = sdrrx('Pluto','BasebandSampleRate',testCase.SampleRate,...
                'CenterFrequency',testCase.CenterFrequency,...
                'OutputDataType',odt,...
                'SamplesPerFrame',(length(RxIQ)*(testCase.FramesToReceive+1)),...
                'GainSource', GainMode,'Gain',Gain);
            tx.transmitRepeat(RxIQ);
            pause(1); % Let transmitter startup
            rx(); % Let AGC settle
            RxIQ_many_offset = rx();
            clear tx rx; 
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Test Case Structures
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Test receiver with different packet gaps
        function testPacketGaps(testCase, source, sink, gaps)
            % Generate source data
            for gap = gaps
                % Generate data within interpacket gaps
                RxIQ = generateFrame('Gap',gap,'Packets',testCase.FramesToReceive);
                % Apply to source
                isfixed = contains(lower(sink),'fixed');
                % Apply to source
                if strcmp(source,'radio')
                    error('Not yet implemented');
                elseif strcmp(source,'simulation')
                    %RxIQ_many = repmat(RxIQ,testCase.FramesToReceive,1);
                    if isfixed
                        RxIQ_many = testCase.ScaleInput(RxIQ);
                    end
                end
                % Run and check receiver
                testCase.runSpecificReceiver(RxIQ_many,sink);
            end
        end
        %% Test receiver with different sample rates
        function testSampleRates(testCase, source, sink, rates)
            % Generate source data
            for rate = rates
                % Generate data within interpacket gaps
                %RxIQ = generateFrame();
                RxIQ = generateFrame('Packets',testCase.FramesToReceive);
                % Apply to source
                if strcmp(source,'radio')
                    error('Not yet implemented');
                elseif strcmp(source,'simulation')
                    % Nothing here
                end
                % Run and check receiver
                testCase.runSpecificReceiver(RxIQ,sink);
            end
        end
        %% Test receiver with different frequency offsets
        function testPacketFrequencyOffset(testCase, source, sink, offsets)
            pfo = comm.PhaseFrequencyOffset(...
                'SampleRate',testCase.SampleRate);
            % Generate source data
            for offset = offsets
                % Generate data
                RxIQ = generateFrame('Packets',testCase.FramesToReceive);
                % Apply to source
                isfixed = contains(lower(sink),'fixed');
                if strcmp(source,'radio')
                    RxIQ_many_offset = testCase.passThroughRadio(RxIQ,isfixed);
                elseif strcmp(source,'simulation')
                    pfo.release();
                    pfo.FrequencyOffset = offset;
                    RxIQ_many_offset = pfo(RxIQ);
                    if isfixed
                        RxIQ_many_offset = testCase.ScaleInput(RxIQ_many_offset);
                    end
                end
                % Run and check receiver
                testCase.runSpecificReceiver(RxIQ_many_offset,sink);
            end
        end
        %% Test receiver with different gains (simulates distance and exercises AGC)
        function testPacketGainDifference(testCase, source, sink, RXGainConfig, TXGain)
            % Generate source data
            for offset = offsets
                % Generate data
                RxIQ = generateFrame('Packets',testCase.FramesToReceive);
                % Apply to source
                isfixed = contains(lower(sink),'fixed');
                if strcmp(source,'radio')
                    RxIQ_many_offset = testCase.passThroughRadio(RxIQ,isfixed, RXGainConfig, TXGain);
                elseif strcmp(source,'simulation')
                    %RxIQ_many = repmat(RxIQ,testCase.FramesToReceive,1);
                    RxIQ_many_gains = RxIQ.*RXGainConfig.Gain.*TXGain;
                    if isfixed
                        RxIQ_many_offset = testCase.ScaleInput(RxIQ_many_gains);
                    end
                end
                % Run and check receiver
                testCase.runSpecificReceiver(RxIQ_many_offset,sink);
            end
        end
        
    end
    methods (Test)
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Tests
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % See subclasses matlab_tests and simulink_tests
        
    end
    
end