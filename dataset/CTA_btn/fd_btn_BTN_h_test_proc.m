% fd_w_proc_test


% fd_w_train = importdata('fd_w_train.mat');
% return;
fd_btn_BTN_h_test = [];
for i = 1 : length(page_btn_test_margin_boxes)
    mboxes = page_btn_test_margin_boxes{i};
    nb_elements = page_nb_elements_test{i};
    types = page_nb_elements_type_test{i};
    
    for j = 1 : size(mboxes,1)
        mbox = mboxes(j,:);
%         mbox_DTs = mboxes_DTs(j,:);
        nb_4element = nb_elements(j,:);
        nb_etypes = types(j,:);

        b1 = nb_4element(3:4);
        b2 = nb_4element(7:8);
        b3 = nb_4element(11:12);
        b4 = nb_4element(15:16);
    
        d0 = mbox(1:2);
        d1 = mbox(3:4);
        d3 = nb_4element(1:2) - mbox(1:2);
        d4 = nb_4element(3:4);
        d5 = nb_4element(5:6) - mbox(1:2);
        d6 = nb_4element(7:8);
        d7 = nb_4element(9:10) - mbox(1:2);
        d8 = nb_4element(11:12);
        d9 = nb_4element(13:14) - mbox(1:2);
        d10 = nb_4element(15:16);       
        
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
        
        fd_btn_BTN_h_test = [fd_btn_BTN_h_test ;...
               d0 d1 d3 d4 d7 d8];
        
    end
       
end


save('fd_btn_BTN_h_test.mat','fd_btn_BTN_h_test');