classdef tPanel < PanelTests & ContainerSharedTests
    %TPANEL Tests for uiextras.Panel.

    properties ( TestParameter )
        % The constructor name, or class, of the component under test.
        ConstructorName = {'uiextras.Panel'}
        % Name-value pair input arguments to use when testing the component
        % constructor.
        ConstructorInputArguments = {{
            'Units', 'pixels', ...
            'Position', [10, 10, 400, 400], ...
            'Padding', 5, ...
            'Tag', 'Test', ...
            'Visible', 'on', ...
            'FontAngle', 'normal', ...
            'FontName', 'SansSerif', ...
            'FontSize', 20, ...
            'FontUnits', 'points', ...
            'FontWeight', 'bold'
            }}
        % Name-value pairs to use when testing the component's get and set
        % methods.
        GetSetNameValuePairs = {{
            'BackgroundColor', [1, 1, 0]
            }}
    end % properties ( TestParameter )

end % class