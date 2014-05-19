function [ cell ] = abcNextCell( params )
%ABCNEXTCELLPARAMETERS randomly generate some fancy cell params
%   Detailed explanation goes here

    cell = struct();
    cell.radius        = abcNextPick( 'normal', params.cellRadius,    params.cellRadius    / params.sdDivider );
    cell.nucleusRadius = abcNextPick( 'normal', params.nucleusRadius, params.nucleusRadius / params.sdDivider );
    nucleusOffset      = abcNextPick( 'normal', params.nucleusOffset, params.nucleusOffset / params.sdDivider );
    nucleusOffsetAngle = abcNextPick( 'uniform', 0, 2 * pi, false );
    
    cell.majorVsMinor  = abcNextPick( 'normal', params.majorVsMinor,  params.majorVsMinor  / params.sdDivider, false );
    if cell.majorVsMinor < 1
        cell.majorVsMinor = 1 / cell.majorVsMinor;
    end
    cell.majorVsMinorAngle = abcNextPick( 'uniform', 0, 2 * pi, false );
        
    if params.randomiseAlpha
        cell.alpha         = abcNextPick( 'normal', params.cellAlpha,     0.05, false );%no rounding
        cell.nucleusAlpha  = abcNextPick( 'normal', params.nucleusAlpha,  0.05, false );%no rounding
    else
        cell.alpha = params.cellAlpha;
        cell.nucleusAlpha = params.nucleusAlpha;
    end
    
    assert( strcmp( params.cellShape, 'circle' ), 'Only Circle Cells currently supported' );

    [ cell.x, cell.y ] = abcCellCenter( cell.radius, params.canvasSize );
    
    cell.nucleusX = round( cell.x + nucleusOffset * sin( nucleusOffsetAngle ) );
    cell.nucleusY = round( cell.y + nucleusOffset * cos( nucleusOffsetAngle ) );
    
end

