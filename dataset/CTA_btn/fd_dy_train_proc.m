% fd_dy_train_proc


% fd_dy_train = importdata('fd_dy_train.mat');
% return;
fd_dy_train = [];
for i = 1 : length(page_btn_train_margin_boxes)
    mboxes = page_btn_train_margin_boxes{i};
%     mboxes_DTs = page_mboxes_DT{i};
    nb_elements = page_nb_elements{i};
    BTNs = page_BTNs{i};
    
    for j = 1 : size(mboxes,1)
        BTN = BTNs(j,:);
        mbox = mboxes(j,:);
%         mbox_DTs = mboxes_DTs(j,:);
        nb_4element = nb_elements(j,:);
        
%         a1 = BTN(3:4);
%         c1 = BTN(3) - nb_4element(3);
        c1 = BTN(4) - nb_4element(4);
        if c1 < 10
            c4 = nb_4element(2) - mbox(2);
            c41 = nb_4element(2) + nb_4element(4) * 0.5 - BTN(4) * 0.5 - mbox(2);
            c42 = nb_4element(2) + nb_4element(4) - mbox(2);
        else
            c4 = 0;
            c41 = 0;
            c42 = 0;
        end
        
        c2 = BTN(4) - nb_4element(12);
        if c2 < 10
            c5 = nb_4element(10) - mbox(2);
            c51 = nb_4element(10) + nb_4element(12)*0.5 - BTN(4) * 0.5 - mbox(2);  
            c52 = nb_4element(10) + nb_4element(12) - mbox(2);
        else
             c5 = 0;
             c51 = 0;
             c52 = 0;
        end
        
        
        d1 = mbox(1:4);
%         d2 = mbox_DTs;
        
        d3 = nb_4element(1:2) - mbox(1:2);
        d4 = nb_4element(3:4);
        d5 = nb_4element(5:6) - mbox(1:2);
        d6 = nb_4element(7:8);
        d7 = nb_4element(9:10) - mbox(1:2);
        d8 = nb_4element(11:12);
        d9 = nb_4element(13:14) - mbox(1:2);
        d10 = nb_4element(15:16); 
        

        fd_dy_train = [fd_dy_train ;  ...
            d1 d3 d4 d5 d6 d7 d8 d9 d10 ]; 
        % d4 d6 d8 d10 d11 d12 d13 d14 d19 d20 d21 d22
    end
       
end
save('fd_dy_train.mat','fd_dy_train');