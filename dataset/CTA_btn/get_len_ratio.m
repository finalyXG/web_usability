function [ rs ] = get_len_ratio( lens )
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here
    s = norm(lens,1);
    nor_data = round(lens / s,2);
    diff = 1 - sum(nor_data);
    nor_data(1) = nor_data(1) + diff;
    tmp = sum(nor_data);
    
    
    if tmp - 1 > 0
%         nor_data = round(nor_data,2);
        if 1 - norm(nor_data,1) > 0
            sum(nor_data)
            nor_data
            d = input('dupm');
        end
    end
    
    rs = nor_data;
end

