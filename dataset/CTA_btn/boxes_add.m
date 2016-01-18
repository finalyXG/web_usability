function [ all_boxes ] = boxes_add( boxes, all_boxes )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    for i = 1 : size(boxes.location,1)
        tmp_box_location = boxes.location(i,:);
        tmp_type = boxes.type;
        tmp1 = [tmp_box_location(1), tmp_box_location(2)];
        tmp2 = [tmp_box_location(1) + tmp_box_location(3), tmp_box_location(2)];
        tmp3 = [tmp_box_location(1) + tmp_box_location(3), tmp_box_location(2) + tmp_box_location(4)];
        tmp4 = [tmp_box_location(1), tmp_box_location(2) + tmp_box_location(4)];
        all_boxes = [all_boxes; tmp_box_location];
%         corners.type = [corners.type; tmp_type; tmp_type; tmp_type];
    end

end

