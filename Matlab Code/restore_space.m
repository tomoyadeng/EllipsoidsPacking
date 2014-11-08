function restore_space( rate )
%   �ڿռ�ѹ�����������״��С�������仯��ֻ����������ĵ�����
%   ����ѹ���������ϵ�ı仯���仯����ˣ���Ҫ���µ�������Ļ��֣�
%   ���¼�����������������

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
        %���������λ���Ѿ������˱仯�����µľ�������δ��������˽�����ľ���
        %������Ŀ��0��������0ǰӦ����һ����һ�ε���Ŀ
        numsMirror(i) = 0;
        create_mirror(i);
    end
    
%�������������λ�÷����˱仯��������������µ�ET�е��������
%     make_ET_objects();

end

