function [ canvas ] = abcEmptyCanvas( canvasSize, white )
%ABCEMPTYCANVAS Summary of this function goes here
%   Detailed explanation goes here

    canvas = zeros( canvasSize );
    %canvas = zeros( canvasSize );

    if white
        canvas = canvas + 1;
    end

    

end

