% fd_dy_train_proc


% fd_alignment_train = importdata('fd_alignment_train.mat');
% return;
fd_alignment_train = [];
for i = 1 : length(page_btn_train_margin_boxes)
    mboxes = page_btn_train_margin_boxes{i};
    mboxes_DTs = page_mboxes_DT{i};
    nb_elements = page_nb_elements{i};
    BTNs = page_BTNs{i};
    
    for j = 1 : size(mboxes,1)
        BTN = BTNs(j,:);
        mbox = mboxes(j,:);
        mbox_DTs = mboxes_DTs(j,:);
        nb_4element = nb_elements(j,:);
               
        d0 = BTN(3:4);
        d1 = mbox(1:4);
        d2 = mbox_DTs;
        
        d3 = nb_4element(1:2) - mbox(1:2);
        d4 = nb_4element(3:4);
        d5 = nb_4element(5:6) - mbox(1:2);
        d6 = nb_4element(7:8);
        d7 = nb_4element(9:10) - mbox(1:2);
        d8 = nb_4element(11:12);
        d9 = nb_4element(13:14) - mbox(1:2);
        d10 = nb_4element(15:16); 
        

        fd_alignment_train = [fd_alignment_train ; ...
        d0 d1 d3 d4 d5 d6 d7 d8 d9 d10 ]; 
    end
       
end
save('fd_alignment_train.mat','fd_alignment_train');