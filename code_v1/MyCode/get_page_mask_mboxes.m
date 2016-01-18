function [page_btn_train_margin_boxes,...
    page_BTNs,page_elements_train,page_elements_type_train,page_imgs,acc_btn_train_margin_boxes,Delement ] =...
    get_page_mask_mboxes(D,HOMEIMAGES,file_ind)



    file_len = length(D);
    
    acc_btn_boxes = [];
    page_elements_train = [];
    page_elements_type_train = [];
    page_BTNs = [];
    page_imgs = [];
    page_btn_train_margin_boxes = [];
    acc_btn_train_margin_boxes = [];
%     file_len = 20;

    for i = 1 : file_len
        i
        %img = imread(file_name);
        [a,img] = LMread(D,i,HOMEIMAGES);
        
        if ~isfield(a,'object')
            page_btn_train_margin_boxes{i} = [];
            continue;
        end   
        
        page_imgs{i} = img;

        Dtrain = LMquery(D(i),'object.attributes','train');          
        Delement = LMquery(Dtrain,'object.name','-button');   

        Delement_btn_existed = LMquery(Dtrain, 'object.attributes','existed');
        if ~isempty(Delement_btn_existed)
            Delement.annotation.object = [Delement.annotation.object Delement_btn_existed.annotation.object];
        end
        
        [x,y] = LMobjectboundingbox(Delement.annotation);
        rx = [x(:,1) x(:,2) [x(:,3) - x(:,1)+1] [x(:,4) - x(:,2)+1] ];
        page_elements_train{i} = rx;

        tmp = {Dtrain.annotation.object.name};
        tmp_rs = []; typestr2num ;
        page_elements_type_train{i} = tmp_rs;
        
        Dbutton = LMquery(Dtrain, 'object.name', 'button');        
        Dbutton = LMquery(Dbutton, 'object.attributes','learn_btn');
        [x,y] = LMobjectboundingbox(Dbutton.annotation);
        rx = [x(:,1) x(:,2) [x(:,3) - x(:,1)] [x(:,4) - x(:,2)] ];
        page_BTNs{i} = rx;
        acc_btn_boxes = [acc_btn_boxes; rx]; 

        
%         s = 'button,bgi,text,img,icon,input';
%         tmpD = LMquery(Delement, 'object.name', s, 'word');
        [x,y] = LMobjectboundingbox(Delement.annotation);
        rx = [x(:,1) x(:,2) [x(:,3) - x(:,1) + 1] [x(:,4) - x(:,2) + 1] ];
        
        %collect boxes'points   
%         boxes_no_border = rx; 
        boxes = page_elements_train{i};        
        margin4_boxes = find_4margin_boxes(rx, boxes, img);
        

%         figure(1),hold on,
%         imshow(img); 
%         plot_multi_boxes([margin4_boxes;]);
%         hold off;
%         return;
        
        s = 'border';
        tmpD = LMquery(Delement, 'object.name', s, 'word');
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
                
        
        margin_boxes_train = find_train_margin_boxes(margin_boxes_train, page_BTNs{i},img);
        margin_boxes_train = filter_overlap_mboxes(margin_boxes_train);

%         figure(1),hold on,
%         imshow(img); 
%         plot_multi_boxes([margin_boxes_train]);
%         hold off;
%         return;    
        
            
        page_btn_train_margin_boxes{i} = margin_boxes_train;
        acc_btn_train_margin_boxes = [acc_btn_train_margin_boxes; margin_boxes_train];
        

%         return;
    end


end