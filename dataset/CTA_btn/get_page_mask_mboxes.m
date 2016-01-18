function [ page_elements_masks,page_btn_train_margin_boxes,page_BTNs,page_btns, page_elements_train,page_elements_type_train ] = get_page_mask_mboxes(text_label_file_names,...
    button_label,BTN_label, img_label,input_label,text_label,bgi_label,border_label )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    file_len = length(text_label);
    file_names = text_label_file_names;
    acc_btn_boxes = [];
    page_elements_train = [];
    page_elements_type_train = [];
    page_BTNs = [];
    page_btns = [];
   
%     file_len = 20;
    for i = 1 : file_len
        file_name = cell2mat(file_names(i));
        img = imread(file_name);

        black_mask = zeros(size(img));
        black_mask = im2bw(black_mask);

        [BTN_boxes pboxes0, type0] = getBoxesByFile(BTN_label, file_name, 6);
        [button_boxes pboxes1, type1] = getBoxesByFile(button_label, file_name, 6);
        [img_boxes pboxes2,type2]= getBoxesByFile(img_label, file_name, 1);
        [input_boxes pboxes3,type3] = getBoxesByFile(input_label, file_name, 2);
        [text_boxes pboxes4,type4]= getBoxesByFile(text_label, file_name, 3);
        [bgi_boxes pboxes5,type5]= getBoxesByFile(bgi_label, file_name, 4);
        [border_boxes pboxes6,type6]= getBoxesByFile(border_label, file_name, 5);
     
        page_elements_train{i} = [pboxes1; pboxes2; pboxes3; pboxes4; pboxes5; pboxes6];
        page_elements_type_train{i} = [type1;type2;type3;type4;type5;type6];
        page_BTNs{i} = [BTN_boxes.location];
        page_btns{i} = [button_boxes.location];
        
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
%             button_boxes_expt_indj = get_btn_except_indj(button_boxes, j);
%             boxes = boxes_add(button_boxes_expt_indj, boxes);
            boxes = boxes_add(bgi_boxes, boxes);
            boxes = boxes_add(img_boxes, boxes);
            boxes = boxes_add(input_boxes, boxes);
            boxes = boxes_add(text_boxes, boxes);
            boxes_no_border = boxes;
            boxes = boxes_add(border_boxes, boxes); 

%             figure(1),hold on,
%             imshow(img); 
%             plot_multi_boxes([boxes]);
%             hold off;
%             return; 

            btn_boxes = [];
            btn_boxes = boxes_add(button_boxes, btn_boxes);
            margin4_boxes = find_4margin_boxes(boxes_no_border, boxes, img);
%             return;
%             margin4_boxes
% 

%             figure(1),hold on,
%             imshow(img);    
% %             tmp = expand_boxes(margin4_boxes(1,:), boxes,0,img,j);
% %             tmp = filter_overlap_mboxes(tmp);
%             plot_multi_boxes(margin4_boxes);
%             hold off;
%             return; 

            border_boxes_mat = [];
            border_boxes_mat = boxes_add(border_boxes, border_boxes_mat); 
            margin8_boxes = find_8margin_boxes(border_boxes_mat,boxes,img);

%             figure(1),hold on,
%             imshow(img);    
%             plot_multi_boxes(margin8_boxes);
%             hold off;
%             return;             
            
            
    %         return;
            margin_boxes1 = expand_boxes(margin4_boxes, boxes,0,img,j);
            margin_boxes2 = expand_boxes(margin8_boxes, boxes,1,img,j);
            
%             plot_multi_boxes([expand_boxes(margin4_boxes(10,:), boxes,0,img,j)]);return;
% 
%             figure(1),hold on,
%             imshow(img); 
% %             plot_multi_boxes([margin4_boxes;margin8_boxes;]);
%             hold off;
%             return; 
            
            margin_boxes = [margin_boxes1; margin_boxes2];

%             figure(1),hold on,
%             imshow(img); 
%             plot_multi_boxes([margin_boxes]);
%             hold off;
%             return; 

            margin_boxes_train = unique(margin_boxes,'rows');
            margin_boxes_train = find_train_margin_boxes(margin_boxes_train, btn_boxes,img);
            margin_boxes_train = filter_overlap_mboxes(margin_boxes_train);
            
%             figure(1),hold on,
%             imshow(img); 
%             plot_multi_boxes([margin_boxes_train]);
%             hold off;
%             return; 
            
            page_boxes_train = [page_boxes_train; margin_boxes_train];
            
        
       
       
        
        if i == 32
            page_boxes_train([2,4,5],:) = [];
        end         
        
        page_btn_train_margin_boxes{i} = page_boxes_train;
        
        page_boxes_train = filter_overlap_mboxes(page_boxes_train); 
        page_btn_train_margin_boxes{i} = page_boxes_train;      
        
        
% % %         
%         i
%         for k = 1 : size(page_boxes_train,1)
%             k
%             figure(1),clf,hold on,
%             imshow(img); 
%             plot_multi_boxes(page_boxes_train(k,:));
%             hold off;            
%             d = input('dump');
%         end
        
        
%         return;
        
    end


end