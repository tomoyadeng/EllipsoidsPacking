function plot_all(plot_mirror)
% Graph function
% when plot_mirror equals 1, draw mirror in another color
    global arrEllipsoids;
    global NUMBER_OF_ELLIPSOIDS;
    global numsMirror;
    %global mirror_ellipsoid;
    
    %refresh ellipsoidal objects
    make_elltool_objects();
    
    graphic_hold = 0;
    figure
    for i = 1:NUMBER_OF_ELLIPSOIDS;
        plot(arrEllipsoids(i));
        if(graphic_hold == 0)
            graphic_hold = 1;
            hold;
        end
        if(plot_mirror == 1)
            nums = numsMirror(i);
            for j = 1:nums
                t_no = j * NUMBER_OF_ELLIPSOIDS + i;
                plot(arrEllipsoids(t_no), 'b');
                hold all;
            end

            if(graphic_hold == 0)
                graphic_hold = 1;
                hold;
            end
        end
    end

end

