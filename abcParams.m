function [ p ] = abcParams( params )
%PARMS quick function to setup the various parameters we need
%   Nothing fancy here

        
    p = struct();
    
    p.totalNumberOfCells = 10;
    
    p.blurFinalImage = false;
    p.blurredRandomBackground = false;%otherwise,just a white background
    
    %would be neat to allow this
    %p.clumps = 1;
    %p.cellsPerClump = 10;
    
    p.valuesAreExact = false;%otherwise, it will randomize them a little
    p.sdDivider = 5; %mean / sdDivider is the value used for standard Deviation when randomising
    
    %sizing
    p.canvasSize = [ 512 512 ];%both height and width
    
    p.randomiseMajorVsMinor = true;
    p.randomiseAlpha = false;
    p.randomiseNucleusRadius = false;
    p.overlapMethod = 'multiplicative';%additive
    
    %not currently implemented
    %p.maxOverlap = 10;%pixels

    %now get single cell parameters.
    p = abcStructureUnion( p, abcCellParams() );
    
    %if any defaults passed in, use them.
    if nargin > 0
        p = abcStructureUnion( params, p );
    end
    
end

