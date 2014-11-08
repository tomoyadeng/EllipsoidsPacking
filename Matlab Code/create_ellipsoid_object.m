function ellipsoid_object = create_ellipsoid_object( x, y, z, a, b, c, theta, phi, psi )
% Create ellipsoid object with nine coordinates 
% x,y,z   are the ellipsoidal center cordinates
% a,b,c  are semi-axes of ellipsoids
% theta, phi, psi are Euler angles of ellipsoids
%

% refer to the Euler angle
axis_Matrix = [1/a^2, 0, 0; 0, 1/b^2, 0; 0, 0, 1/c^2];

Rotation_Matrix = [cos(theta) * cos(phi) * cos(psi) - sin(phi) * sin(psi),...
                   cos(theta) * sin(phi) * cos(psi) + cos(phi) * sin(psi),...
                   -sin(theta) *cos(psi);...
                   -cos(theta) * cos(phi) * sin(psi) - sin(phi) * cos(psi),...
                   -cos(theta) * sin(phi) * sin(psi) + cos(phi) * cos(psi),...
                   sin(theta) * sin(psi);...
                   sin(theta) * cos(phi), sin(theta) * sin(phi), cos(theta)];

shape_Matrix = Rotation_Matrix * axis_Matrix * Rotation_Matrix';

center_Vector = [x; y; z];

% make sure the matrix is positive defined 
shape_Matrix = round(shape_Matrix * 10000) / 10000;

%create ellipsoidal object by calling the ellipsoid function of
%EllipsoidsToolsBox
ellipsoid_object = ellipsoid(center_Vector,shape_Matrix);
end

