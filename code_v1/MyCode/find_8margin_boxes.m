function [ margin_boxes ] = find_8margin_boxes( boxes, filter_boxes, img)
    clc
    margin_boxes = [];
    min_box_size = [80 15]; % 80 2
    for i = 1 : size(boxes,1) 
%         i = 3;
        tmp_box_1 = boxes(i,:);                       
        % left one
        try_box_1 = [tmp_box_1(1) - min_box_size(1), tmp_box_1(2) + round(0.5 * tmp_box_1(4) - 0.5 * min_box_size(2)) , min_box_size];
        
        % top one
        try_box_2 = [tmp_box_1(1), tmp_box_1(2) + tmp_box_1(4), min_box_size];
        
        % right one
        try_box_3 = [tmp_box_1(1) + tmp_box_1(3), tmp_box_1(2) + round(0.5 * tmp_box_1(4) - 0.5 * min_box_size(2)), min_box_size];
        
        % bottom one
        try_box_4 = [tmp_box_1(1), tmp_box_1(2) - min_box_size(2), min_box_size];

        
        
        testing_boxes = [try_box_1;try_box_2;try_box_3;try_box_4;];
        
%         figure(1),hold on,
%         imshow(img); 
%         plot_multi_boxes([testing_boxes;tmp_box_1]);
%         hold off;
%         return;
        
        if tmp_box_1(3) > min_box_size(1) && tmp_box_1(4) > min_box_size(2)
            try_box_5 = [tmp_box_1(1), tmp_box_1(2), min_box_size];
            try_box_6 = [tmp_box_1(1), tmp_box_1(2) + tmp_box_1(4) - min_box_size(2), ...
                min_box_size];
            try_box_7 = [tmp_box_1(1)+tmp_box_1(3)-min_box_size(1), tmp_box_1(2), min_box_size];
            try_box_8 = [tmp_box_1(1)+tmp_box_1(3)-min_box_size(1),tmp_box_1(2) + tmp_box_1(4) - min_box_size(2),...
                min_box_size];
            testing_boxes = [testing_boxes; try_box_5;try_box_6;try_box_7;try_box_8;];
        end
        
        
%         figure(1),hold on,
%         imshow(img); 
%         plot_multi_boxes([testing_boxes;tmp_box_1]);
%         hold off;
%         return;
        
        try_box_candidates = filter_margin_boxes(testing_boxes, filter_boxes, img);
        margin_boxes = [margin_boxes; try_box_candidates];
    end
        

end