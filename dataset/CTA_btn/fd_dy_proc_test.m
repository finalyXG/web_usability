% fd_dy_test_proc


% fd_dy_test = importdata('fd_dy_test.mat');
% return;
fd_dy_test = [];
for i = 1 : length(page_btn_test_margin_boxes)
    mboxes = page_btn_test_margin_boxes{i};
    nb_elements = page_nb_elements{i};
    for j = 1 : size(mboxes,1)
        mbox = mboxes(j,:);
        nb_4element = nb_elements(j,:);
        
        
%         d0 = BTN(3:4);
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

        fd_dy_test = [fd_dy_test ; ...
            d1 d3 d4 d5 d6 d7 d8 d9 d10 ]; 
    end
       
end
save('fd_dy_test.mat','fd_dy_test');