function [ margin_boxes ] = find_margin_boxes( boxes)
    clc
    margin_boxes = [];
    for i = 1 : size(boxes,1) - 1
        for j = i + 1 : size(boxes,1)
            
            tmp_box_1 = boxes(i,:);
            tmp_box_2 = boxes(j,:);
            tmp1 = [tmp_box_1(1), tmp_box_1(2)];
            tmp2 = [tmp_box_1(1), tmp_box_1(2) + tmp_box_1(4)];
            tmp3 = [tmp_box_1(1) + tmp_box_1(3), tmp_box_1(2) + tmp_box_1(4)];
            tmp4 = [tmp_box_1(1) + tmp_box_1(3), tmp_box_1(2)];                        
            tmp_point_1 = [tmp1; tmp2; tmp3; tmp4; ];
            
            tmp1 = [tmp_box_2(1), tmp_box_2(2)];
            tmp2 = [tmp_box_2(1), tmp_box_2(2) + tmp_box_2(4)];
            tmp3 = [tmp_box_2(1) + tmp_box_2(3), tmp_box_2(2) + tmp_box_2(4)];            
            tmp4 = [tmp_box_2(1) + tmp_box_2(3), tmp_box_2(2)];
            tmp_point_2 = [tmp1; tmp2; tmp3; tmp4; ];
            
            xv1 = tmp_point_1(:,1);
            yv1 = tmp_point_1(:,2);
            
            xv2 = tmp_point_2(:,1);
            yv2 = tmp_point_2(:,2);
            
            combos_1 = combntns(1:4,2);
            combos_1 = [combos_1; [1,1]; [2,2]; [3,3]; [4,4]];
            combos_2 = combntns(1:4,2);
            combos_2 = [combos_2; [1,1]; [2,2]; [3,3]; [4,4]];
            
            for i1 = 1 : size(combos_1,1)
                try_point_1 = tmp_point_1(combos_1(i1,1),:);
                try_point_2 = tmp_point_1(combos_1(i1,2),:);
                diff_x_1 = try_point_1(1) - try_point_2(1);
                diff_y_1 = try_point_1(2) - try_point_2(2);
                if diff_x_1 ~= 0 && diff_y_1 ~= 0 
                    continue;
                end
                for j1 = 1 : size(combos_2,1)
                    try_point_3 = tmp_point_2(combos_2(j1,1),:);
                    try_point_4 = tmp_point_2(combos_2(j1,2),:);
                    diff_x_2 = try_point_3(1) - try_point_3(1);
                    diff_y_2 = try_point_3(2) - try_point_3(2);                    
                    if diff_x_2 ~= 0 && diff_y_2 ~= 0
                        continue;
                    end                    
                    try_points = [try_point_1; try_point_2;...
                        try_point_3;try_point_4];

                    bbox = boundingBox(try_points);
                    bbox_std = [bbox(1), bbox(3), bbox(2)-bbox(1), bbox(4)-bbox(3)];
%                     bbox_p1 = [bbox(1) bbox(3)];
%                     bbox_p2 = [bbox(1) bbox(4)];
%                     bbox_p3 = [bbox(2) bbox(4)];
%                     bbox_p4 = [bbox(2) bbox(3)];
%                     bbox_corners = [bbox_p1; bbox_p2; bbox_p3; bbox_p4; ];
% 
%                     xq = bbox_corners(:,1);
%                     yq = bbox_corners(:,2);
                    
%                     [in1,on1] = inpolygon(xq,yq,xv1,yv1);
%                     [in2,on2] = inpolygon(xv1,yv1,xq,yq);
% 
%                     [in3,on3] = inpolygon(xq,yq,xv2,yv2);
%                     [in4,on4] = inpolygon(xv2,yv2,xq,yq);
%                   
                    if rectint_check(bbox_std, boxes) == 0
                        margin_boxes = [margin_boxes; bbox_std];
                    end
                    
%                     if numel(xq(in1)) == numel(xq(on1)) && ...
%                             numel(xq(in2)) == numel(xq(on2)) && ...
%                                 numel(xq(in3)) == numel(xq(on3)) && ...
%                                     numel(xq(in4)) == numel(xq(on4)) 
%                         
%                         margin_boxes = [margin_boxes; {bbox_corners}];
%                     end
                    
                end
            end
            
        end
    end

end





%%
% find_margin_boxes([1,1,2,1; 4,3,1,1])
