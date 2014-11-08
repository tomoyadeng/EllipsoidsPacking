function [iarea] = intersection_area(param)
%
%   caculate the overlap volume of a given ellipsoid and its neighbors
    global ellipsoids_axis;
    global ellipsoids_center;
    global euler_angle;
    global ellipsoid_in_dealing;

	iarea = 0;
    x = param(1);
    y = param(2);
    z = param(3);
%     a = ellipsoids_axis(1, ellipsoid_in_dealing);
%     b = ellipsoids_axis(2, ellipsoid_in_dealing);
%     c = ellipsoids_axis(3, ellipsoid_in_dealing);
    theta = param(4);
    phi = param(5);
    psi = param(6);
    point_number = 1e6;     %total points

    neighbor_count = 0;
    
  %%
    %============= Find Neighbors================
    [all_ellipsoids_idx, idx_number] = get_all_ellipsoids_index();
    distance = ellipsoids_axis(1:3, all_ellipsoids_idx) + ellipsoids_axis(1:3, ellipsoid_in_dealing)*ones(1,idx_number);
    max_length = distance(1,:);
   % max_length = max(ellipsoids_axis(1:3, ellipsoid_in_dealing))*ones(1,idx_number) ...
      %  + max(ellipsoids_axis(1:3, all_ellipsoids_idx));
  %  max_length = ellipsoids_axis(1:3, ellipsoid_in_dealing)*ones(1,idx_number)

    intsec_center = [x; y; z];
    
    adjacent_ellipsoids = zeros(1, idx_number);
    
    for i = 1:idx_number
        idx = all_ellipsoids_idx(i);
        
        if idx == ellipsoid_in_dealing
            continue;
        end
        
        if (norm(intsec_center - ellipsoids_center(1:3, idx)) < max_length(i))
            neighbor_count = neighbor_count + 1;
            adjacent_ellipsoids(neighbor_count) = idx;
        end
    end
    
    if neighbor_count == 0
        return;
    end
    %===================Find Neighbors=============================
    
    
%%
%=============================Analytical Method==========================================================
%     iarea = 0;
%     this_ellipsoid = create_ellipsoid_normal(x, y, z, a, b, c, theta, phi, psi);
%     for i = 1:neighbor_count
%         idx = adjacent_ellipsoids(i);
%         if distance(arrEllipsoids(idx), this_ellipsoid) == 0
%             try 
%                 internal_ellipsoid = intersection_ia(arrEllipsoids(idx), this_ellipsoid);
%                 internal_volume = volume(internal_ellipsoid);
%             catch e
%                 disp(e);
%                 internal_volume = 0;
%             end
%             try
%                 external_ellipsoid = intersection_ea(arrEllipsoids(idx), this_ellipsoid);
%                 external_volume = volume(external_ellipsoid);
%             catch e
%                 disp(e);
%                 external_volume = 0;
%             end
%             fprintf(fid, '最小外切椭球与最大内切椭球相差 %d\n', (external_volume - internal_volume));
%         iarea = iarea + (external_volume + internal_volume) / 2;
%         end
%     end
%===============================Analytical Method======================================================

%%   
%===============================MonteCarlo Method======================================================    
    max_axis = max(ellipsoids_axis(:, ellipsoid_in_dealing));
    
    % border of random points area
    max_len_x = x + max_axis;
    min_len_x = x - max_axis;
    max_len_y = y + max_axis;
    min_len_y = y - max_axis;
    max_len_z = z + max_axis;
    min_len_z = z - max_axis;
    
    %Generate random numbers
    random_x = rand(1, point_number) * (max_len_x - min_len_x) + min_len_x;
    random_y = rand(1, point_number) * (max_len_y - min_len_y) + min_len_y;
    random_z = rand(1, point_number) * (max_len_z - min_len_z) + min_len_z;
    points = [random_x; random_y; random_z];
    
    a = ellipsoids_axis(1, ellipsoid_in_dealing);
    b = ellipsoids_axis(2, ellipsoid_in_dealing);
    c = ellipsoids_axis(3, ellipsoid_in_dealing);
    
    shapeMatrix = get_shapeMat(a, b, c, theta, phi, psi);
    
  % find the points in ellipsoid
   X = points - ellipsoids_center(:,ellipsoid_in_dealing)*ones(1,point_number);
   isEll = zeros(1,point_number);
    for j = 1:point_number
        isEll(j) = X(:,j)' * shapeMatrix * X(:,j);
    end
    ellPoints = find(isEll < 1);
    numsEllPoints = numel(ellPoints);
    
% find points in overlap area
    overlapPoints = zeros(1,numsEllPoints);
    for i = 1:neighbor_count
    a2 = ellipsoids_axis(1, adjacent_ellipsoids(i));
    b2 = ellipsoids_axis(2, adjacent_ellipsoids(i));
    c2 = ellipsoids_axis(3, adjacent_ellipsoids(i));
    theta2 = euler_angle(1,adjacent_ellipsoids(i));
    phi2 = euler_angle(2,adjacent_ellipsoids(i));
    psi2 = euler_angle(3,adjacent_ellipsoids(i));
    
    neighborMatrix = get_shapeMat(a2, b2, c2, theta2, phi2, psi2);
    
    
    isNeighborEll = zeros(1,numsEllPoints);
    for j = 1:numsEllPoints
        isNeighborEll(j) = X(:,ellPoints(j))' * neighborMatrix * X(:,ellPoints(j));
        if isNeighborEll(j) < 1
            overlapPoints(j) = 1;
        end
    end
    
    %intsecPoints = find(isNeighborEll < 1);
    
    end
    overlap = sum(overlapPoints);
    
    iarea = overlap*(max_len_x - min_len_x) * (max_len_y - min_len_y) * (max_len_z - min_len_z) / point_number;
    
%==============================MonteCarlo Method========================     
    % 若点在椭球ellipsoid_in_dealing内部，则是有效的点
    %[inner_point_position] = point_in_ellipsoid(random_x - x, random_y - y, random_z - z, M);
    %inner_point_position = inner_point_position' ;
    %取出有效的点
    %inner_point_x = random_x(inner_point_position);
    %inner_point_y = random_y(inner_point_position);
    %inner_point_z = random_z(inner_point_position);
    
    %effect_point_x = inner_point_x;
    %effect_point_y = inner_point_y;
    %effect_point_z = inner_point_z;

    
    %做法类似上面，piont_neighbor_count记录有效的投点
    %point_neighbor_count = 0;
    %for i = 1:neighbor_count
        %ell_no = adjacent_ellipsoids(i);
        %t_cent = ellipsoids_center(1:3, ell_no);
        %shMat = get_shapeMat(ellipsoids_axis(1, ell_no), ellipsoids_axis(2, ell_no), ellipsoids_axis(3, ell_no), ... 
        %    euler_angle(1, ell_no), euler_angle(2, ell_no), euler_angle(3, ell_no));
        %[ip, op] = point_in_ellipsoid(effect_point_x - t_cent(1), effect_point_y - t_cent(2), effect_point_z - t_cent(3), shMat);
       % ip = ip';
        %op = op';
        
        %记录重叠的点
        %point_neighbor_count = point_neighbor_count + length(ip);
        
        %不重叠的点是下一次循环的点集
        %effect_point_x = effect_point_x(op);
       % effect_point_y = effect_point_y(op);
        %effect_point_z = effect_point_z(op);
   % end
    
    %求重叠面积
   % iarea = (max_len_x - min_len_x) * (max_len_y - min_len_y) * (max_len_z - min_len_z) * (point_neighbor_count / point_number);
%==============================MonteCarlo Method==========================================================================
end

