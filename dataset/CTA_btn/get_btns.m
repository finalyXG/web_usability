function [ rs ] = get_btns( button_label )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    rs = [];
    button_label = {button_label.objectBoundingBoxes};
    for i = 1 : length(button_label)
        tmp = button_label{i};
%         tmp = cell2mat(tmp);
        rs = [rs; tmp]; 
        
    end

end

