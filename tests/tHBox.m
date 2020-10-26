classdef tHBox < ContainerSharedTests ...
               & HBoxTests
    %THBOX Runs parameterised tests for HBox.
    
    properties (TestParameter)
        ContainerType = {'uiextras.HBox'};
        GetSetArgs = {
           {'Sizes',            [-1 -2 100 -1], ...
            'MinimumSizes',     [0 1 2 0] ...
            }};
        ConstructorArgs = {
           {'BackgroundColor', [0 0 1], ...
            'Units',           'pixels', ...
            'Position',        [10 10 400 400], ...
            'Padding',         5, ...
            'Spacing',         5, ...
            'Tag',             'test', ...
            'Visible',         'on', ...
            }};
    end
    
    
end

