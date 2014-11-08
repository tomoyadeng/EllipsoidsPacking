function [ is_ok ] = overlap_elimination()
%eliminate the overlap of the ellipsoid with its neighbors
          
    global interMatrix;                                          
    global numsMirror;
    global ORIGINAL_EDGE_OF_TANK;
    global border_width ;
    global ellipsoids_center;
    global euler_angle;
    global ellipsoid_in_dealing;
    global fid;
    
    i = 1;
    is_ok = 1;
    number_of_intersection = find(interMatrix == 1);
    max_iteration = 20;
    iteration = 0;
    oks=0;
    not_oks=0;
    
    while 1
        % when intersect, try eliminate
        idx = number_of_intersection(i);
        if interMatrix(idx) == 0
            continue;
        end
        
        if idx > 200
            ellipsoid_in_dealing = mod(idx,200);
        else
            ellipsoid_in_dealing = idx;
        end
        
        fprintf('ellipsoid_in_dealing = %d\n', ellipsoid_in_dealing);
        
        center = ellipsoids_center(1:3, ellipsoid_in_dealing);
        x0 = center(1);
        y0 = center(2);
        z0 = center(3);
        theta0 = euler_angle(1, ellipsoid_in_dealing);
        phi0 = euler_angle(2, ellipsoid_in_dealing);
        psi0 = euler_angle(3, ellipsoid_in_dealing);
        
%         this_flag = 0;
        
        t1 = clock;
        max_edge = ORIGINAL_EDGE_OF_TANK + border_width;
        
		%border is the fmincon scope£¬shrinking with the packing cube
        border = ORIGINAL_EDGE_OF_TANK * 0.2;    
		
        lower_bound = [-max_edge, -max_edge, -max_edge, ... 
            0, 0, 0];
        upper_bound = [max_edge, max_edge, max_edge, ... 
            pi, 2*pi, 2*pi];
        lower_bound(1) = max(lower_bound(1), x0 - border);
        lower_bound(2) = max(lower_bound(2), y0 - border);
        lower_bound(3) = max(lower_bound(3), z0 - border);
        upper_bound(1) = min(upper_bound(1), x0 + border);
        upper_bound(2) = min(upper_bound(2), y0 + border);
        upper_bound(3) = min(upper_bound(3), z0 + border);
        
        %optimization
        [param, result, exitflag] = fmincon(@intersection_area, [x0,y0,z0,theta0,phi0,psi0], ... 
            [], [], [], [], lower_bound, upper_bound, [],optimset( ... 
            'display', 'off', 'algorithm', 'sqp','DiffMinChange', 1e-2, 'DiffMaxChange', 1, ...
            'TolFun', 1e-2,'TolX', 1e-2));
        
        
        fprintf(fid, 'x = %d y = %d z = %d theta = %d phi = %d psi = %d\n', ...
            param(1), param(2), param(3), param(4), param(5), param(6));
        fprintf(fid, 'result = %d exitflag = %d\n', result, exitflag);
        fprintf('result = %d exitflag = %d\n', result, exitflag);
        max_edge = ORIGINAL_EDGE_OF_TANK;
        
%ensure the center of ellipsoids locate in packing area
        if param(1) > max_edge
            param(1) = param(1) - max_edge * 2;
        elseif param(1) < -max_edge
            param(1) = param(1) + max_edge * 2;
        end
        
        if param(2) > max_edge
            param(2) = param(2) - max_edge * 2;
        elseif param(2) < -max_edge
            param(2) = param(2) + max_edge * 2;
        end
        
        if param(3) > max_edge
            param(3) = param(3) - max_edge * 2;
        elseif param(3) < -max_edge
            param(3) = param(3) + max_edge * 2;
        end
        
        if param(4) > 2 * pi
            param(4) = param(4) - 2 * pi;
        elseif param(4) < 0
            param(4) = param(4) + 2 * pi;
        end
        
        if param(5) > 2 * pi
            param(5) = param(5) - 2 * pi;
        elseif param(5) < 0
            param(5) = param(5) + 2 * pi;
        end
        
        if param(6) > 2 * pi
            param(6) = param(6) - 2 * pi;
        elseif param(6) < 0
            param(6) = param(6) + 2 * pi;
        end
        
        t2 = clock;
        fprintf('The time of run once fminsearch function:%d\n', etime(t2,t1));
        fprintf(fid, 'i = %d iteration = %d\n',i,iteration);
        fprintf('i = %d iteration = %d\n',i,iteration);
        
        %refresh the ellipsoidal state, including the mirror ellipsoids
        ellipsoids_center(1:3, ellipsoid_in_dealing) = [param(1); param(2); param(3)];
        euler_angle(1:3, ellipsoid_in_dealing) = [param(4); param(5); param(6)];
%         arrEllipsoids(ellipsoid_in_dealing) = create_ellipsoid_normal(param(1), param(2), param(3), ...
%             ellipsoids_axis(1, ellipsoid_in_dealing), ellipsoids_axis(2, ellipsoid_in_dealing), ellipsoids_axis(3, ellipsoid_in_dealing), ...
%             param(4), param(5), param(6));
        numsMirror(ellipsoid_in_dealing) = 0;
        create_mirror(ellipsoid_in_dealing);
        
        % find the non-overlap position, update the data
        if result == 0
            oks=oks+1;
            interMatrix(ellipsoid_in_dealing) = 0;
        else
            not_oks=not_oks+1;
        end
        
        if iteration == max_iteration
            is_ok = 0;
            break;
        end
        
        
        i = i + 1;
        if i > length(number_of_intersection)
            % if fail to eliminate the overlap in this loop, try another
            % loop, until reach the maximum iteration numbers
            iteration = iteration + 1;
            check_all(0);
            number_of_intersection = find(interMatrix == 1);
            number_of_intersection = shuffle_array(number_of_intersection);
            fprintf(fid, 'length of interMatrix = %d\n', length(number_of_intersection));
            fprintf(fid, 'oks=%d and not oks=%d\n',oks,not_oks);
            fprintf(fid, '%d ', number_of_intersection);
            fprintf(fid, '\n');
            oks=0;
            not_oks=0;
            if isempty(number_of_intersection)
                is_ok=1;
                break;
            end
            i = 1;
        end
        
    end
    fprintf(fid, 'loop number %d\n', iteration);
end

