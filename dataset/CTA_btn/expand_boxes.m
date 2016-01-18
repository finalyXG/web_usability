function [ frs ] = expand_boxes( margin_boxes, boxes,type,img,j)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%     clc

%     j
    
    
    frs = [];
%     size(margin_boxes,1)
    for i = 1 : size(margin_boxes,1)
%         i = 8
        margin_box = margin_boxes(i,1:4);
%         figure(2),clf,imshow(img),plot_multi_boxes(margin_boxes); return;       
%         input('d');
%         continue;
%         margin_box_vertical_lines = get_vertical_lines(margin_box);
        boxes_vertical_lines = get_vertical_lines(boxes);

        expanded_boxes = margin_box; 
       


        
        
        margin_box_horizontal_lines = get_horizontal_lines(expanded_boxes);
        boxes_horizontal_lines = get_horizontal_lines(boxes);
        
        margin_box_top_horizontal_line_seg = margin_box_horizontal_lines(1,:);
%         margin_box_bottom_horizontal_line_seg = margin_box_horizontal_lines(2,:);
        boxes_top_horizontal_line_segs = get_top_horizontal_lines(margin_box_top_horizontal_line_seg, boxes_horizontal_lines);        
        boxes_top_horizontal_candidate_segs = get_intsx_segs(margin_box_top_horizontal_line_seg, boxes_top_horizontal_line_segs);
        new_proj_pts = get_xproj_pts(margin_box_top_horizontal_line_seg, boxes_top_horizontal_candidate_segs);
        if size(new_proj_pts,1) ~= 0
            expanded_boxes = get_expanded_boxes(expanded_boxes, new_proj_pts, boxes);
        end
        
        
%         show_img_lines(img,[margin_box_top_horizontal_line_seg;boxes_top_horizontal_line_segs]);return;
%         margin_box_bottom_horizontal_line_seg
%         show_img_lines(img,[margin_box_bottom_horizontal_line_seg;boxes_top_horizontal_candidate_segs]);return;        
%         return;
%         return;
%         figure(2),clf,imshow(img),plot_multi_boxes(expanded_boxes);return;
%         return;       
%         figure(2),clf,imshow(img),plot_multi_boxes(margin_box);
%         return;
%         show_img_lines(img,margin_box_vertical_lines);return;        
        nrs = [];
        
        
        
        rs = expanded_boxes;       

        for k = 1 : size(rs,1)
            expanded_box = rs(k,:);
%             figure(2),clf,imshow(img),plot_multi_boxes(expanded_box);return;
            margin_box_horizontal_lines = get_horizontal_lines(expanded_box);
%             show_img_lines(img,[margin_box_horizontal_lines]);
%             figure(2),clf,imshow(img),plot_multi_boxes(expanded_box);return;
            margin_box_bottom_horizontal_line_seg = margin_box_horizontal_lines(2,:);
            boxes_bottom_horizontal_line_segs = get_bottom_horizontal_lines(margin_box_bottom_horizontal_line_seg, boxes_horizontal_lines);
            boxes_bottom_horizontal_candidate_segs = get_intsx_segs(margin_box_bottom_horizontal_line_seg, boxes_bottom_horizontal_line_segs);
%             show_img_lines(img,[margin_box_horizontal_lines]);
            new_proj_pts = get_xproj_pts(margin_box_bottom_horizontal_line_seg, boxes_bottom_horizontal_candidate_segs);
            if size(new_proj_pts,1) ~= 0 
                expanded_boxes = get_expanded_boxes(expanded_box, new_proj_pts, boxes,0,img);
            end        
%             nrs = [expanded_boxes];
            nrs = [nrs; expanded_boxes];
        end
        nrs = unique(nrs,'rows');


%         
%         figure(2),clf,imshow(img),plot_multi_boxes(nrs);
%         return;       
        

        

        type = 1;
        
%         if type == 1
%         end
        rs = nrs;
        nrs = [];
        for k = 1 : size(rs,1)
            expanded_box = rs(k,:);
            margin_box_vertical_lines = get_vertical_lines(expanded_box); 
            
            margin_box_left_vertical_line_seg = margin_box_vertical_lines(1,:); 
            boxes_left_vertical_line_segs = get_left_vertical_lines(margin_box_left_vertical_line_seg, boxes_vertical_lines);
            boxes_left_vertical_candidate_segs = get_intsy_segs(margin_box_left_vertical_line_seg, boxes_left_vertical_line_segs);

            new_proj_pts = get_yproj_pts(margin_box_left_vertical_line_seg, boxes_left_vertical_candidate_segs);
            if size(new_proj_pts,1) ~= 0
                expanded_boxes = get_expanded_boxes(expanded_box, new_proj_pts, boxes);
            end
%             return;
%             figure(2),imshow(img),plot_multi_boxes(expanded_boxes);return;
%             nrs = [expanded_boxes];
            nrs = [nrs; expanded_boxes];
        end
        
        nrs = unique(nrs,'rows');        
        
        
%         for i = 1 : size(nrs,1)
%             figure(2),clf,imshow(img),
%             plot_multi_boxes(nrs(i,:));
%             d = input('dump');
%         end
%         return;
%         figure(2),clf,imshow(img),plot_multi_boxes(expanded_boxes);return;

        
        rs = nrs;
        nrs = [];
        for k = 1 : size(rs,1)            
            expanded_box = rs(k,:);
            margin_box_vertical_lines = get_vertical_lines(expanded_box); 
            
            margin_box_right_vertical_line_seg = margin_box_vertical_lines(2,:);
            boxes_right_vertical_line_segs = get_right_vertical_lines(margin_box_right_vertical_line_seg, boxes_vertical_lines);
            boxes_right_vertical_candidate_segs = get_intsy_segs(margin_box_right_vertical_line_seg, boxes_right_vertical_line_segs);            
            new_proj_pts = get_yproj_pts(margin_box_right_vertical_line_seg, boxes_right_vertical_candidate_segs);
            if size(new_proj_pts,1) ~= 0
                expanded_boxes = get_expanded_boxes(expanded_box, new_proj_pts, boxes);
            end  
%             nrs = [nrs; expanded_boxes];
            nrs = [nrs; expanded_boxes];

        end
        nrs = unique(nrs,'rows');
%         figure(2),imshow(img),plot_multi_boxes(nrs);  return;
%         return;
%         figure(2),imshow(img),plot_multi_boxes(nrs);return;
        
%         figure(2),clf,imshow(img),plot_multi_boxes(expanded_boxes);return;

        
        
%         show_img_lines(img,[margin_box_top_horizontal_line_seg;boxes_top_horizontal_candidate_segs]);return;
%         show_img_lines(img,margin_box_top_horizontal_line_seg);

%         figure(2),imshow(img),plot_multi_boxes(expanded_boxes);
%         return;
        
        
%      rs
%             figure(2),imshow(img),plot_multi_boxes(nrs);return;








%         show_img_lines(img,[margin_box_top_horizontal_line_seg;boxes_top_horizontal_candidate_segs]);return;
%         show_img_lines(img,margin_box_top_horizontal_line_seg);
%         figure(2),imshow(img),plot_multi_boxes(expanded_boxes);
%         return;
        
        
        
        frs = [frs; nrs];
%         return;
%         break;
    end
    frs = unique(frs,'rows');
%     figure(2),imshow(img),plot_multi_boxes(frs);
    
end

