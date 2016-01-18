function [ x_y_w_h ] = get_x_y_w_h( page_elements_masks, page_btn_train_margin_boxes )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

    x_y_w_h = [];
    for i = 1 : length(page_elements_masks)
%         i
        img_size = size(page_elements_masks{i});    
        img_w = img_size(2);
        img_h = img_size(1);
        boxes = page_btn_train_margin_boxes{i};
        for j = 1 : size(boxes,1)
            one = boxes(j,:);
            cx = (one(1) + 0.5 * one(3)) / img_w;
            cy = (one(2) + 0.5 * one(4)) / img_h;
            if cy > 1
                img_w
                img_h
                one
                cx
                cy
                return;
            end
            w = one(3) ./ img_w;
            h = one(4) ./ img_h;
            area = one(3) * one(4);
            rwh = w / h;
            x_y_w_h = [x_y_w_h; cx cy w h area rwh];

        end

    end

end

