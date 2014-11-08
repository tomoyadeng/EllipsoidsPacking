function  save_state_to_file(t_no)
%save the state of overlap elimination, for next usage

    global initial_rate;
    global MAX_LENGTH_OF_AXIS;
    global NUMBER_OF_ELLIPSOIDS;
    global ORIGINAL_EDGE_OF_TANK;
    global numsMirror;  
    global border_width;
    global tolerate_rate;
    global ellipsoids_center;
    global ellipsoids_axis;
    global euler_angle;
    
    fd = fopen(['state_file_', num2str(t_no),'.txt'], 'w');
    if(fd == -1)
        fprintf('fail to create the file\n');
        return;
    end
    
    tmp_rate = [initial_rate, tolerate_rate];
    fwrite(fd, tmp_rate, 'double');

    tmp_int = [border_width, MAX_LENGTH_OF_AXIS, ORIGINAL_EDGE_OF_TANK];
    fwrite(fd, tmp_int, 'double');
    
    fwrite(fd, NUMBER_OF_ELLIPSOIDS, 'int32');
    
    fwrite(fd, numsMirror, 'int32');
    
    for i = 1:NUMBER_OF_ELLIPSOIDS * 8
        for j = 1:3
            t1 = ellipsoids_center(j, i);
            t2 = ellipsoids_axis(j, i);
            t3 = euler_angle(j, i);
            fwrite(fd, t1, 'double');
            fwrite(fd, t2, 'double'); 
            fwrite(fd, t3, 'double');
        end
    end
    fclose(fd);
end

