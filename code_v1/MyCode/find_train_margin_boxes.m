function rs = find_train_margin_boxes(margin_boxes, btn_boxes,img)
    rs = [];
    for i = 1 : size(margin_boxes, 1)
        tmp_box = margin_boxes(i,:);
%         tmp_box_area = tmp_box(3) * tmp_box(4);
        for j = 1 : size(btn_boxes, 1)
            tmp_area = rectint(tmp_box, btn_boxes(j,:));
            if tmp_area > 0 && tmp_area / (btn_boxes(j,3) * btn_boxes(j,4)) >= 0.9999 &&...
                   tmp_box(1) - 0 < btn_boxes(j,1) && btn_boxes(j,1) + btn_boxes(j,3) < tmp_box(1) + tmp_box(3) + 0 &&...
                   tmp_box(2) - 0 < btn_boxes(j,2) && btn_boxes(j,2) + btn_boxes(j,4) < tmp_box(2) + tmp_box(4) + 0
%             if tmp_area == btn_boxes(j,3) * btn_boxes(j,4)
                rs = [rs; margin_boxes(i,:)];
%                 figure(3),imshow(img);
%                 rectangle('Position',tmp_box,'EdgeColor','g');
%                 rectangle('Position',btn_boxes(j,:),'EdgeColor','g');
%                 return;
                break;
            end
        end
    end
    
end