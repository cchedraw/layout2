classdef GridFlex < uix.GridFlex
    %uiextras.GridFlex  Container with contents arranged in a resizable grid
    %
    %   obj = uiextras.GridFlex() creates a new new grid layout with
    %   draggable dividers between elements. The number of rows and columns
    %   to use is determined from the number of elements in the RowSizes
    %   and ColumnSizes properties respectively. Child elements are
    %   arranged down column one first, then column two etc. If there are
    %   insufficient columns then a new one is added. The output is a new
    %   layout object that can be used as the parent for other
    %   user-interface components. The output is a new layout object that
    %   can be used as the parent for other user-interface components.
    %
    %   obj = uiextras.GridFlex(param,value,...) also sets one or more
    %   parameter values.
    %
    %   See the <a href="matlab:doc uiextras.GridFlex">documentation</a> for more detail and the list of properties.
    %
    %   Examples:
    %   >> f = figure();
    %   >> g = uiextras.GridFlex( 'Parent', f, 'Spacing', 5 );
    %   >> uicontrol( 'Parent', g, 'Background', 'r' )
    %   >> uicontrol( 'Parent', g, 'Background', 'b' )
    %   >> uicontrol( 'Parent', g, 'Background', 'g' )
    %   >> uiextras.Empty( 'Parent', g )
    %   >> uicontrol( 'Parent', g, 'Background', 'c' )
    %   >> uicontrol( 'Parent', g, 'Background', 'y' )
    %   >> set( g, 'ColumnSizes', [-1 100 -2], 'RowSizes', [-1 -2] );
    %
    %   See also: uiextras.Grid
    %             uiextras.HBoxFlex
    %             uiextras.VBoxFlex
    %             uiextras.Empty
    
    %   Copyright 2009-2013 The MathWorks, Inc.
    %   $Revision: 366 $ $Date: 2011-02-10 15:48:11 +0000 (Thu, 10 Feb 2011) $
    
    properties( Hidden, Access = public, Dependent )
        RowSizes % deprecated
        ColumnSizes % deprecated
    end
    
    methods
        
        function obj = GridFlex( varargin )
            
            % Warn
            warning( 'uiextras:Deprecated', ...
                'uiextras.GridFlex will be removed in a future release.  Please use uix.GridFlex instead.' )
            
            % Do
            obj@uix.GridFlex( varargin{:} )
            
        end % constructor
        
    end % structors
    
    methods
        
        function value = get.RowSizes( obj )
            
            % Warn
            warning( 'uix:Deprecated', ...
                'Property ''RowSizes'' will be removed in a future release.  Please use ''Heights'' instead.' )
            
            % Get
            value = transpose( obj.Widths );
            
        end % get.RowSizes
        
        function set.RowSizes( obj, value )
            
            % Warn
            warning( 'uiextras:Deprecated', ...
                'Property ''RowSizes'' will be removed in a future release.  Please use ''Heights'' instead.' )
            
            % Set
            obj.Widths = transpose( value );
            
        end % set.RowSizes
        
        function value = get.ColumnSizes( obj )
            
            % Warn
            warning( 'uiextras:Deprecated', ...
                'Property ''ColumnSizes'' will be removed in a future release.  Please use ''Widths'' instead.' )
            
            % Get
            value = transpose( obj.Widths );
            
        end % get.ColumnSizes
        
        function set.ColumnSizes( obj, value )
            
            % Warn
            warning( 'uiextras:Deprecated', ...
                'Property ''ColumnSizes'' will be removed in a future release.  Please use ''Widths'' instead.' )
            
            % Get
            obj.Widths = transpose( value );
            
        end % set.ColumnSizes
        
    end % accessors
    
end % classdef