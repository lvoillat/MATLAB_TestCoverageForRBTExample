%% Test Coverage for Requirements-Based Testing
% This example shows how to collect test coverage for a model that
% implements requirements. Coverage refers to determining the testing 
% completeness by analyzing how much of the model logic is exercised. 
% For requirements-based testing, coverage results can be scoped to linked 
% requirements. With this scoping you can assess if each model element is 
% covered by the intended test case.
%
% The example shows how scoping coverage results to linked requirements 
% can reveal both inadequate requirement linking and testing gaps. It 
% also shows how to increase the coverage. 
%
% The model in this example is |cruiseControlRBTCovExample|, which
% represents a cruise control system. This model implements and is linked
% to requirements. A test file has already been created for this example.

% Copyright 2020 The MathWorks, Inc.

%% Open the Cruise Control Model
cruiseControlRBTCovExample 
%% View the Linked Requirements
% The requirements for this cruise control system have been captured in the
% Requirements Editor. To view the requirements, use 
% |slreq.open('cruiseControlRBTCovReqs.slreqx')|.
%% Open the Test Manager and Test File
% Use |sltestmgr| to open the Test Manager. 
%
% Click *Open* and select |cruiseControlRBTCovTests.mldatx|. The tests have
% been written to verify that the model behavior meets the specified 
% requirements.  They have also been set up to record Decision and 
% Condition coverage. Expand Coverage Settings to see the selected metrics.
%%
% <<../cov_metrics.png>>
%%
% Each test case verifies and is linked to a requirement. For example, the 
% Throttle Test verifies the THROTTLE requirement. This requirement specifies
% that the throttle is applied smoothly if the speed differs from the target. 
% The test verifies this behavior using a logical assessment, which checks that 
% the throttle rate of change is between -1 and 1 radians per second, as
% defined in the requirement description.
%% Run the Test and View Coverage Results
% Run the test. 
%
% Click on Results in the Results and Artifacts pane when the test finishes
% running. Note that the tests pass and that 100% aggregated coverage is 
% reported.
%%
% <<../cov_aggreg_unscoped.png>>
%% Turn on Scoping the Test Results to Linked Requirements
% Click the top-level Results in the Results and Artifacts pane. Then, 
% in the Aggregated Coverage Results pane, click the |Scope coverage 
% results to linked requirements| check box. Scoping the results means that 
% each test only contributes coverage for the corresponding model elements 
% that implement the requirement verified by that test. Scoping checks that 
% model elements are covered by the intended test cases. The coverage 
% results, which update automatically, now show aggregated coverage for 
% Decision and Execution at 92% and 76%, respectively.
%%
% <<../cov_aggreg_scoped.png>>
%% View the Coverage Results in the Model
% Click on the model name in the Analyzed Model column to highlight the 
% coverage results in the model and display the Coverage Report details.
%
% In the model, if the Requirements table is not shown below the model, 
% open it by clicking the Perspectives views in the lower right corner of the
% model canvas and then, clicking Requirements.
%
% Open the Controller subsystem. Blocks that do not have 100% coverage 
% appear in red. Two sets of Constant and Sum blocks are not linked to 
% requirements and were never executed.
%%
% <<../cov_unlinked_blocks.png>>
%% Link Blocks to Requirements
% In this case, the missing coverage indicates insufficient requirements 
% linking. These Constant and Sum blocks are necessary for implementing 
% the INCREMENT and DECREMENT requirements and should be linked to the
% appropriate requirements. 
%
% In the table in the Requirements pane, expand |cruiseControlRbtCovReqs|.
% Right-click on the upper Constant block and select *Requirements > 
% Link to Selection in Requirements Browser*. Then, click on the INCREMENT 
% requirement in the Requirements table. Repeat this for the upper Sum block.
%
% For the lower Constant and Sum blocks, repeat the linking steps, but link 
% to the DECREMENT requirement.
%% Increase Coverage from a Specific Test
% Open the PI Controller and click on the Discrete-Time Integrator block.
% The Coverage Details show that the |true| decision for the upper limit was
% executed by the Increment Test (T4), rather than the Throttle Test
% (T6). Since the block is part of the implementation of the THROTTLE
% requirement, it should have been tested by the Throttle Test, which 
% verifies the THROTTLE requirement. The Increment Test does not verify this 
% requirement and does not contribute coverage for this block when the 
% |Scope model coverage to linked requirements| setting is enabled.
%%
% <<../cov_integrator_fail.png>>
%%
% To resolve the missing coverage for this block, the Throttle Test needs 
% to be updated to exercise the Discrete-Time Integrator block more. 
%
% In the Test Browser pane of the Test Manager, select Throttle Test. Under
% Inputs, select |td_throttle_updated.mat| as the External Inputs file. 
% This updated input throttle data file has some additional seconds of 
% test data, which increase the target speed more aggressively while 
% maintaining the actual speed.
%
% Select |cruiseControlRBTCovTests| in the Test Browser pane and rerun the test. 
% Click the |Scope coverage results to linked requirements| check box. The
% coverage results show 100% coverage, which indicates that the tests 
% adequately execute the model.
%
%% Revised Test Reveals an Issue in the Design
% The revised Throttle Test now fails verification. The failure
% occurs because the throttle increases too aggressively and is outside 
% the required boundaries specified in the test. This indicates an issue 
% with the model design. The PI Controller block implementation would need 
% to be updated to apply the throttle within the required limits, including
% when the target and actual speeds differ significantly.
%% Conclusion
% In summary, scoping coverage results to linked requirements can help 
% reveal gaps in testing. Scoping accomplishes this by assessing that 
% each model element is exercised by the test that verifies  
% the corresponding requirement.

