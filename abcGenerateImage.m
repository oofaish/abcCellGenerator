function [ canvas, mask, nucleusMask ] = abcRandomCellGenerator( showImage, saveImage, imageName, params );
    
    if nargin < 3
        error( 'Need a minimum of 3 arguments' );
    end
    
    if isempty( imageName )
        imageName = [ 'abcRandomCells_', num2str( randi( 100 ) ) '.jpg' ];
    end
    
    if nargin == 4
        params = abcParams( params );
    else
        params = abcParams();
    end
    
    if params.blurredRandomBackground
        canvas = rand( params.canvasSize ) / 10 + 0.9;
        gaussianBlur  = fspecial( 'gaussian',[3 3], 5 );
        canvas = imfilter( canvas, gaussianBlur,'same');
    else
        canvas = abcEmptyCanvas( params.canvasSize,  true );
    end

    mask        = abcEmptyCanvas( params.canvasSize, false );
    nucleusMask = abcEmptyCanvas( params.canvasSize, false );
    allWhite    = abcEmptyCanvas( params.canvasSize, true );

    cellCount = abcNextPick( 'normal', params.totalNumberOfCells, params.totalNumberOfCells    / params.sdDivider );

    for i = 1:cellCount
        cell = abcNextCell( params );    
        [ cellCanvas, thisCellMask, cellIndex, thisNucleusCanvas, nucleusMask, nucleusIndex ] = abcDrawCell( cell, params.canvasSize );

        mask( cellIndex ) = 1;
        nucleusMask( nucleusIndex ) = 1;

        %FIXME: there must be a better way of doing this - I am not sure what
        %imfuse is doing to be honest.
        canvas = cellCanvas .* canvas;

        %FIXME - they way you are doing nucleus Alpah is wrong.
        canvas( nucleusIndex ) = ( 1- cell.nucleusAlpha );
    end

    if params.blurFinalImage
        gaussianBlur  = fspecial( 'gaussian',[3 3], 0.2 );
        blurredCanvas = imfilter( canvas, gaussianBlur,'same');
    else
        blurredCanvas = canvas;
    end
    
    if showImage
        imshow( blurredCanvas );
    end
    
    if saveImage
        imwrite( blurredCanvas, imageName );
    end
end
    