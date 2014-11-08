function  create_ellipsoids( count )
%
%   Create random ellipsoids which volume has a log-normal 
%   distribution in a given space.
% 
%    A_B         A is devided by B
%    C_B         C is devided by B
    
    global ellipsoids_center;
    global ellipsoids_axis;
    global euler_angle;
    global ORIGINAL_EDGE_OF_TANK; 
    global A_B;
    global C_B;
    
    [a, b, c] = get_axis(A_B, C_B);
    
    ellipsoids_axis(1, count) = a;
    ellipsoids_axis(2, count) = b;
    ellipsoids_axis(3, count) = c;

    x = rand() * 2 * ORIGINAL_EDGE_OF_TANK - ORIGINAL_EDGE_OF_TANK; 
    y = rand() * 2 * ORIGINAL_EDGE_OF_TANK - ORIGINAL_EDGE_OF_TANK;
    z = rand() * 2 * ORIGINAL_EDGE_OF_TANK - ORIGINAL_EDGE_OF_TANK;
    
    ellipsoids_center(1, count) = x;
    ellipsoids_center(2, count) = y;
    ellipsoids_center(3, count) = z;

    phi = rand() * pi * 2;
    costh = rand() * 2 - 1;
    theta = acos( costh );
    psi = rand() * pi * 2;

    euler_angle(1, count) = theta;
    euler_angle(2, count) = phi;
    euler_angle(3, count) = psi;
end

