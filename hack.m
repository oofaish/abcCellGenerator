

params = abcParams();
for j = 1:10%generate 10 images
    
    if params.blurredRandomBackground
        canvas = rand( params.canvasSize ) / 10 + 0.9;
        gaussianBlur  = fspecial( 'gaussian',[3 3], 5 );
        canvas = imfilter( canvas, gaussianBlur,'same');
    else
        canvas = abcEmptyCanvas( params.canvasSize,  true );
    end

    mask   = abcEmptyCanvas( params.canvasSize, false );
    nucleusMask = abcEmptyCanvas( params.canvasSize, false );
    allWhite = abcEmptyCanvas( params.canvasSize, true );

    cellCount = abcNextPick( 'normal', params.totalNumberOfCells, params.totalNumberOfCells    / params.sdDivider );
    
    for i = 1:cellCount
        cell = abcNextCell( params );    
        [ cellCanvas, cellMask, cellIndex, nucleusCanvas, nucleusMask, nucleusIndex ] = abcDrawCell( cell, params.canvasSize );

        mask( cellIndex ) = 1;
        nucleusMask( nucleusIndex ) = 1;

        %FIXME: there must be a better way of doing this - I am not sure what
        %imfuse is doing to be honest.
        canvas = cellCanvas .* canvas;

        canvas( nucleusIndex ) = ( 1- cell.nucleusAlpha );
    end

    gaussianBlur  = fspecial( 'gaussian',[3 3], 0.2 );
    blurredCanvas = imfilter( canvas, gaussianBlur,'same');

    %imshow( blurredCanvas );
    imwrite( blurredCanvas, ['w_example_', num2str( j ), '.jpg' ] );
end
    
    
%for each clump

%pick radius of the cell
%pick radius of the nucleus
%pick the offset for the nucleus

%generate cell

%pick radius of the next cell
%pick radius of the nucleus

%pick overlap (between 0 and maxOverlap)
%pick an angle between 0 and 2pi
%pick an offset for nucleus

%pick a cell
