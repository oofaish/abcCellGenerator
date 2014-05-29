function [ cell ] = abcNextCell( params )
%ABCNEXTCELLPARAMETERS randomly generate some fancy cell params
%   Detailed explanation goes here

    cell = struct();
    cell.radius        = abcNextPick( 'normal', params.radius,        params.radius        / params.sdDivider );
    if params.randomiseNucleusRadius
        cell.nucleusRadius = abcNextPick( 'normal', params.nucleusRadius, params.nucleusRadius / params.sdDivider );
    else
        cell.nucleusRadius = params.nucleusRadius;
    end
    nucleusOffset      = abcNextPick( 'normal', params.nucleusOffset, params.nucleusOffset / params.sdDivider );
    nucleusOffsetAngle = abcNextPick( 'uniform', 0, 2 * pi, false );
    
    if( params.randomiseMajorVsMinor )
        cell.majorVsMinor  = abcNextPick( 'normal', params.majorVsMinor,  params.majorVsMinor  / params.sdDivider, false );
    else
        cell.majorVsMinor  = params.majorVsMinor;
    end
        
    if cell.majorVsMinor < 1
        cell.majorVsMinor = 1 / cell.majorVsMinor;
    end
    
    cell.majorVsMinorAngle = abcNextPick( 'uniform', 0, pi, false );
        
    if params.randomiseAlpha
        cell.alpha         = abcNextPick( 'normal', params.alpha,         0.05, false );%no rounding
        cell.nucleusAlpha  = abcNextPick( 'normal', params.nucleusAlpha,  0.05, false );%no rounding
    else
        cell.alpha = params.alpha;
        cell.nucleusAlpha = params.nucleusAlpha;
    end
    
    assert( strcmp( params.cellShape, 'circle' ), 'Only Circle Cells currently supported' );

    [ cell.x, cell.y ] = abcCellCenter( cell.radius, params.canvasSize );
    
    cell.nucleusX = round( cell.x + nucleusOffset * sin( nucleusOffsetAngle ) );
    cell.nucleusY = round( cell.y + nucleusOffset * cos( nucleusOffsetAngle ) );
    
end

