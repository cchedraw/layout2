classdef tHBox < HBoxTests & ContainerSharedTests
    %THBOX Tests for uiextras.HBox.

    properties ( TestParameter )
        % The constructor name, or class, of the component under test.
        ConstructorName = {'uiextras.HBox'}
        % Name-value pair input arguments to use when testing the component
        % constructor.
        ConstructorInputArguments = {{
            'BackgroundColor', [0, 0, 1], ...
            'Units', 'pixels', ...
            'Position', [10, 10, 400, 400], ...
            'Padding', 5, ...
            'Spacing', 5, ...
            'Tag', 'test', ...
            'Visible', 'on'
            }}
        % Name-value pairs to use when testing the component's get and set
        % methods.
        GetSetNameValuePairs = {{
            'Sizes', [-1, -2, 100, -1], ...
            'MinimumSizes', [0, 1, 2, 0]
            }}
    end % properties ( TestParameter )

end % class
