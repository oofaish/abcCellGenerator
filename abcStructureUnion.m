function [ newS ] = abcStructureUnion( s1, s2 )
%ABCSTRUCTUREUNION structure Union
%   s1 takes priority in values - will return all fields

    newS = s2;
    
    for fieldNames=fieldnames( s1 )
        newS.( field ) = s1.( fielendName );
    end
end

