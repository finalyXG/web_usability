% fd_w_proc_test


% fd_w_train = importdata('fd_w_train.mat');
% return;
fd_btn_BTN_w_test = [];
for i = 1 : length(page_btn_test_margin_boxes)
    mboxes = page_btn_test_margin_boxes{i};
    nb_elements = page_nb_elements_test{i};
    types = page_nb_elements_type_test{i};
    img = page_imgs_test{i};
    mask_size = size(img); mask_size  = mask_size(1:2);
    ms0 = mask_size;
    
    for j = 1 : size(mboxes,1)
        mbox = mboxes(j,:);
%         mbox_DTs = [mbox_DTs(1:8) mbox_DTs(17:24)];
        nb_4element = nb_elements(j,:);
        nb_etypes = types(j,:);

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
        
        fd_btn_BTN_w_test = [fd_btn_BTN_w_test ;...
                  d0 d1 d5 d6 d9 d10]; 
        
%         fd_btn_BTN_test = floor(fd_btn_BTN_test / 5) * 5;
    end
       
end

% return;
save('fd_btn_BTN_w_test.mat','fd_btn_BTN_w_test');