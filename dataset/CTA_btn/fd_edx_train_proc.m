% fd_dy_test_proc


% fd_dy_test = importdata('fd_dy_test.mat');
% return;
fd_edx_train = [];
for i = 1 : length(page_btn_train_margin_boxes)
    mboxes = page_btn_train_margin_boxes{i};
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

        d19 = nb_4element(1:2) + nb_4element(3:4) - mbox(1:2) - mbox(3:4);
        d20 = nb_4element(5:6) + nb_4element(7:8) - mbox(1:2) - mbox(3:4);
        d21 = nb_4element(9:10) + nb_4element(11:12) - mbox(1:2) - mbox(3:4);
        d22 = nb_4element(13:14) + nb_4element(13:14) - mbox(1:2) - mbox(3:4);

%         d11 = nb_4element(1) - mbox(1);
%         d12 = nb_4element(5) - mbox(1);
%         d13 = nb_4element(9) - mbox(1);
%         d14 = nb_4element(13) - mbox(1); 

        d16 = 0;
        if nb_4element(7) > 0 && ...
            min(nb_4element(5) + nb_4element(7), mbox(1)+mbox(3)) - max(nb_4element(5),mbox(1)) > 0
        
            d16 = min(nb_4element(5) + nb_4element(7), mbox(1)+mbox(3)) - max(nb_4element(5),mbox(1));
        end
                
        d18 = 0;
        if nb_4element(15) > 0 &&...
           min(nb_4element(13) + nb_4element(15), mbox(1)+mbox(3)) - max(nb_4element(13),mbox(1)) > 0 
       
            d18 = min(nb_4element(13) + nb_4element(15), mbox(1)+mbox(3)) - max(nb_4element(13),mbox(1));
        end


%         d19 = (nb_4element(1) + nb_4element(3) - mbox(1) - mbox(3));
%         d20 = nb_4element(5) + nb_4element(7) - mbox(1) - mbox(3);
%         d21 = nb_4element(9) + nb_4element(11) - mbox(1) - mbox(3);
%         d22 = nb_4element(13) + nb_4element(15) - mbox(1) - mbox(3);      
        
        fd_edx_train = [fd_edx_train ; d1 d2 d4 d6 d8 d10 d16 d18 d19 d20 d21 d22]; 
    end
       
end
save('fd_edx_train.mat','fd_edx_train');