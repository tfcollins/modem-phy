
import matlab.unittest.TestRunner;
import matlab.unittest.TestSuite;
import matlab.unittest.selectors.HasTag
import matlab.unittest.plugins.TestRunProgressPlugin
import matlab.unittest.plugins.LoggingPlugin

%% Pick Tags
Tags = {'Simulation','Simulink','Fixed','Environmental'};
sm = TestSuite.fromClass(?matlab_tests);
ss = TestSuite.fromClass(?simulink_tests);
if ~isempty(Tags)
    % Pick all tests with specific tags
    for t=1:length(Tags)
        sm = sm.selectIf(HasTag(Tags{t}));
        ss = ss.selectIf(HasTag(Tags{t}));  
    end
end
suites = [sm,ss];

%% Add runner and pluggin(s)
runner = TestRunner.withNoPlugins;
p = LoggingPlugin.withVerbosity(4);
runner.addPlugin(p);
p = TestRunProgressPlugin.withVerbosity(4);
runner.addPlugin(p);

%% Run Tests
if ~isempty(ver('parallel'))
    r = runInParallel(runner,suites);
else
    r = run(runner,suites);
end

% Check results
rt = table(r);
disp(rt)
