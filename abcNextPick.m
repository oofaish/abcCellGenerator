function [ v ] = abcNextPick( distribution, meanOrMinValue, sdOrMaxValue, shouldRound )
%NEXTPICK pick fom a normal variable, 
%   
    if strcmp( distribution, 'normal' )
        v = meanOrMinValue + ( randn( 1 ) * sdOrMaxValue );    
    elseif strcmp( distribution, 'uniform' )
        v = rand(1) * ( sdOrMaxValue - meanOrMinValue ) + meanOrMinValue;
    else
        assert( 0, [ 'Unknown distribution ' distribution ] ); 
    end
    
    if nargin < 4 || shouldRound 
        v = round( v );
    end
end

