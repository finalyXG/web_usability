function [ rs ] = get_top_horizontal_lines( margin_box_line, boxes_lines )
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here
    rs = [];
    margin_box_line_y = margin_box_line(2);
    for i = 1 : size(boxes_lines,1)
        tmp_y = boxes_lines(i,2);
        if tmp_y > margin_box_line_y
            continue;
        end
        rs = [rs; boxes_lines(i,:)];
    end

end

