function [ rs ] = expand_marginbox( margin_box, boxes)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    margin_box_horizontal_line_segments = get_horizontal_lines(margin_box);
    boxes_horizontal_line_segments = get_horizontal_lines(boxes);
    margin_box_vertical_line_segments = get_vertical_lines(margin_box);
    
    box_horizontal_expandable(margin_box, boxes);

end

