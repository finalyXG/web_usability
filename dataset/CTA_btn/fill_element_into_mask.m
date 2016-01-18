function [ mask ] = fill_element_into_mask( elements, mask )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    clc
    for k = 1 : length(elements)
        element = elements(k);
        tmp = element.location;
        if size(tmp,1) == 0
            continue;
        end
        for i = 1 : length(tmp(:,1))
            mask(tmp(i,2) : tmp(i,2) + tmp(i,4) ,tmp(i,1) : tmp(i,1) + tmp(i,3)) = 1;
        end
    end
    
end

