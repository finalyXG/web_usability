dytest = BTNs_dy_test;
acc_btn_train_margin_boxes = page_btn_test_margin_boxes{1};
acc_nb_elements = page_nb_elements{1};
pboxes0 = [plbtn1(:,1) + BTNs_dx_test, plbtn1(:,2) + BTNs_dy_test, BTN_w_test, BTN_h_test]; 
acc_BTNs = pboxes0;

for i = 1 : size(dytest,1)
    dy = dytest(i);
    dh = BTN_h_test(i);
    mbox = acc_btn_train_margin_boxes(i,:);
    nbs = acc_nb_elements(i,:);
    BTN = acc_BTNs(i,:);
    
   
    if nbs(3) == 0 && nbs(4) == 0 && nbs(11) == 0 && nbs(12) == 0
        continue;
    else
        testv = abs([mbox(2) + dy - nbs(2);...
                mbox(2) + dy + dh * 0.5 - (nbs(2) + nbs(4) * 0.5) ;...
                mbox(2) + dy + dh - (nbs(2) + nbs(4))]);
        
        b = [...
        nbs(2) - mbox(2);...
        nbs(2) + nbs(4) * 0.5 - dh * 0.5 - mbox(2);...
        nbs(2) + nbs(4) - dh - mbox(2);...
        ];
        
        [minv mini] = min(testv);
        if minv < 12
            dy = b(mini);  
            dytest(i) = dy;
        end
        
        if dy + dh > mbox(2) + mbox(4)
            dy = mbox(2) + mbox(4) - dh;
            dytest(i) = dy;
        end
        
    end
           
end

BTNs_dy_test = dytest;
  


 