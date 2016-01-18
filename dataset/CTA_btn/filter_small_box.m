function [ boxes ] = filter_small_box( boxes,min_w_h )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    for i = size(boxes,1): -1 : 1
        if boxes(i,3) < min_w_h(1) || boxes(i,4) < min_w_h(2)
            boxes(i,:) = [];
        end
    end
    
    
end

