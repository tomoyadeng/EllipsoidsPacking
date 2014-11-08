function [array_result_in, array_result_out] = point_in_ellipsoid(array_x, array_y, array_z, mat)
%check if the point in the ellipsoid

    a = mat(1,1);
    b = mat(2,2);
    c = mat(3,3);
    d = mat(1,2);
    e = mat(1,3);
    f = mat(2,3);
    
    result = a * (array_x .^ 2) + b * (array_y .^ 2) + c * (array_z .^ 2) ...
        + 2 * d * array_x .* array_y + 2 * e * array_x .* array_z + 2 * f * array_y .* array_z;
    array_result_in = find(result <= 1);
    array_result_out = find(result > 1);
    
end

