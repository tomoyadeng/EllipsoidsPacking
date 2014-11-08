function  restore_state_from_file(t_no)
%从文件中恢复状态
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
    
    fd = fopen(['state_file_', num2str(t_no)], 'r');
    if(fd == -1)
        fprintf('fail to open file!\n');
        return;
    end
    
    initial_rate            = fread(fd, 1, 'double');
    tolerate_rate           = fread(fd, 1, 'double');
    border_width            = fread(fd, 1, 'double');
    MAX_LENGTH_OF_AXIS      = fread(fd, 1, 'double');
    ORIGINAL_EDGE_OF_TANK   = fread(fd, 1, 'double');
    NUMBER_OF_ELLIPSOIDS    = fread(fd, 1, 'int32');
    numsMirror              = fread(fd, NUMBER_OF_ELLIPSOIDS, 'int32');
    
    for i = 1:NUMBER_OF_ELLIPSOIDS * 8
        for j = 1:3
             t1 = fread(fd, 1, 'double');
             t2 = fread(fd, 1, 'double'); 
             t3 = fread(fd, 1, 'double');
            ellipsoids_center(j, i) = t1;
            ellipsoids_axis(j, i) = t2;
            euler_angle(j, i) = t3;
        end
    end    
    
    fclose(fd);
end

