
import matlab.unittest.TestRunner;
import matlab.unittest.TestSuite;
import matlab.unittest.selectors.HasTag
import matlab.unittest.plugins.TestRunProgressPlugin
import matlab.unittest.plugins.LoggingPlugin
import matlab.unittest.plugins.DiagnosticsRecordingPlugin;

%addpath('hdl');


%% Pick Tags
Tags = {'Simulation'};
sm = TestSuite.fromClass(?matlab_tests);
ss = TestSuite.fromClass(?simulink_tests);
%hs = TestSuite.fromClass(?hdl_tests);
if ~isempty(Tags)
    % Pick all tests with specific tags
    for t=1:length(Tags)
        sm = sm.selectIf(HasTag(Tags{t}));
        ss = ss.selectIf(HasTag(Tags{t}));
        %hs = hs.selectIf(HasTag(Tags{t}));
    end
end
%suites = [sm,ss,hs];
suites = [sm,ss];

%% Add runner and pluggin(s)
runner = TestRunner.withNoPlugins;
p = LoggingPlugin.withVerbosity(4);
runner.addPlugin(p);
p = TestRunProgressPlugin.withVerbosity(4);
runner.addPlugin(p);
runner.addPlugin(DiagnosticsRecordingPlugin);

%% Run Tests
if license('test','Distrib_Computing_Toolbox')
    r = runInParallel(runner,suites);
else
    r = run(runner,suites);
end

% Check results
rt = table(r);
disp(rt)
