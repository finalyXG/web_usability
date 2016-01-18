% fd_w_proc_test


% fd_w_test = importdata('fd_w_test.mat');
% return;
fd_w_test = [];
gp_train_data_h = [];
for i = 1 : length(page_btn_test_margin_boxes)
    mboxes = page_btn_test_margin_boxes{i};
    nb_elements = page_nb_elements{i};
    for j = 1 : size(mboxes,1)
        mbox = mboxes(j,:);
        nb_4element = nb_elements(j,:);
        
        b1 = nb_4element(3:4);
        b2 = nb_4element(7:8);
        b3 = nb_4element(11:12);
        b4 = nb_4element(15:16);        
        
        c0 = mbox(3) / mbox(4);
        c1 = nb_4element(3) * nb_4element(4) ;
        c2 = nb_4element(7) * nb_4element(8) ;
        c3 = nb_4element(11) * nb_4element(12) ;
        c4 = nb_4element(15) * nb_4element(16) ;
        
        c5 = norm([nb_4element(3),nb_4element(4) ]);
        c6 = norm([nb_4element(7), nb_4element(8)]);
        c7 = norm([nb_4element(11), nb_4element(12)]);
        c8 = norm([nb_4element(15), nb_4element(16)]);
        
        c9 = mbox(1:2) - nb_4element(1:2);
        c10 = mbox(1:2) - nb_4element(5:6);
        c11 = mbox(1:2) - nb_4element(9:10);
        c12 = mbox(1:2) - nb_4element(13:14);
        
        c13 = mbox(3:4) - nb_4element(3:4);
        c14 = mbox(3:4) - nb_4element(7:8);
        c15 = mbox(3:4) - nb_4element(11:12);
        c16 = mbox(3:4) - nb_4element(15:16);
        
        c17 = nb_4element(1:2) - nb_4element(9:10);
        c18 = nb_4element(5:6) - nb_4element(13:14);
        c19 = nb_4element(3:4) - nb_4element(11:12);
        c20 = nb_4element(7:8) - nb_4element(15:16);

        d1 = mbox(3:4);
        
%         d3 = norm([d1,d2]);
        
%         d3 = d1 / d2;
%         d4 = nb_4element(3:4);
%         d6 = nb_4element(7:8);
%         d8 = nb_4element(11:12);
%         d10 = nb_4element(15:16);
        
        
%         d15 = nb_4element(1:2);
        d16 = 0;
        d17 = nb_4element(7);
        if nb_4element(7) > 0 && ...
            min(nb_4element(5) + nb_4element(7), mbox(1)+mbox(3)) - max(nb_4element(5),mbox(1)) > 0
        
            d16 = min(nb_4element(5) + nb_4element(7), mbox(1)+mbox(3)) - max(nb_4element(5),mbox(1));
        end
                
        d18 = 0;
        d19 = nb_4element(15);
        if nb_4element(15) > 0 &&...
           min(nb_4element(13) + nb_4element(15), mbox(1)+mbox(3)) - max(nb_4element(13),mbox(1)) > 0 
       
            d18 = min(nb_4element(13) + nb_4element(15), mbox(1)+mbox(3)) - max(nb_4element(13),mbox(1));
        end
        
        d20 = 0;
        tmp = min(nb_4element(2) + nb_4element(4),mbox(2)+mbox(4)) - max(nb_4element(2), mbox(2));
        if nb_4element(4) > 0
            d20 = tmp;
        end
        
        d22 = 0;
        tmp = min(nb_4element(10) + nb_4element(12),mbox(2)+mbox(4)) - max(nb_4element(10), mbox(2));
        if nb_4element(4) > 0
            d22 = tmp;
        end        
        
        h1 = min(nb_4element(4),mbox(4));
        w1 = min(nb_4element(3),mbox(3));
        w2 = min(nb_4element(7),mbox(3));
        w3 = min(nb_4element(11),mbox(3));
        w4 = min(nb_4element(15),mbox(3));
        w5 = max(w1,w3);
        w6 = max(w2,w4);
        w7 = max(nb_4element(3),nb_4element(11));
        w8 = max(nb_4element(7), nb_4element(15));
        
        fd_w_test = [fd_w_test ;...
                d1 b1 b2 b3 b4 w7 w8]; 
    end
       
end
save('fd_w_test.mat','fd_w_test');