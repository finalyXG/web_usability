function [ rs ] = get_page_btns( button_label )
%UNTITLED3 Summary of this function goes here    
%   Detailed explanation goes here
    rs = {button_label.objectBoundingBoxes};
%     for i = 1 : length(button_label)
%         i
%         tmp = button_label{i};
%         tmp = tmp.objectBoundingBoxes
%         return;
%     end

end

