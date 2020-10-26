classdef tVBoxFlex < FlexSharedTests & VBoxTests
    %TVBOX Runs parameterised tests for VBox.
    
    properties (TestParameter)
        ContainerType = {'uiextras.VBoxFlex'};
        GetSetArgs = {
           {'Sizes',            [-1 -2 100 -1], ...
            'MinimumSizes',     [0 1 2 0] ...
            'ShowMarkings',     'on' ...
            }};
        ConstructorArgs = {
           {'BackgroundColor', [0 0 1], ...
            'Units',           'pixels', ...
            'Position',        [10 10 400 400], ...
            'Padding',         5, ...
            'Spacing',         5, ...
            'Tag',             'test', ...
            'Visible',         'on', ...
            'ShowMarkings',    'off' ...
            }};
    end
    
end

