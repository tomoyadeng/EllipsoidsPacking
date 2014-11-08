function arr = shuffle_array(arr)
%shuffle the array number

    len = length(arr);
    for i = 1:len
        idx = floor(rand() * (len - i + 1));
        tmp = arr(idx + i);
        arr(idx + i) = arr(i);
        arr(i) = tmp;
    end
end

