classdef tTabPanel  < ContainerSharedTests ...
        & PanelTests ...
        & SelectablePanelTests
    %TTABPANEL unit tests for uiextras.TabPanel
    
    properties (TestParameter)
        ContainerType = {'uiextras.TabPanel'};
        GetSetArgs  = {{
            'BackgroundColor',     [1 1 0], ...
            'SelectedChild',       2, ...
            'TabNames',            {'Tab 1', 'Tab 2', 'Tab 3'}, ...
            'TabEnable',           {'on', 'off', 'on'}, ...
            'TabPosition',         'bottom', ...
            'TabSize',             10, ...
            'ForegroundColor',     [1 1 1], ...
            'HighlightColor',      [1 0 1], ...
            'ShadowColor',         [0 0 0], ...
            'FontAngle',           'normal', ...
            'FontName',            'Arial', ...
            'FontSize',            20, ...
            'FontUnits',           'points', ...
            'FontWeight',          'bold'
            }};
        ConstructorArgs = {{
            'Units',           'pixels', ...
            'Position',        [10 10 400 400], ...
            'Padding',         5, ...
            'Tag',             'Test', ...
            'Visible',         'on', ...
            'FontAngle',   'normal', ...
            'FontName',    'Arial', ...
            'FontSize',    20, ...
            'FontUnits',   'points', ...
            'FontWeight',  'bold'
            }};
        ValidCallbacks = {
            {'@()disp(''function as string'');'}, ...
            {@()disp('function as anon handle')}, ...
            {{@()disp, 'function as cell'}} ...
            };
    end
    
    
    methods (Test)
        
        function testTabPanelCallbacks(testcase, ValidCallbacks)
            [obj, ~] = testcase.hBuildRGBBox('uiextras.TabPanel');
            
            set(obj, 'Callback', ValidCallbacks);
            testcase.verifyEqual(get(obj, 'Callback'), ValidCallbacks);
        end
         
        function testTabPanelOnSelectionChanged(testcase, ValidCallbacks)
            [obj, ~] = testcase.hBuildRGBBox('uiextras.TabPanel');
            
            set(obj, 'SelectionChangedFcn', ValidCallbacks);
            testcase.verifyEqual(get(obj, 'SelectionChangedFcn'), ValidCallbacks);
        end       
        
        
        function testRotate3dDoesNotAddMoreTabs(testcase)
            % test for g1129721 where rotating an axis in a panel causes
            % the axis to lose visibility.
            obj = uiextras.TabPanel();
            con = uicontainer('Parent', obj);
            axes('Parent', con, 'Visible', 'on');
            testcase.verifyNumElements(obj.TabTitles, 1);
            % equivalent of selecting the rotate button on figure window:
            rotate3d;
            testcase.verifyNumElements(obj.TabTitles, 1);
        end
    end
    
end

