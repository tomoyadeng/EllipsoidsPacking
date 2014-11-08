function [ all_index, length ] = get_all_ellipsoids_index()
%
% Get all the ellipsoids' number, real and mirror ellipsoids included. As
% the number of ellipsoids saved in a array and ellipsoids move in the space,
% some mirror ellipsoids' number may be invaild. Hence get the valid
% ellipsoids number by means of this function is neccessary.
%
% length        --      total ellipsoids
% all_index     --      the array of ellipsoids number index

	global numsMirror;
    global NUMBER_OF_ELLIPSOIDS;
    
    length = 0;
    for i = 1:NUMBER_OF_ELLIPSOIDS
        for j = 0:numsMirror(i)
            length = length + 1;
        end
    end
    
    all_index = zeros(1, length);
    
    index = 0;
    for m = 1:NUMBER_OF_ELLIPSOIDS
        for n = 0:numsMirror(m)
            ellipsoid_index = m + n * NUMBER_OF_ELLIPSOIDS;
            index = index + 1;
            all_index(index) = ellipsoid_index;
        end
    end

end

