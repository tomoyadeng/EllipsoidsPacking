function shrink_space(rate)
% Shrinking space according to RSA
% Keep the shape of ellipsoids unchanged
% Change the center cordinates

    global NUMBER_OF_ELLIPSOIDS;
    global ORIGINAL_EDGE_OF_TANK;       
    global numsMirror;
    global t_rate;
    global ellipsoids_center;
   % global arrEllipsoids;
    
    t_rate = rate;
    rate = (1 - rate) ^ (1/3);
    ORIGINAL_EDGE_OF_TANK = ORIGINAL_EDGE_OF_TANK * rate;
    
 % update the mirror state since the real ellipsodal  position changed   
    for i = 1:NUMBER_OF_ELLIPSOIDS
        t_cent = ellipsoids_center(1:3, i).* rate;
        ellipsoids_center(1:3, i) = t_cent;
        %arrEllipsoids(i) = ellipsoid(ellipsoids_center(1:3, i), arrEllipsoids(i).getShapeMat());
        numsMirror(i) = 0;
        create_mirror(i);
    end
    
end

