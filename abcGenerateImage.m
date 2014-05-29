function [ canvas, nucleusInfos, cellInfos ] = abcGenerateImage( showImage, saveImage, imageName, params )
    
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
    %allWhite    = abcEmptyCanvas( params.canvasSize, true );
    
    
    cellCount = abcNextPick( 'normal', params.totalNumberOfCells, params.totalNumberOfCells    / params.sdDivider );
    
    nucleusInfos = cell( cellCount, 1 );
    cellInfos    = cell( cellCount, 1 );
    thisNucleusInfo = struct();
    thisCellInfo    = struct();
    thisCentroid    = struct();
    
    for i = 1:cellCount
        cellParams = abcNextCell( params );    
        thisCentroid.x = cellParams.nucleusX;
        thisCentroid.y = cellParams.nucleusY;
        
        thisNucleusInfo.centroid = thisCentroid;
        
        [ thisCellCanvas, thisCellMask,thisNucleusCanvas, thisNucleusMask ] = abcDrawCell( cellParams, params.canvasSize );
        
        mask( thisCellMask == 1 ) = 1;
        nucleusMask( thisNucleusMask == 1 ) = 1;
        thisNucleusInfo.mask = nucleusMask;
        thisCellInfo.pSpace = cellParams;
        thisCellInfo.mask   = thisCellMask;
        %thisCellInfo.index = cellIndex;

        %FIXME: there must be a better way of doing this - I am not sure what
        %imfuse is doing to be honest.
        canvas = thisCellCanvas .* canvas;
        %canvas = thisNucleusCanvas .* canvas;
        %canvas( thisNucleusMask == 1 ) = ( 1- cellParams.nucleusAlpha );
        
        nucleusInfos{ i } = thisNucleusInfo;
        cellInfos{    i } = thisCellInfo;
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
    