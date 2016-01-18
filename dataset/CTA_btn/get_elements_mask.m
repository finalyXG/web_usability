function [ rs ] = get_elements_mask( elements, img )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    tmp = size(img);
    mask = zeros(tmp(1:2));
    for i = 1 : size(elements,1)
        element = elements(i,:);
        if isequal(element.type,1)
            dot = 1;
        end
        
        if isequal(element.type,2)
            dot = 2;
        end
        
        if isequal(element.type,3)
            dot = 3;
        end
        
        if isequal(element.type,4)
            dot = 4;
        end
        
        if isequal(element.type,5)
            dot = 5;
        end
        
        if isequal(element.type,6)
            dot = 6;
        end
        
        mask = fill_edge_element_into_mask(element, mask, dot);
                
    end 
    rs = mask; 

end