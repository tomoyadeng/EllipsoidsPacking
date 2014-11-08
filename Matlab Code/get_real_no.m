function r_no = get_real_no(t_no)
% return to the number of real ellipsoid

    global NUMBER_OF_ELLIPSOIDS;
    
    r_no = t_no;
    while r_no > NUMBER_OF_ELLIPSOIDS
        r_no = r_no - NUMBER_OF_ELLIPSOIDS;
    end
end