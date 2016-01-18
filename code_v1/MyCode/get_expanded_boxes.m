function [ rs ] = get_expanded_boxes( margin_box, pts, boxes, type, img )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
    rs = [];
    tmp = [];
        
    for i = 1 : size(pts,1)
        
        box_pts = [margin_box(1), margin_box(2);...
            margin_box(1) + margin_box(3) margin_box(2);...
            margin_box(1) margin_box(2) + margin_box(4);...
            pts(i,:)];
        new_rs = boundingBox(box_pts);
        rs = [rs; new_rs(1) new_rs(3) new_rs(2)-new_rs(1) new_rs(4)-new_rs(3)];
        
    end
    
    if nargin==5 && type == 1
%         figure(2),imshow(img),plot_multi_boxes([margin_box]);
%         figure(2),imshow(img),plot_multi_boxes([margin_box]);
%         return;

        pts
        margin_box
        size(rs)
        rs
        figure(2),imshow(img),plot_multi_boxes([rs(:,:); boxes]);
%         rectint_check(rs(7,:), boxes)
    end
    
    
    for i = size(rs,1):-1:1
        if rectint_check(rs(i,:), boxes) == 1
%             if nargin==5 && type == 1
%                 999
%             end
            rs(i,:) = [];
        end
    end
    
    rs = unique(rs,'rows');





%     if size(rs,1) > 1
% %         a = abs(rs(:,2) - rs(:,4));
% %         b = abs(rs(:,1) - rs(:,3));
%         [ min3, ind3] = min(rs(:,3));
%         [ min4, ind4] = min(rs(:,4));
%         rs = [rs(ind3,1) rs(ind4,2) min3 min4];
%         
%     end
    

    
    if size(rs,1) == 0
        rs = margin_box;
    end
end

