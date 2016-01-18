function [ rs ] = get_right_vertical_lines( margin_box_line, boxes_lines )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
    rs = [];
    margin_box_line_x = margin_box_line(1);
    for i = 1 : size(boxes_lines,1)
        tmp_x = boxes_lines(i,1);
        if tmp_x < margin_box_line_x
            continue;
        end
        rs = [rs; boxes_lines(i,:)];
    end

end

