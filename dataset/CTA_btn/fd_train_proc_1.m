
page_btn_train_margin_boxes = importdata('page_btn_train_margin_boxes.mat');
page_nb_elements_train = importdata('page_nb_elements_train.mat');
page_nb_elements_type_train = importdata('page_nb_elements_type_train.mat');
page_elements_masks_train = importdata('page_elements_masks_train.mat');
page_imgs = importdata('page_imgs.mat');
% return;






fd = [];
len = length(page_btn_train_margin_boxes);
for i = 1 : len
    mboxes = page_btn_train_margin_boxes{i};
    nb_elements = page_nb_elements_train{i};
    types = page_nb_elements_type_train{i};
    img = page_imgs{i};
%     mboxes_DTs = page_mboxes_DT_train{i};
    for j = 1 : size(mboxes,1)
        mbox = mboxes(j,:);        
        nb_4element = nb_elements(j,:);
        nb_etypes = types(j,:);
%         mbox_DTs = mboxes_DTs(j,:);
        
%         dt = mbox_DTs;
        c0 = [mbox(3)/mbox(4)]; 
        c1 = [mbox(3:4)];
        c2 = [mbox(1)/size(img,2) mbox(2)/size(img,1)];
                        
        d3 = nb_4element(1:2) - mbox(1:2);
        d4 = nb_4element(3:4);
        d5 = nb_4element(5:6) - mbox(1:2);
        d6 = nb_4element(7:8);
        d7 = nb_4element(9:10) - mbox(1:2);
        d8 = nb_4element(11:12);
        d9 = nb_4element(13:14) - mbox(1:2);
        d10 = nb_4element(15:16);
        d11 = nb_4element(1:2) + 0.5 * nb_4element(3:4) - mbox(1:2) - 0.5 * mbox(3:4);
        d12 = nb_4element(5:6) + 0.5 * nb_4element(7:8) - mbox(1:2) - 0.5 * mbox(3:4);
        d13 = nb_4element(9:10) + 0.5 * nb_4element(11:12) - mbox(1:2) - 0.5 * mbox(3:4);
        d14 = nb_4element(13:14) + 0.5 * nb_4element(15:16) - mbox(1:2) - 0.5 * mbox(3:4);
        
%         d15 = nb_4element(1:2);
%         d16 = nb_4element(5:6);
%         d17 = nb_4element(9:10);
%         d18 = nb_4element(13:14);
        d19 = nb_4element(1:2) + nb_4element(3:4) - mbox(1:2) - mbox(3:4);
        d20 = nb_4element(5:6) + nb_4element(7:8) - mbox(1:2) - mbox(3:4);
        d21 = nb_4element(9:10) + nb_4element(11:12) - mbox(1:2) - mbox(3:4);
        d22 = nb_4element(13:14) + nb_4element(13:14) - mbox(1:2) - mbox(3:4);
        
        h1 = min(nb_4element(4),mbox(4)); 
        h2 = min(nb_4element(8),mbox(4)); 
        h3 = min(nb_4element(12),mbox(4));
        h4 = min(nb_4element(16),mbox(4));
        h5 = max(h1,h3);
        h6 = max(h2,h4);
        h7 = max(nb_4element(4),nb_4element(12));
        h8 = max(nb_4element(8),nb_4element(16));
        
        w1 = min(nb_4element(3),mbox(3));
        w2 = min(nb_4element(7),mbox(3));
        w3 = min(nb_4element(11),mbox(3));
        w4 = min(nb_4element(15),mbox(3));
        w5 = max(w1,w3);
        w6 = max(w2,w4);
        w7 = max(nb_4element(3),nb_4element(11));
        w8 = max(nb_4element(7), nb_4element(15));
        
%         left_type = zeros(1,7);
%         left_type(nb_etypes(1) + 1) = 1;
%         
%         bottom_type = zeros(1,7);
%         bottom_type(nb_etypes(1) + 1) = 1;
%         
%         right_type = zeros(1,7);
%         right_type(nb_etypes(1) + 1) = 1;        
%         
%         top_type = zeros(1,7);
%         top_type(nb_etypes(1) + 1) = 1;
%         
%         t1 = left_type;
%         t2 = bottom_type;
%         t3 = right_type;
%         t4 = top_type;
        
        hasleft = 1;
        hasbottom = 1; albottom1 = 0; albottom2 = 0;
        hasright = 1;
        hastop = 1; 
        hastop1 = nb_4element(13) - mbox(1);
        hastop2 = nb_4element(13) + nb_4element(15) - (mbox(1) + mbox(3));
        
        if nb_4element(3) * nb_4element(4) == 0 
            hasleft = 0;
            alleft1 = nb_4element(2) - mbox(2);
            alleft2 = nb_4element(2) + nb_4element(4) - (mbox(2) + mbox(4));
        end
        
        if nb_4element(7) * nb_4element(8) == 0 
            hasbottom = 0;
            albottom1 = nb_4element(5) - mbox(1);
            albottom2 = nb_4element(5) + nb_4element(7) - (mbox(1) + mbox(3));
        end
        
        if nb_4element(11) * nb_4element(12) == 0 
            hasright = 0;
        end
        
        if nb_4element(15) * nb_4element(16) == 0 
            hastop = 0;
            hastop1 = 0; 
            hastop2 = 0;
        end
        
        hasv = [hasleft hasbottom hasright hastop];
        hasv_topd = [hastop1 hastop2];
        
        fd = [fd ;c0 c1 c2 d3 d5 d7 d9 d4 d6 d8 d10 ];        
        % d3 d4 d5 d6 d7 d8 d9 d10 t1 t2 t3 t4
%         fd = [fd ; d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 d19 d20 d21 d22];        
    end
       
end

fd_train = fd;
% save('fd.mat','fd');

