classdef Viewport < uix.Container & uix.mixin.Panel
    %uix.Viewport  Scrolling panel
    %
    %  b = uix.Viewport(p1,v1,p2,v2,...) constructs a scrolling panel and
    %  sets parameter p1 to value v1, etc.
    %
    %  A scrolling panel is a standard container (uicontainer) that shows
    %  one its contents and hides the others.
    %
    %  See also: uix.Panel, uix.BoxPanel, uix.TabPanel, uicontainer
    
    %  Copyright 2009-2016 The MathWorks, Inc.
    %  $Revision: 1165 $ $Date: 2015-12-06 03:09:17 -0500 (Sun, 06 Dec 2015) $
    
    properties( Dependent )
        Heights % heights of contents, in pixels and/or weights
        VerticalOffsets % vertical offsets of contents, in pixels
        VerticalSteps % vertical slider steps, in pixels
        Widths % widths of contents, in pixels and/or weights
        HorizontalOffsets % horizontal offsets of contents, in pixels
        HorizontalSteps % horizontal slider steps, in pixels
    end
    
    properties( Access = protected )
        Heights_ = zeros( [0 1] ) % backing for Heights
        Widths_ = zeros( [0 1] ) % backing for Widths
        HorizontalSliders = matlab.ui.control.UIControl.empty( [0 1] ) % sliders
        VerticalSliders = matlab.ui.control.UIControl.empty( [0 1] ) % sliders
    end
    
    properties( Constant, Access = protected )
        SliderSize = 20 % slider size, in pixels
    end
    
    methods
        
        function obj = Viewport( varargin )
            %uix.Viewport  Scrolling panel constructor
            %
            %  p = uix.Viewport() constructs a scrolling panel.
            %
            %  p = uix.Viewport(p1,v1,p2,v2,...) sets parameter p1 to
            %  value v1, etc.
            
            % Set properties
            if nargin > 0
                uix.pvchk( varargin )
                set( obj, varargin{:} )
            end
            
        end % constructor
        
    end % structors
    
    methods
        
        function value = get.Heights( obj )
            
            value = obj.Heights_;
            
        end % get.Heights
        
        function set.Heights( obj, value )
            
            % For those who can't tell a column from a row...
            if isrow( value )
                value = transpose( value );
            end
            
            % Check
            assert( isa( value, 'double' ), 'uix:InvalidPropertyValue', ...
                'Property ''Heights'' must be of type double.' )
            assert( all( isreal( value ) ) && ~any( isinf( value ) ) && ...
                ~any( isnan( value ) ), 'uix:InvalidPropertyValue', ...
                'Elements of property ''Heights'' must be real and finite.' )
            assert( isequal( size( value ), size( obj.Contents_ ) ), ...
                'uix:InvalidPropertyValue', ...
                'Size of property ''Heights'' must match size of contents.' )
            
            % Set
            obj.Heights_ = value;
            
            % Mark as dirty
            obj.Dirty = true;
            
        end % set.Heights
        
        function value = get.VerticalOffsets( obj )
            
            sliders = obj.VerticalSliders;
            if isempty( sliders )
                value = zeros( size( sliders ) );
            else
                value = vertcat( sliders.Value );
            end
            
        end % get.VerticalOffsets
        
        function set.VerticalOffsets( obj, value )
            
            % Check
            % TODO
            
            % Set
            % TODO
            
            % Mark as dirty
            obj.Dirty = true;
            
        end % set.VerticalOffsets
        
        function value = get.VerticalSteps( obj )
            
            sliders = obj.VerticalSliders;
            if isempty( sliders )
                value = zeros( size( sliders ) );
            else
                value = vertcat( sliders.SliderStep(2) );
            end
            
        end % get.VerticalSteps
        
        function set.VerticalSteps( obj, value )
            
            % Check
            % TODO
            
            % Set
            % TODO
            
        end % set.VerticalSteps
        
        function value = get.Widths( obj )
            
            value = obj.Widths_;
            
        end % get.Widths
        
        function set.Widths( obj, value )
            
            % For those who can't tell a column from a row...
            if isrow( value )
                value = transpose( value );
            end
            
            % Check
            assert( isa( value, 'double' ), 'uix:InvalidPropertyValue', ...
                'Property ''Widths'' must be of type double.' )
            assert( all( isreal( value ) ) && ~any( isinf( value ) ) && ...
                ~any( isnan( value ) ), 'uix:InvalidPropertyValue', ...
                'Elements of property ''Widths'' must be real and finite.' )
            assert( isequal( size( value ), size( obj.Contents_ ) ), ...
                'uix:InvalidPropertyValue', ...
                'Size of property ''Widths'' must match size of contents.' )
            
            % Set
            obj.Widths_ = value;
            
            % Mark as dirty
            obj.Dirty = true;
            
        end % set.Widths
        
        function value = get.HorizontalOffsets( obj )
            
            sliders = obj.HorizontalSliders;
            if isempty( sliders )
                value = zeros( size( sliders ) );
            else
                value = vertcat( sliders.Value );
            end
            
        end % get.HorizontalOffsets
        
        function set.HorizontalOffsets( obj, value )
            
            % Check
            % TODO
            
            % Set
            % TODO
            
            % Mark as dirty
            obj.Dirty = true;
            
        end % set.HorizontalOffsets
        
        function value = get.HorizontalSteps( obj )
            
            sliders = obj.HorizontalSliders;
            if isempty( sliders )
                value = zeros( size( sliders ) );
            else
                value = vertcat( sliders.SliderStep(2) );
            end
            
        end % get.HorizontalSteps
        
        function set.HorizontalSteps( obj, value )
            
            % Check
            % TODO
            
            % Set
            obj.HorizontalSlider.SliderStep(2) = value;
            
        end % set.HorizontalSteps
        
    end % accessors
    
    methods( Access = protected )
        
        function redraw( obj )
            %redraw  Redraw
            
            % Compute positions
            bounds = hgconvertunits( ancestor( obj, 'figure' ), ...
                [0 0 1 1], 'normalized', 'pixels', obj );
            width = bounds(3);
            height = bounds(4);
            padding = obj.Padding_;
            sliderSize = obj.SliderSize; % slider size
            n = numel( obj.Contents_ );
            selection = obj.Selection_;
            vSliders = obj.VerticalSliders;
            hSliders = obj.HorizontalSliders;
            for ii = 1:n
                vSlider = vSliders(ii);
                hSlider = hSliders(ii);
                if ii == selection
                    contentsWidth = obj.Widths_(ii);
                    contentsHeight = obj.Heights_(ii);
                    vSliderWidth = sliderSize * (contentsHeight > height);
                    hSliderHeight = sliderSize * (contentsWidth > width );
                    vSliderHeight = height - 2 * padding - hSliderHeight;
                    hSliderWidth = width - 2 * padding - vSliderWidth;
                    widths = uix.calcPixelSizes( width, [contentsWidth; vSliderWidth], [1; 1], padding, 0 );
                    heights = uix.calcPixelSizes( height, [contentsHeight; hSliderHeight], [1; 1], padding, 0 );
                    contentsWidth = widths(1);
                    contentsHeight = heights(1);
                    contentsPosition = [padding+1 height-padding-contentsHeight+1 contentsWidth contentsHeight];
                    vSliderPosition = [width-padding-vSliderWidth+1 height-padding-vSliderHeight+1 vSliderWidth vSliderHeight];
                    hSliderPosition = [padding+1 padding+1 hSliderWidth hSliderHeight];
                    obj.redrawContents( contentsPosition )
                    vSlider.Position = vSliderPosition;
                    vSlider.Visible = 'on';
                    hSlider.Position = hSliderPosition;
                    hSlider.Visible = 'on';
                else
                    vSlider.Visible = 'off';
                    hSlider.Visible = 'off';
                end
            end
            
        end % redraw
        
        function addChild( obj, child )
            %addChild  Add child
            %
            %  c.addChild(d) adds the child d to the container c.
            
            % Add to sizes
            obj.Widths_(end+1,:) = -1;
            obj.Heights_(end+1,:) = -1;
            obj.VerticalSliders(end+1,:) = uicontrol( ...
                'Internal', true, 'Parent', obj, ...
                'Style', 'slider', 'Callback', @obj.onSliderClicked );
            obj.HorizontalSliders(end+1,:) = uicontrol( ...
                'Internal', true, 'Parent', obj, ...
                'Style', 'slider', 'Callback', @obj.onSliderClicked );
            
            % Call superclass method
            addChild@uix.mixin.Panel( obj, child )
            
        end % addChild
        
        function removeChild( obj, child )
            %removeChild  Remove child
            %
            %  c.removeChild(d) removes the child d from the container c.
            
            % Remove from sizes
            tf = obj.Contents_ == child;
            obj.Widths_(tf,:) = [];
            obj.Heights_(tf,:) = [];
            obj.VerticalSliders(tf,:) = [];
            obj.HorizontalSliders(tf,:) = [];
            
            % Call superclass method
            removeChild@uix.mixin.Panel( obj, child )
            
        end % removeChild
        
        function reorder( obj, indices )
            %reorder  Reorder contents
            %
            %  c.reorder(i) reorders the container contents using indices
            %  i, c.Contents = c.Contents(i).
            
            % Reorder
            obj.Widths_ = obj.Widths_(indices,:);
            obj.Heights_ = obj.Heights_(indices,:);
            obj.VerticalSliders = obj.VerticalSliders(indices,:);
            obj.HorizontalSliders = obj.HorizontalSliders(indices,:);
            
            % Call superclass method
            reorder@uix.mixin.Panel( obj, indices )
            
        end % reorder
        
    end % template methods
    
    methods( Access = private )
        
        function onSliderClicked( obj, ~, ~ )
            %onSliderClicked  Event handler
            
            % Mark as dirty
            obj.Dirty = true;
            
        end % onSliderClicked
        
    end % event handlers
    
end % classdef