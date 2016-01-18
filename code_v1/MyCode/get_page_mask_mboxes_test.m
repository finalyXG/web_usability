function [ page_elements_masks,page_btn_test_margin_boxes,page_elements_test,page_elements_type_test,...
    page_imgs_test,D ] = get_page_mask_mboxes_test(D,HOMEIMAGES,file_ind )


    min_w_h = [100 20];
    file_len = length(D);

    acc_btn_boxes = [];
    page_elements_masks = []; 
    page_btn_test_margin_boxes = [];
    page_elements_test = [];
    page_elements_type_test = [];
    page_imgs_test = [];
    
    file_ind = 1;
    for i = file_ind : file_len
        
        i

        %img = imread(file_name);
        [a,img] = LMread(D,i,HOMEIMAGES);
        
        if ~isfield(a,'object')
            page_btn_test_margin_boxes{i} = [];
            continue;
        end               

        page_imgs_test{i} = img;
        
        
        Dtest = LMquery(D(i), 'object.name', 'border,button,bgi,input,img,text,icon');
        tmpD = LMquery(D(i), 'object.attributes', 'learn_btn');        
        xid = {tmpD.annotation.object.id};
        xid = cell2mat(xid);
        for j = length(Dtest.annotation.object) : -1 : 1
            if ismember(Dtest.annotation.object(j).id, xid)
                Dtest.annotation.object(j) = [];
            end
        end
        D(i).annotation.object = Dtest.annotation.object;
        Delement = Dtest;

        [x,y] = LMobjectboundingbox(Delement.annotation);
        rx = [x(:,1) x(:,2) [x(:,3) - x(:,1)+1] [x(:,4) - x(:,2)+1] ];
        page_elements_test{i} = rx;
        boxes = page_elements_test{i};        
        
        tmp = {Dtest.annotation.object.name};
        tmp_rs = []; typestr2num ;
        page_elements_type_test{i} = tmp_rs;        

                
        tmpD = LMquery(Dtest,'object.name','-border');
        [x,y] = LMobjectboundingbox(tmpD.annotation);
        rx = [x(:,1) x(:,2) [x(:,3) - x(:,1)+1] [x(:,4) - x(:,2)+1] ];
        %collect boxes'points
               
        boxes_no_border = rx;              
        margin4_boxes = find_4margin_boxes(boxes_no_border, boxes, img);

%         figure(1),hold on,
%         imshow(img); 
%         plot_multi_boxes([margin4_boxes;]);
%         plot_multi_boxes([boxes]);        
%         hold off;
%         return;
        
        s = 'border';
        tmpD = LMquery(Dtest, 'object.name', s, 'word');
        [x,y] = LMobjectboundingbox(tmpD.annotation);
        rx = [x(:,1) x(:,2) [x(:,3) - x(:,1)+1] [x(:,4) - x(:,2)+1] ];        
        
        border_boxes_mat = [];
        border_boxes_mat = rx; 
        margin8_boxes = find_8margin_boxes(border_boxes_mat,boxes,img);

        
        margin_boxes1 = expand_boxes(margin4_boxes, boxes,0,img,j); 
        margin_boxes2 = expand_boxes(margin8_boxes, boxes,1,img,j);
        margin_boxes = [margin_boxes1; margin_boxes2];
%         return;

%         figure(1),hold on,
%         imshow(img);
%         plot_multi_boxes([margin4_boxes;margin8_boxes]);
%         plot_multi_boxes([margin_boxes]);
%         hold off;
%         return; 


        margin_boxes_train = unique(margin_boxes,'rows');   
%         figure(1),hold on,
%         imshow(img); 
%         plot_multi_boxes([margin_boxes1]);
%         hold off;
%         return; 
        page_boxes_train = [margin_boxes_train];
        page_boxes_train = filter_small_box(page_boxes_train, min_w_h);
        page_btn_test_margin_boxes{i} = page_boxes_train;
        
        
%         four_edges_analysis_test = get_four_edges_analysis(page_btn_test_margin_boxes, page_elements_masks);
%         break;
    end
end

