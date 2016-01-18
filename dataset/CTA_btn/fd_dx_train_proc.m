% fd_dy_train_proc


% fd_dy_train = importdata('fd_dy_train.mat');
% return;
fd_dx_train = [];
for i = 1 : length(page_btn_train_margin_boxes)
    mboxes = page_btn_train_margin_boxes{i};
    nb_elements = page_nb_elements{i};
    types = page_nb_elements_type{i};
    BTNs = page_BTNs{i};
    
    for j = 1 : size(mboxes,1)
        mbox = mboxes(j,:);
        nb_4element = nb_elements(j,:);
        nb_etypes = types(j,:);
        
        d1 = mbox(1:4);
        
        d3 = nb_4element(1:2) - mbox(1:2);
        d4 = nb_4element(3:4);
        d5 = nb_4element(5:6) - mbox(1:2);
        d6 = nb_4element(7:8);
        d7 = nb_4element(9:10) - mbox(1:2);
        d8 = nb_4element(11:12);
        d9 = nb_4element(13:14) - mbox(1:2);
        d10 = nb_4element(15:16); 
        



        
        fd_dx_train = [fd_dx_train ; d1 d3 d4 d5 d6 d7 d8 d9 d10 ];  % 
        % d0 d1 d2 d4 d6 d8 d10 e1 f0 f1 f2 f3 f4 f5
        % d1 d2 d4 d6 d8 d10 e1 f0 f1 f2 f3 f4 f5
    end
       
end
save('fd_dx_train.mat','fd_dx_train');