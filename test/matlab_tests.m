classdef (TestTags = {'MATLAB','Float'})  matlab_tests < ReceiverModelTests
    
    methods (Test, TestTags = {'Environmental','Simulation'})
        function testFrequencyOffsetsFloatingPointSim(testCase)
            transmitter = 'simulation';
            receiver = 'FloatingPointMATLAB';
            frequencies = [0,1e2,1e3,3e3];
            testCase.testPacketFrequencyOffset(transmitter, receiver, frequencies);
        end
    end
    %%
    methods (Test, TestTags = {'Environmental','Radio'})
        function testFrequencyOffsetsFloatingPointHW(testCase)
            % This test assumes loopback with cabling,
            % if antennas are used the gain setting need to be considered.
            % If no gain settings are passed defaults are used.
            transmitter = 'radio';
            receiver = 'FloatingPointMATLAB';
            frequencies = [0,1e2,1e3,3e3];
            testCase.testPacketFrequencyOffset(transmitter, receiver, frequencies);
        end
    end
    %%
    methods (Test, TestTags = {'Functional','Simulation','Frequency'})
        function testPacketGapsSimulationFloatingPointSim(testCase)
            transmitter = 'simulation';
            receiver = 'FloatingPointMATLAB';
            gaps = [0, 1e2, 1e3, 3e3, 1e4];
            testCase.testPacketGaps(transmitter, receiver, gaps);
        end
    end
    %%
    methods (Test, TestTags = {'Environmental','Radio','Gains'})
        function testPacketTXGainsSimulationFloatingPointSim(testCase)
            % This test assumes loopback with cabling,
            % if antennas are used the gain setting need to be considered.
            % If no gain settings are passed defaults are used.
            transmitter = 'radio';
            receiver = 'FloatingPointMATLAB';
            TXGains = [-10, -20, -30, -40];
            testCase.testPacketGainDifference(transmitter, receiver,[] ,TXGains);
        end
    end
    %%
%     methods (Test, TestTags = {'Performance','Simulation'})
%         function testSampleRateSimulationFloatingPointSim(testCase)
%             transmitter = 'simulation';
%             receiver = 'FloatingPointMATLAB';
%             rates = [1, 5, 10, 20].*1e6;
%             testCase.testSampleRates(transmitter, receiver, rates);
%         end
%     end
    
end