classdef (TestTags = {'Simulink'}) simulink_tests < ReceiverModelTests
    %% Frequency offset tests
    methods (Test, TestTags = {'Environmental','Simulation','Float'})
        function testFrequencyOffsetsFloatingPointSim(testCase)
            transmitter = 'simulation';
            receiver = 'FloatingPointSimulink';
            frequencies = [1e2,1e3,2e3,3e3]; % Note default fs = 1e6
            testCase.testPacketFrequencyOffset(transmitter, receiver, frequencies);
        end
    end
    %
    methods (Test, TestTags = {'Environmental','Simulation','Fixed'})
        function testFrequencyOffsetsFixedPointSim(testCase)
            transmitter = 'simulation';
            receiver = 'FixedPointSimulink';
            frequencies = [1e2,1e3,2e3,3e3]; % Note default fs = 1e6
            testCase.testPacketFrequencyOffset(transmitter, receiver, frequencies);
        end
    end
    %
    methods (Test, TestTags = {'Environmental','Radio','Float'})
        function testFrequencyOffsetsFloatingPointHW(testCase)
            transmitter = 'radio';
            receiver = 'FloatingPointSimulink';
            frequencies = [0,1e2,1e3,2e3,1e4];
            testCase.testPacketFrequencyOffset(transmitter, receiver, frequencies);
        end
    end
    %
    methods (Test, TestTags = {'Environmental','Radio','Fixed'})
        function testFrequencyOffsetsFixedPointHW(testCase)
            transmitter = 'radio';
            receiver = 'FixedPointSimulink';
            frequencies = [0,1e2,1e3];
            testCase.testPacketFrequencyOffset(transmitter, receiver, frequencies);
        end
    end
    %% Interpacket gap tests
    methods (Test, TestTags = {'Functional','Simulation','Float'})
        function testPacketGapsSimulationFloatingPointSim(testCase)
            transmitter = 'simulation';
            receiver = 'FloatingPointSimulink';
            gaps = [0, 1e2, 1e3];
            testCase.testPacketGaps(transmitter, receiver, gaps);
        end
    end
    %
    methods (Test, TestTags = {'Functional','Simulation','Fixed'})
        function testPacketGapsSimulationFixedPointSim(testCase)
            transmitter = 'simulation';
            receiver = 'FixedPointSimulink';
            gaps = [0, 1e2, 1e3];
            testCase.testPacketGaps(transmitter, receiver, gaps);
        end
    end
    %% Sample rate tests
    methods (Test, TestTags = {'Performance','Radio','Float'})
        function testSampleRateSimulationFloatingPointSim(testCase)
            transmitter = 'radio';
            receiver = 'FloatingPointSimulink';
            rates = [1, 5, 10, 20].*1e6;
            testCase.testSampleRates(transmitter, receiver, rates);
        end
    end
    %
    methods (Test, TestTags = {'Performance','Radio','Fixed'})
        function testSampleRateSimulationFixedPointSim(testCase)
            transmitter = 'radio';
            receiver = 'FixedPointSimulink';
            rates = [1, 5, 10, 20].*1e6;
            testCase.testSampleRates(transmitter, receiver, rates);
        end
    end    
end