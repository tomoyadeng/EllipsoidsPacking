function make_elltool_objects()

%Generate or refresh ellipsoidal objects
    global ellipsoids_center;
    global ellipsoids_axis;
    global euler_angle;
    global arrEllipsoids;
    global NUMBER_OF_ELLIPSOIDS;
    global numsMirror;
    
    %[all_ellipsoids_index, ellipsoids_number] = get_all_ellipsoids_index();
    
    for i = 1:NUMBER_OF_ELLIPSOIDS;
      %  index = all_ellipsoids_index(i);
        
        center = ellipsoids_center(1:3, i);
        axis = ellipsoids_axis(1:3, i);
        angle = euler_angle(1:3, i);
        arrEllipsoids(i) = create_ellipsoid_object(center(1), center(2), center(3), ...
            axis(1), axis(2), axis(3), angle(1), angle(2), angle(3));
        
        create_mirror(i);
        
        for j = 1:numsMirror(i)
            t_no = j*NUMBER_OF_ELLIPSOIDS + i;
            ellipsoids_axis(1:3, t_no) = ellipsoids_axis(1:3, i);
            euler_angle(1:3, t_no) = euler_angle(1:3, i);
        end
    end
    
 
end

