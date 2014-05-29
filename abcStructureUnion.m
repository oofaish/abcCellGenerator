function [ newS ] = abcStructureUnion( s1, s2 )
%ABCSTRUCTUREUNION structure Union
%   s1 takes priority in values - will return all fields

    newS = s2;
    s1Fields = fieldnames( s1 );
    for i=1:numel( s1Fields )
        newS.( s1Fields{i} ) = s1.( s1Fields{i} );
    end
end

