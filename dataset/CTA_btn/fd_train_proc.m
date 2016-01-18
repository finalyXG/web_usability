% fd = importdata('fd.mat');
% return;
gp_train_data_h = [];
fd = [];
len = length(page_btn_train_margin_boxes);
for i = 1 : len
    mboxes = page_btn_train_margin_boxes{i};
    nb_elements = page_nb_elements{i};
    types = page_nb_elements_type{i};
    mboxes_DTs = page_mboxes_DT{i};
    for j = 1 : size(mboxes,1)
        mbox = mboxes(j,:);        
        nb_4element = nb_elements(j,:);
        nb_etypes = types(j,:);
        mbox_DTs = mboxes_DTs(j,:);
        
        dt = mbox_DTs;
        c1 = mbox(1);
        c2 = mbox(2);
        d1 = mbox(3);
        d2 = mbox(4);
        s1 = mbox(3) * mbox(4);
        c3 = d1 * d2;
        c4 = d1 / d2;
        
%         mdt1 = mbox_DTs(1:8);
%         mdt2 = mbox_DTs(9:16);
%         mdt3 = sum(mdt1(1:4) - mdt1(5:8));
%         mdt4 = sum(mdt2(1:4) - mdt1(5:8));
%         d0 = [mdt1 mdt2 mdt3 mdt4];
        
        e1 = [nb_4element(3) nb_4element(11)];
        
        d3 = nb_4element(1:2) - mbox(1:2);
        d4 = nb_4element(4);
        d5 = nb_4element(5:6) - mbox(1:2);
        d6 = nb_4element(7);
        d7 = nb_4element(9:10) - mbox(1:2);
        d8 = nb_4element(12);
        d9 = nb_4element(13:14) - mbox(1:2);
        d10 = nb_4element(15);
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
        
        left_type = zeros(1,7);
        left_type(nb_etypes(1) + 1) = 1;
        
        bottom_type = zeros(1,7);
        bottom_type(nb_etypes(1) + 1) = 1;
        
        right_type = zeros(1,7);
        right_type(nb_etypes(1) + 1) = 1;        
        
        top_type = zeros(1,7);
        top_type(nb_etypes(1) + 1) = 1;
        
        t1 = left_type;
        t2 = bottom_type;
        t3 = right_type;
        t4 = top_type;
        
        
        fd = [fd ;s1 dt c1 c2 d1 d2 d4 d6 d8 d10 t2 t4];        
        % d3 d4 d5 d6 d7 d8 d9 d10 t1 t2 t3 t4
%         fd = [fd ; d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 d19 d20 d21 d22];        
    end
       
end

save('fd.mat','fd');

