function [ rs ] = filter_margin_boxes( margin_boxes, boxes, img )
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here
    img_size = size(img);
    rs = [];
    for i = 1 : size(margin_boxes,1)
        tmp = margin_boxes(i,:);
        if tmp(1) > 0 && tmp(1)+tmp(3) <= img_size(2) && tmp(2) > 0 && tmp(2)+tmp(4) <= img_size(1) ...
                && rectint_check(tmp, boxes) == 0
                rs = [rs; tmp];
        end
    end

end

