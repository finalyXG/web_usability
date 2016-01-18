function [ rs ] = filter_outside_boxes( boxes, msize )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    for i = size(boxes,1): -1 :1 
        tmp = boxes(i,:);
        if sum([tmp(1) tmp(2)] > [0 0]) ~= 2 ||...
                sum([tmp(1) + tmp(3), tmp(2) + tmp(4)] <= [msize(2) msize(1)]) ~= 2
            boxes(i,:) = [];
        end
    end
    rs = boxes;
end

