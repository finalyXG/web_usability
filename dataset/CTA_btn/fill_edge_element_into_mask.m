function [ mask ] = fill_edge_element_into_mask( elements, mask, dot )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
 clc    
    border_width = 0;

    for k = 1 : length(elements)
        
        element = elements(k);
        tmp = element.location;
        if size(tmp,1) == 0
            continue;
        end
        
        for i = 1 : length(tmp(:,1))
            mask(tmp(i,2) : tmp(i,2) + border_width, tmp(i,1) : tmp(i,1) + tmp(i,3)) = dot;
            mask(tmp(i,2) + tmp(i,4) : tmp(i,2) + tmp(i,4) + border_width , tmp(i,1) : tmp(i,1) + tmp(i,3) ) = dot;
            mask(tmp(i,2) : tmp(i,2) + tmp(i,4) ,  tmp(i,1) : tmp(i,1) + border_width) = dot;
            mask(tmp(i,2) : tmp(i,2) + tmp(i,4) , tmp(i,1) + tmp(i,3) : tmp(i,1) + tmp(i,3) + border_width) = dot;            
        end
    end

end

