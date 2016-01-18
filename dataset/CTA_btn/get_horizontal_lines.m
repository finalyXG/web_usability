function [ rs ] = get_horizontal_lines( boxes )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    rs = [];
    for i = 1 : size(boxes,1)
        tmp = boxes(i,:);
        tmp1 = [tmp(1) tmp(2) tmp(1)+tmp(3) tmp(2)];
        tmp2 = [tmp(1) tmp(2)+tmp(4) tmp(1)+tmp(3) tmp(2)+tmp(4)];
        rs = [rs; tmp1; tmp2];
    end

end

