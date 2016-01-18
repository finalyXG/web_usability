page_nb_elements = {};
page_nb_elements_type = {};
acc_nb_elements = [];
acc_nb_elements_type = [];
for i = 1 : length(page_elements_train)
    elements = page_elements_train{i};
    mboxes = page_btn_train_margin_boxes{i};
    nb_elements = [];
    nb_etypes = [];
    mask = page_imgs{i};
    etypes = page_elements_type_train{i};

    for j = 1 : size(mboxes,1)
        mbox = mboxes(j,:);
        
        
        if mbox(1)-1 > 0
            tmpmbox = [mbox(1)-1 mbox(2:4)];        
            [neigh_box_left, neigh_box_left_type] = find_intc(tmpmbox, elements,etypes, [mbox(1:2) 0 0]);
%             neigh_box_left = find_intc(tmpmbox, elements, [mbox(1:2) 1 mbox(4)]);
        else
            neigh_box_left = [mbox(1:2) 0 0];
            neigh_box_left_type = 0;
%             neigh_box_left = [mbox(1:2) 1 mbox(4)];
        end

        if mbox(2) - 1 > 0
            tmpmbox = [mbox(1) mbox(2) - 1 mbox(3:4)];
            [neigh_box_bottom, neigh_box_bottom_type] = find_intc(tmpmbox, elements,etypes, [mbox(1) mbox(2) 0 0]); 
%             neigh_box_bottom = find_intc(tmpmbox, elements, [mbox(1) mbox(2)+mbox(4) mbox(3) 1]);
        else
%             neigh_box_bottom = [mbox(1) mbox(2)+mbox(4) mbox(3) 1];
            neigh_box_bottom = [mbox(1:2) 0 0];  
            neigh_box_bottom_type = 0;  
        end
        
        if mbox(1) + 1 < size(mask,2)
            tmpmbox = [mbox(1)+1 mbox(2) mbox(3:4)];        
            [neigh_box_right,neigh_box_right_type] = find_intc(tmpmbox, elements,etypes,[mbox(1) mbox(2) 0 0]);  
%             neigh_box_right = find_intc(tmpmbox, elements,[mbox(1)+mbox(3) mbox(2) 0 mbox(4)]);  
        else
%             neigh_box_right = [mbox(1)+mbox(3) mbox(2) 1 mbox(4)];
            neigh_box_right = [mbox(1:2) 0 0];
            neigh_box_right_type = 0;
        end  
        
        if mbox(2) + 1 < size(mask,1)
            tmpmbox = [mbox(1) mbox(2) + 1 mbox(3:4)];        
%             neigh_box_top = find_intc(tmpmbox, elements,[mbox(1:2) mbox(3) 1]);
            [neigh_box_top,neigh_box_top_type] = find_intc(tmpmbox, elements,etypes,[mbox(1) mbox(2) 0 0]);
        else
%             neigh_box_top = [mbox(1:2) mbox(3) 1];
            neigh_box_top = [mbox(1:2) 0 0];
            neigh_box_top_type = 0;
        end
        
        one = [neigh_box_left neigh_box_bottom neigh_box_right neigh_box_top];
        p_one = [neigh_box_left; neigh_box_bottom; neigh_box_right; neigh_box_top];
        type_one = [neigh_box_left_type neigh_box_bottom_type neigh_box_right_type neigh_box_top_type];
        nb_elements = [nb_elements; one];
        nb_etypes = [nb_etypes; type_one];
        
        % 2015/12/14 check top mbox neighbour text type
%         if neigh_box_bottom_type == 3
%             a = neigh_box_bottom;
%             tmp_mask = im2bw( page_img(a(2):a(2)+a(4),a(1):a(1)+a(3),:) ,0.9);
%             figure(1),imshow(tmp_mask);
%             figure(2),imshow(page_img);
%             input('d');
%         end
    end
    page_nb_elements_type{i} = nb_etypes;
    page_nb_elements{i} = nb_elements; 
    acc_nb_elements = [acc_nb_elements; nb_elements];  
    acc_nb_elements_type = [acc_nb_elements_type; nb_etypes];
    
%     break;

end


