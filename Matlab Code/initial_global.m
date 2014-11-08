function initial_global( )

% This function is to initialize all the variables in ellipsoids project
    tic
    fprintf('Data Initializing...');
    
    global A_B;
    global C_B;
    global NUMBER_OF_ELLIPSOIDS;
    global MAX_LENGTH_OF_AXIS;
    global ORIGINAL_EDGE_OF_TANK;
    global MAX_VOLUME;
    
    global ellipsoids_center;
    global ellipsoids_axis;
    global euler_angle;
    global ellipsoids_volume;
    global interMatrix; 
    global arrEllipsoids;    
    global initial_rate;    
    global tolerate_rate;   
    global border_width;
    global numsMirror; 
    
    %Geometrical constants of ellipsoids
    A_B = 1.25;         % semi-axis length a over b
    C_B = 0.8;          % semi-axis length c over b
    NUMBER_OF_ELLIPSOIDS =200;              % how many ellipsoids in total
    MAX_LENGTH_OF_AXIS = 2.5;               % maxinum semi-axis of ellipsoids
    ORIGINAL_EDGE_OF_TANK = 100;            % the original legth of compression area
    MAX_VOLUME  = (MAX_LENGTH_OF_AXIS ^ 3) / (A_B^2) * C_B * pi * (4 / 3);   
    % the maximum ellipsoidal volume allowed
 
    %Geometrical variables of ellipsoids 
    ellipsoids_center = zeros(3, NUMBER_OF_ELLIPSOIDS * 8);
    ellipsoids_axis = zeros(3, NUMBER_OF_ELLIPSOIDS * 8);
    euler_angle = zeros(3, NUMBER_OF_ELLIPSOIDS * 8);
    ellipsoids_volume = zeros(1,NUMBER_OF_ELLIPSOIDS);
  
  
  
   %Variables about compression
    initial_rate = 0.1;
    tolerate_rate = 0.0005;
    border_width = MAX_LENGTH_OF_AXIS * 3;
    
  %  intersection Matrix£¬interMap(i,j)=1 indicate ellipspid i intersect
  %  with ellipsoid j.
    interMatrix    = zeros(1, NUMBER_OF_ELLIPSOIDS*8);
    
   % how many mirror ellipsoids for each real ellipsoid. 
    numsMirror  = zeros(1, NUMBER_OF_ELLIPSOIDS);
    
   % ellipsoids object Matrix of the ellipsoidal toolbox for MATLAB 
    tempEllipsoid(NUMBER_OF_ELLIPSOIDS * 8 ) = ellipsoid(0, 0);   
   % Pre-allocating the array of ellipsoids variable
    arrEllipsoids = tempEllipsoid;  
    
    fprintf('done\n');
    toc
end

