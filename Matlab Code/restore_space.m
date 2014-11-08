function restore_space( rate )
%   在空间压缩后，椭球的形状大小不发生变化，只是椭球的中心点坐标
%   随着压缩后的坐标系的变化而变化，因此，需要重新调整区域的划分，
%   重新计算椭球所属的区域。

    global NUMBER_OF_ELLIPSOIDS;
    global ORIGINAL_EDGE_OF_TANK;       
    global numsMirror;
    global t_rate;
    global ellipsoids_center;
	
    t_rate = rate;
    rate = (1 - rate) ^ (1/3);
    ORIGINAL_EDGE_OF_TANK = ORIGINAL_EDGE_OF_TANK / rate;
    
    
    for i = 1:NUMBER_OF_ELLIPSOIDS
        t_cent = ellipsoids_center(1:3, i);
        t_cent = t_cent ./ rate;
        ellipsoids_center(1:3, i) = t_cent;
        %由于椭球的位置已经发生了变化，而新的镜子椭球还未产生，因此将椭球的镜子
        %椭球数目置0，但是置0前应保存一下上一次的数目
        numsMirror(i) = 0;
        create_mirror(i);
    end
    
%由于椭球的中心位置发生了变化，因此重新生成新的ET中的椭球对象
%     make_ET_objects();

end

