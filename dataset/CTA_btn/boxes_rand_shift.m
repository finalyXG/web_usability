function [ rs ] = boxes_rand_shift( boxes )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    rs = [];
    for i = 1 : size(boxes,1)
        boxes(i,:) = boxes(i,:) +  randi([-10 10],1,4);
    end
        

end

