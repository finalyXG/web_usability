% fd_w_proc_test


% fd_h_test = importdata('fd_h_test.mat');
% return;
fd_h_test = [];
gp_test_data_h = [];
for i = 1 : length(page_btn_test_margin_boxes)
    mboxes = page_btn_test_margin_boxes{i};
    nb_elements = page_nb_elements{i};
    for j = 1 : size(mboxes,1)
        mbox = mboxes(j,:);
        nb_4element = nb_elements(j,:);
        
        d1 = mbox(3);
        d2 = mbox(4);
        d4 = nb_4element(3:4);
        d6 = nb_4element(7:8);
        d8 = nb_4element(11:12);
        d10 = nb_4element(15:16);
        
%         d15 = nb_4element(1:2);
%         d16 = nb_4element(5:6);
%         d17 = nb_4element(9:10);
%         d18 = nb_4element(13:14);
%         d19 = nb_4element(1:2) + nb_4element(3:4) - mbox(1:2) - mbox(3:4);
%         d20 = nb_4element(5:6) + nb_4element(7:8) - mbox(1:2) - mbox(3:4);
%         d21 = nb_4element(9:10) + nb_4element(11:12) - mbox(1:2) - mbox(3:4);
%         d22 = nb_4element(13:14) + nb_4element(13:14) - mbox(1:2) - mbox(3:4);
        d11 = nb_4element(2) - mbox(2);
        d12 = nb_4element(6) - mbox(2);
        d13 = nb_4element(10) - mbox(2);
        d14 = nb_4element(14) - mbox(2); 


        d19 = (nb_4element(2) + nb_4element(4) - mbox(2) - mbox(4));
        d20 = nb_4element(6) + nb_4element(8) - mbox(2) - mbox(4);
        d21 = nb_4element(10) + nb_4element(12) - mbox(2) - mbox(4);
        d22 = nb_4element(14) + nb_4element(16) - mbox(2) - mbox(4);        
        
        fd_h_test = [fd_h_test ; d1 d2 d4 d6 d8 d10 ]; 
    end
       
end

save('fd_h_test.mat','fd_h_test');



