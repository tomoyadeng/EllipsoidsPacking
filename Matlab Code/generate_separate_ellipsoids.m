function generate_separate_ellipsoids()
% Generate non-intersect ellipsoids


    global numsMirror;
    global NUMBER_OF_ELLIPSOIDS;
    global interMatrix;
    global ellipsoids_volume;
    global ellipsoids_axis;
    
    % Generate ellipsoids and mirror ellipsoids
     for i = 1:NUMBER_OF_ELLIPSOIDS
            create_ellipsoids(i);
            numsMirror(i) = 0;
            create_mirror(i);     
     end
     
    % Refresh ellipsoidal objects
    make_elltool_objects();
     
    is_intersect = 1;
    
    while is_intersect == 1
        
        fprintf('\nGenerate elltool objects...\n');
       
        % Check all the ellipsoidal status, if any intersecting object,
        % regenerate a new ellipsoidal object and replace it 
        is_intersect = check_all(0);  
        
        intsec = find(interMatrix == 1);
        
        if isempty(intsec) == 0 
            intsec_length = numel(intsec);
            
            for j = 1:intsec_length
                create_ellipsoids(intsec(j));
                create_mirror(intsec(j));
            end   
            
            fprintf('Intersection: TRUE\n');
        else
            is_intersect = 0;
            fprintf('Intersection: NONE\n');
            disp('Ellipsoidal initialization: done')
        end 
       
    end

   % Caculate each of the ellipsoid's volume
   for i = 1:NUMBER_OF_ELLIPSOIDS
        ellipsoids_volume(i) = ellipsoids_axis(1,i)*ellipsoids_axis(2,i)*ellipsoids_axis(3,i)*4*pi/3;
   end

end

