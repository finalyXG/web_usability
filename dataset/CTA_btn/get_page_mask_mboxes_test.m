function [ page_elements_masks,page_btn_test_margin_boxes,page_elements_test,page_elements_type_test, four_edges_analysis_test,...
    page_imgs_test ] = get_page_mask_mboxes_test(text_label_file_names,...
    button_label,img_label,input_label,text_label,bgi_label,border_label,file_ind )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    min_w_h = [100 5];
    file_len = length(text_label);
    file_names = text_label_file_names;
    acc_btn_boxes = [];
    page_elements_masks = []; 
    page_btn_test_margin_boxes = [];
    page_elements_test = [];
    page_elements_type_test = [];
    page_imgs_test = [];
    
%     file_ind = ;
    for i = file_ind : file_len
        
        i
        file_name = cell2mat(file_names(i));
        img = imread(file_name);
        page_imgs_test{i} = img;
        
        black_mask = zeros(size(img));
        black_mask = im2bw(black_mask);

        [button_boxes pboxes1 type1] = getBoxesByFile(button_label, file_name, 6);
        [img_boxes pboxes2 type2] = getBoxesByFile(img_label, file_name, 1);
        [input_boxes pboxes3 type3] = getBoxesByFile(input_label, file_name, 2);
        [text_boxes pboxes4 type4]= getBoxesByFile(text_label, file_name, 3);
        [bgi_boxes pboxes5 type5]= getBoxesByFile(bgi_label, file_name, 4);
        [border_boxes pboxes6 type6]= getBoxesByFile(border_label, file_name, 5);

        page_elements_test{i} = [pboxes1; pboxes2; pboxes3; pboxes4; pboxes5; pboxes6];
        page_elements_type_test{i} = [type1;type2;type3;type4;type5;type6];
        
        acc_btn_boxes = [acc_btn_boxes; button_boxes.location];
        page_elements_masks{i} = get_elements_mask([...
            img_boxes;...
            input_boxes;...
            text_boxes;...
            bgi_boxes;...
            border_boxes], img);

    %     figure(1), 
    %     axis('ij');
    %     imshow(page_elements_masks);    
    %     imcontour(page_elements_masks)
    %     return;

        page_boxes_train = [];
        %collect boxes'points
        
        
        boxes = [];
        boxes = boxes_add(button_boxes, boxes);
        boxes = boxes_add(bgi_boxes, boxes);
        boxes = boxes_add(img_boxes, boxes);
        boxes = boxes_add(input_boxes, boxes);
        boxes = boxes_add(text_boxes, boxes);
        boxes_no_border = boxes;
        boxes = boxes_add(border_boxes, boxes); 

%         figure(1),hold on,
%         imshow(img); 
%         plot_multi_boxes([boxes]);
%         hold off;
%         return; 

        margin4_boxes = find_4margin_boxes(boxes_no_border, boxes, img);
%         figure(1),hold on,
%         imshow(img); 
%         plot_multi_boxes([margin4_boxes;]);
%         plot_multi_boxes([boxes]);
%         
%         hold off;
%         return; 

        border_boxes_mat = [];
        border_boxes_mat = boxes_add(border_boxes, border_boxes_mat); 
        margin8_boxes = find_8margin_boxes(border_boxes_mat,boxes,img);

        
        margin_boxes1 = expand_boxes(margin4_boxes, boxes,0,img,j); 
        margin_boxes2 = expand_boxes(margin8_boxes, boxes,1,img,j);
        margin_boxes = [margin_boxes1; margin_boxes2];
%         return;

%         figure(1),hold on,
%         imshow(img); 
% %         plot_multi_boxes([margin4_boxes;margin8_boxes]);
%         plot_multi_boxes([margin_boxes]);
%         hold off;
%         return; 


        margin_boxes_train = unique(margin_boxes,'rows');   
%         figure(1),hold on,
%         imshow(img); 
%         plot_multi_boxes([margin_boxes1]);
%         hold off;
%         return; 
        page_boxes_train = [page_boxes_train; margin_boxes_train];
        page_boxes_train = filter_small_box(page_boxes_train, min_w_h);
%         page_boxes_train = filter_overlap_mboxes(page_boxes_train);

        page_btn_test_margin_boxes{i} = page_boxes_train;
        
        
%         four_edges_analysis_test = get_four_edges_analysis(page_btn_test_margin_boxes, page_elements_masks);
        four_edges_analysis_test = [];
%         break;
    end
end

