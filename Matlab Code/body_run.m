function body_run(is_from_file)

%  The key function of the entire project
%  Compress the packing cube utill the compressing rate reach the precision


    global ellipsoids_center;
    global ellipsoids_axis;
    global euler_angle;
   % global interMatrix;
 %   global arrEllipsoids;
    global initial_rate;
    global tolerate_rate;
 %   global border_width;
    global numsMirror;
 %   global NUMBER_OF_ELLIPSOIDS;        
    global ORIGINAL_EDGE_OF_TANK;
 %   global ellipsoids_volume;
    global fid;
    global my_count;
    
    %check if get the ellipsoids state from stored file 
    if(is_from_file > 0)
        restore_state_from_file(is_from_file);
        my_count = is_from_file;
        make_elltool_objects();
        return;
        check_all(0);
    end

    %indicate that if we should save the state of ellipsoids
    %we must ensure that the state we stored are non-overlap
    should_save = 1;    
	
    while 1
        fprintf('loop %d  edge = %d\n', my_count, ORIGINAL_EDGE_OF_TANK);
        fprintf(fid,'loop %d  edge = %d\n', my_count, ORIGINAL_EDGE_OF_TANK);
        my_count = my_count + 1;
        
        if should_save == 1
            old_cent  			= ellipsoids_center;
            old_axis 			= ellipsoids_axis;
            old_angle 			= euler_angle;
            old_nums_mirror  	= numsMirror;
            old_edge         	= ORIGINAL_EDGE_OF_TANK;
        end
        
        fprintf('space shrinking...\n');
        shrink_space(initial_rate);
        
        fprintf('rate = %d\n\n', initial_rate);
        is_intersect = check_all(0);
        
        is_done = 1;
        

        %if any ellipsoids intersect, try overlap elimination
        if is_intersect == 1
         %   save
            [is_done] = overlap_elimination();
        end
        
        %when overlap elimination fails, restore the last compressed state
        % diminish the compressed rate and redo space shrinking
        if(is_done == 0)
            should_save = 0;
            restore_space(initial_rate);
            initial_rate = initial_rate * 0.8;  
        else
            should_save = 1;
        end
        
        %when the present rate less than the precison, end the shrinking
        %process
		if (initial_rate < tolerate_rate)
            break;
        end
		
        %save the compressed state
		save_state_to_file(my_count);    
    end
    
    %ensure the stored ellipsoids state are non-overlap when the shrinking
    %process ends
    ellipsoids_center 		= old_cent;
    ellipsoids_axis 		= old_axis;
    euler_angle             = old_angle;
    numsMirror 				= old_nums_mirror;
    ORIGINAL_EDGE_OF_TANK 	= old_edge;
    
end

