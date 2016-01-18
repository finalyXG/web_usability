function [ margin_boxes ] = find_4margin_boxes( boxes,filter_boxes, img)
    clc
    margin_boxes = [];
    min_box_size = [50 15]; %[50 2]
    for i = 1 : size(boxes,1)
            
        tmp_box_1 = boxes(i,:);                       
        % left one
        try_box_1 = [tmp_box_1(1) - min_box_size(1), tmp_box_1(2) + round(0.5 * tmp_box_1(4) - 0.5 * min_box_size(2)) , min_box_size];
        
        % top one
        try_box_2 = [tmp_box_1(1), tmp_box_1(2) + tmp_box_1(4), min_box_size];
        
        % right one
        try_box_3 = [tmp_box_1(1) + tmp_box_1(3), tmp_box_1(2) + round(0.5 * tmp_box_1(4) - 0.5 * min_box_size(2)), min_box_size];
        
        % bottom one
        try_box_4 = [tmp_box_1(1), tmp_box_1(2) - min_box_size(2), min_box_size];
        
        try_box_candidates = filter_margin_boxes([try_box_1;try_box_2;try_box_3;try_box_4;], filter_boxes, img);
        margin_boxes = [margin_boxes; try_box_candidates];
%         margin_boxes = [margin_boxes; try_box_1;try_box_2;try_box_3;try_box_4;];

    end
        

end





%%
% find_margin_boxes([1,1,2,1; 4,3,1,1])
