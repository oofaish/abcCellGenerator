function p = abcCellParams( params )
    p = struct();
    
    p.radius = 40; %pixels;
    
    p.nucleusRadius = 7;
    p.nucleusOffset = 0;
    p.cellShape = 'circle';
    p.majorVsMinor = 1;%for drawing ellipses
    
    %transparency
    p.alpha = 0.25;
    p.nucleusAlpha = 1;
    
    p.drawNucleus = true;
    
    %if any defaults passed in, use them.
    if nargin > 0
        p = abcStructureUnion( params, p );
    end
end
