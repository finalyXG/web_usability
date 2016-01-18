% fd_w_proc_test


% fd_w_train = importdata('fd_w_train.mat');
% return;
page_btn_train_margin_boxes = importdata('page_btn_train_margin_boxes.mat');
page_nb_elements = importdata('page_nb_elements_train.mat');
page_nb_elements_type = importdata('page_nb_elements_type_train.mat');
fd_btn_BTN_w_train = [];
gp_train_data_h = [];

for i = 1 : length(page_btn_train_margin_boxes)
    mboxes = page_btn_train_margin_boxes{i};
%     mboxes_DTs = page_mboxes_DT{i};
    nb_elements = page_nb_elements{i};
    types = page_nb_elements_type{i};
%     mask = page_elements_masks{i};
%     mask_size = size(mask);
%     ms0 = mask_size;
    
    for j = 1 : size(mboxes,1)
        mbox = mboxes(j,:);
%         mbox_DTs = mboxes_DTs(j,:);
%         mbox_DTs = [mbox_DTs(1:8) mbox_DTs(17:24)];
%         mbox_DTs = [mbox_DTs(9:16)];
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
        
                      
        
        
        fd_btn_BTN_w_train = [fd_btn_BTN_w_train ;...
                  d0 d1 d5 d6 d9 d10]; 
        % c0 c1 c2 c3 c4 c5 ds d1 d2 b1 b2 b3 b4 w5 w6 w7 w8 t1 t2 t3 t4
        % d1 b1 b2 b3 b4 w5 w6 w7 w8 nearw nearh_2_w
        % b1 b2 b3 b4 w5 w6 w7 w8 nearw nearh_2_w
%         fd_btn_BTN_w_train = floor(fd_btn_BTN_w_train / 5) * 5;

            
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

save('fd_btn_BTN_w_train.mat','fd_btn_BTN_w_train');

%%

return;
fd_btn_BTN_w_train1 = [fd_btn_BTN_w_train; fd_btn_BTN_w_train + 5; fd_btn_BTN_w_train - 5];
mboxes = importdata('acc_btn_train_margin_boxes.mat');
BTN_w_test_r = my_gpml_reg_w(fd_btn_BTN_w_train(:,:), [repmat(acc_BTNs(:,3) ./ mboxes(:,3) ,1,1)] , fd_btn_BTN_w_train(:,:),...
    [ones(size(fd_btn_BTN_w_train(1,:))) .* 1 0.1] ... % 0.4 0.1
    ,  [zeros(size(fd_btn_BTN_w_train(1,:))) 1]');  
BTN_w_test = round(BTN_w_test_r .* mboxes(:,3));
% BTN_w_test = round(BTN_w_test);
% return;
tmpv = abs(BTN_w_test - repmat(acc_BTNs(:,3),1,1));
[mv,mi] = max(tmpv)
[smv,si] = sort(tmpv,'descend');
sum(tmpv)
return;
x = [1 : size(BTN_w_test,1)]';
w1 = acc_BTNs(:,3);
w2 = BTN_w_test;
figure(1),clf,hold on,
plot(x,w1,'-ob');
plot(x,w2,'-or');
hold off;