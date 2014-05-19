function [ cellCanvas, cellMask, cellIndex, nucleusCanvas, nucleusMask, nucleusIndex ] = abcDrawCell( cell, canvasSize )
%ABCDRAWCELL Summary of this function goes here
%   Detailed explanation goes here
    
    hCounter = 1:canvasSize( 1 );
    wCounter =  1:canvasSize( 2 );
    
    nucleusMask   = bsxfun( @plus, ( hCounter - cell.nucleusX ).^2, ( wCounter' - cell.nucleusY ).^2 ) < cell.nucleusRadius^2;
    %create the mask for the new cell
    if cell.majorVsMinor == 1
        cellMask      = bsxfun( @plus, ( hCounter - cell.x        ).^2, ( wCounter' - cell.y        ).^2 ) < cell.radius^2;
    else
        focalDistance = cell.radius * ( cell.majorVsMinor ^ 2 - 1 ) ^ 0.5;
        focus1x = round( cell.x + focalDistance * sin( cell.majorVsMinorAngle ) );
        focus1y = round( cell.y + focalDistance * cos( cell.majorVsMinorAngle ) );
        focus2x = round( cell.x - focalDistance * sin( cell.majorVsMinorAngle ) );
        focus2y = round( cell.y - focalDistance * cos( cell.majorVsMinorAngle ) );
        [ x, y ] = meshgrid(hCounter, wCounter );
        tmp = struct();
        tmp.f1  = ( ( x - focus1x ) .^ 2 + ( y - focus1y ) .^ 2 ) .^ 0.5;%distance to focus 1
        tmp.f2  = ( ( x - focus2x ) .^ 2 + ( y - focus2y ) .^ 2 ) .^ 0.5;%distance to focus 2
        tmp.fx2 = 2 * focalDistance;
        cellMask = ( tmp.f1 + tmp.f2 + tmp.fx2 ) <= ( tmp.fx2 + cell.majorVsMinor * cell.radius * 2 );
    end
        
    cellIndex         = (    cellMask ~= 0 );
    nucleusIndex      = ( nucleusMask ~= 0 );
    
    cellCanvas                     = abcEmptyCanvas( canvasSize, true );
    cellCanvas( cellIndex )        = ( 1 - cell.alpha );
    nucleusCanvas                  = abcEmptyCanvas( canvasSize, true );
    nucleusCanvas( nucleusIndex )  = 0;
end

