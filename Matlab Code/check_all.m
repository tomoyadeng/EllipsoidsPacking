function is_intersect = check_all(is_once)
% check the entire space, identify the ellipsoids intersect or not

    global NUMBER_OF_ELLIPSOIDS;
    global interMatrix;
    global ellipsoids_center;
    global arrEllipsoids;
    global ellipsoids_axis;
    
	make_elltool_objects();
    %fprintf('Checking intersection... \n');
    
	% initializing intersecting state
    is_intersect = 0;
    interMatrix(:) = 0;

	% get all the ellipsoids' number, real and mirror included.
    [all_ellipsoids_index, ellipsoids_number] = get_all_ellipsoids_index();
	
    for i = 1:NUMBER_OF_ELLIPSOIDS
        
        if interMatrix(i) == 1
            continue;
        end
        
        for j = 1:ellipsoids_number
            index  = all_ellipsoids_index(j);
            
            if index == i 
                continue;
            end
            
            center1 = ellipsoids_center(1:3, i);
            center2 = ellipsoids_center(1:3, index);
            
            max_length = max(ellipsoids_axis(1:3, i)) + max(ellipsoids_axis(1:3, index));
            if norm(center1-center2) < max_length
                temp = intersect(arrEllipsoids(i), arrEllipsoids(index));
                
                if temp == 1
                    is_intersect = 1;
                    interMatrix(i) = 1;
                    tindex = get_real_no(index);
                    interMatrix(tindex) = 1;
                    if is_once == 1
                        return;
                    end
                    break;
                end
                
            end
        end
    end
end