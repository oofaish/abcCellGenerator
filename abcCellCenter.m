function [ cellX, cellY ] = abcCellCenter( radius, imageSize )
%ABCCELLCENTER gimme a sensible values for x and y coordinates of the cell
%   In future, this should respect overlap, etc.

    cellX = abcNextPick( 'uniform', radius, imageSize( 1 ) - radius );
    cellY = abcNextPick( 'uniform', radius, imageSize( 2 ) - radius ); 

end

