% fd_w_proc_test


% fd_w_train = importdata('fd_w_train.mat');
% return;
page_BTNs = importdata('page_BTNs.mat');
fd_btn_BTN_h_train = [];
gp_train_data_h = [];
for i = 1 : length(page_btn_train_margin_boxes)
    mboxes = page_btn_train_margin_boxes{i};
    nb_elements = page_nb_elements{i};
    BTNs = page_BTNs{i};
    
    for j = 1 : size(mboxes,1)
        mbox = mboxes(j,:);
        nb_4element = nb_elements(j,:);
        BTN = BTNs(j,:);
        
        
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
        
        fd_btn_BTN_h_train = [fd_btn_BTN_h_train ;...
               d0 d1 d3 d4 d7 d8]; 
           %a1 d1 d2 h1 h2 h3 h4 h5 h6 h7 h8
            
    end
       
end

% nfd_w_train = [];
% for i = 1 : size(fd_w_train,1)
%     b1 = acc_mbox2btn_wh(i,2) ;
%     b3 = acc_mbox2btn_oxoy(i,:) - acc_btn_train_margin_boxes(i,1:2);
%     tmp = [fd_w_train(i,:) b1 b3];
%     nfd_w_train = [nfd_w_train; tmp];
% end
% 
% fd_w_train = nfd_w_train;

save('fd_btn_BTN_h_train.mat','fd_btn_BTN_h_train');
return;

%%
fd_btn_BTN_h_train = [fd_btn_BTN_h_train acc_BTNs(:,3)];

BTN_h_test_r = my_gpml_reg_w(fd_btn_BTN_h_train(:,:), [repmat(acc_BTNs(:,4) ./ acc_btn_train_margin_boxes(:,4),1,1)] , fd_btn_BTN_h_train(:,:),...
    [ones(size(fd_btn_BTN_h_train(1,:))) .* 1 0.1] ... % 0.5 1
    ,  [zeros(size(fd_btn_BTN_h_train(1,:))) 1]');
BTN_h_test = round(BTN_h_test_r .* acc_btn_train_margin_boxes(:,4));
tmpv = abs(BTN_h_test - repmat(acc_BTNs(:,4),1,1));
[mv,mi] = max(tmpv)
[smv,si] = sort(tmpv,'descend');
sum(tmpv)
x = [1 : size(BTN_h_test,1)]';
h1 = acc_BTNs(:,4);
h2 = BTN_h_test;
figure(1),clf,hold on,
plot(x,h1,'-ob');
plot(x,h2,'-or');
hold off;