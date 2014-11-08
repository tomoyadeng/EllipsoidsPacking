function create_mirror(real_no)
% create the mirror ellipsoid accooring to the position of the real
% ellipsoid, different condition have different mirror number
% 0, 1, 3, 7 are posible

    global ORIGINAL_EDGE_OF_TANK;
    global ellipsoids_center;
    global numsMirror;
    global NUMBER_OF_ELLIPSOIDS;
    global ellipsoids_axis;
    global euler_angle;
    global arrEllipsoids;
    global MAX_LENGTH_OF_AXIS
    
    numsMirror(real_no) = 0;
    
    center_xyz = ellipsoids_center(1:3, real_no);
    center_x = center_xyz(1);
    center_y = center_xyz(2);
    center_z = center_xyz(3);
    
    a = ellipsoids_axis(1, real_no);
    b = ellipsoids_axis(2, real_no);
    c = ellipsoids_axis(3, real_no);
    theta = euler_angle(1, real_no);
    phi	= euler_angle(2, real_no);
    psi = euler_angle(3, real_no);
 

    if ((abs(center_x) > (ORIGINAL_EDGE_OF_TANK - MAX_LENGTH_OF_AXIS)) && (abs(center_x) < ORIGINAL_EDGE_OF_TANK))
      numsMirror(real_no) = numsMirror(real_no) + 1;  
    end
    
    if ((abs(center_y) > (ORIGINAL_EDGE_OF_TANK - MAX_LENGTH_OF_AXIS)) && (abs(center_y) < ORIGINAL_EDGE_OF_TANK))
      numsMirror(real_no) = numsMirror(real_no) + 2;  
    end
    
    if ((abs(center_z) > (ORIGINAL_EDGE_OF_TANK - MAX_LENGTH_OF_AXIS)) && (abs(center_z) < ORIGINAL_EDGE_OF_TANK))
      numsMirror(real_no) = numsMirror(real_no) + 4;       
    end
    
    t_no = NUMBER_OF_ELLIPSOIDS + real_no;
    
    x = ellipsoids_center(1, real_no);
    y = ellipsoids_center(2, real_no);
    z = ellipsoids_center(3, real_no);
    
    X = -x*abs(2*ORIGINAL_EDGE_OF_TANK-abs(x))/abs(x);
    Y = -y*abs(2*ORIGINAL_EDGE_OF_TANK-abs(y))/abs(y);
    Z = -z*abs(2*ORIGINAL_EDGE_OF_TANK-abs(z))/abs(z);
    
    switch numsMirror(real_no)
        case 1
            arrEllipsoids(t_no) = create_ellipsoid_object(X, y, z, a, b, c, theta, phi, psi);
            ellipsoids_center(1:3, t_no) = [X;y;z];
            numsMirror(real_no) = 1;
        case 2
            arrEllipsoids(t_no) = create_ellipsoid_object(x, Y, z, a, b, c, theta, phi, psi);
            ellipsoids_center(1:3, t_no) = [x;Y;z];
            numsMirror(real_no) = 1;
        case 4
            arrEllipsoids(t_no) = create_ellipsoid_object(x, y, Z, a, b, c, theta, phi, psi);
            ellipsoids_center(1:3, t_no) = [x;y;Z];
            numsMirror(real_no) = 1;
        case 3
           arrEllipsoids(t_no) = create_ellipsoid_object(X, y, z, a, b, c, theta, phi, psi);
           ellipsoids_center(1:3, t_no) = [X;y;z];
           t_no = NUMBER_OF_ELLIPSOIDS*2 + real_no;
           arrEllipsoids(t_no) = create_ellipsoid_object(x, Y, z, a, b, c, theta, phi, psi);
           ellipsoids_center(1:3, t_no) = [x;Y;z];
           t_no = NUMBER_OF_ELLIPSOIDS*3 + real_no;
           ellipsoids_center(1:3, t_no) = [X;Y;z];
           arrEllipsoids(t_no) = create_ellipsoid_object(X, Y, z, a, b, c, theta, phi, psi);
           numsMirror(real_no) = 3;
        case 5
           arrEllipsoids(t_no) = create_ellipsoid_object(X, y, z, a, b, c, theta, phi, psi);
           ellipsoids_center(1:3, t_no) = [X;y;z];
           t_no = NUMBER_OF_ELLIPSOIDS*2 + real_no;
           ellipsoids_center(1:3, t_no) = [x;y;Z];
           arrEllipsoids(t_no) = create_ellipsoid_object(x, y, Z, a, b, c, theta, phi, psi);
           t_no = NUMBER_OF_ELLIPSOIDS*3 + real_no;
           ellipsoids_center(1:3, t_no) = [X;y;Z];
           arrEllipsoids(t_no) = create_ellipsoid_object(X, y, Z, a, b, c, theta, phi, psi);
           numsMirror(real_no) = 3;
        case 6
           arrEllipsoids(t_no) = create_ellipsoid_object(x, Y, z, a, b, c, theta, phi, psi);
           ellipsoids_center(1:3, t_no) = [x;Y;z];
           t_no = NUMBER_OF_ELLIPSOIDS*2 + real_no;
           arrEllipsoids(t_no) = create_ellipsoid_object(x, y, Z, a, b, c, theta, phi, psi);
           ellipsoids_center(1:3, t_no) = [x;y;Z];
           t_no = NUMBER_OF_ELLIPSOIDS*3 + real_no;
           ellipsoids_center(1:3, t_no) = [x;Y;Z];
           arrEllipsoids(t_no) = create_ellipsoid_object(x, Y, Z, a, b, c, theta, phi, psi);
           numsMirror(real_no) = 3;
        case 7
           ellipsoids_center(1:3, t_no) = [X;y;z];
           arrEllipsoids(t_no) = create_ellipsoid_object(X, y, z, a, b, c, theta, phi, psi);
           t_no = NUMBER_OF_ELLIPSOIDS*2 + real_no;
           ellipsoids_center(1:3, t_no) = [x;Y;z];
           arrEllipsoids(t_no) = create_ellipsoid_object(x, Y, z, a, b, c, theta, phi, psi);
           t_no = NUMBER_OF_ELLIPSOIDS*3 + real_no;
           ellipsoids_center(1:3, t_no) = [x;y;Z];
           arrEllipsoids(t_no) = create_ellipsoid_object(x, y, Z, a, b, c, theta, phi, psi);
           t_no = NUMBER_OF_ELLIPSOIDS*4 + real_no;
           ellipsoids_center(1:3, t_no) = [X;Y;z];
           arrEllipsoids(t_no) = create_ellipsoid_object(X, Y, z, a, b, c, theta, phi, psi);
           t_no = NUMBER_OF_ELLIPSOIDS*5 + real_no;
           ellipsoids_center(1:3, t_no) = [X;y;Z];
           arrEllipsoids(t_no) = create_ellipsoid_object(X, y, Z, a, b, c, theta, phi, psi);
           t_no = NUMBER_OF_ELLIPSOIDS*6 + real_no;
           ellipsoids_center(1:3, t_no) = [x;Y;Z];
           arrEllipsoids(t_no) = create_ellipsoid_object(x, Y, Z, a, b, c, theta, phi, psi);
           t_no = NUMBER_OF_ELLIPSOIDS*7 + real_no;
           ellipsoids_center(1:3, t_no) = [X;Y;Z];
           arrEllipsoids(t_no) = create_ellipsoid_object(X, Y, Z, a, b, c, theta, phi, psi);
           numsMirror(real_no) = 7;
        otherwise
           arrEllipsoids(real_no) = create_ellipsoid_object(x, y, z, a, b, c, theta, phi, psi);
    end
    
    for j = 1:numsMirror(real_no)
            t_no = j*NUMBER_OF_ELLIPSOIDS + real_no;
            ellipsoids_axis(1:3, t_no) = ellipsoids_axis(1:3, real_no);
            euler_angle(1:3, t_no) = euler_angle(1:3, real_no);
     end

end