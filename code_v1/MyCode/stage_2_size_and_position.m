%% gaussian process 


% gaussian process btn BTN
acc_BTNs = importdata('acc_BTNs.mat');
acc_btn_train_margin_boxes = importdata('acc_btn_train_margin_boxes.mat');
% fd_btn_BTN_w_train = importdata('fd_btn_BTN_w_train.mat');
% fd_btn_BTN_w_train1 = [fd_btn_BTN_w_train; fd_btn_BTN_w_train + 5; fd_btn_BTN_w_train - 5];

% fd_btn_BTN_w_train1 = fd_btn_BTN_w_train * 1.1; 

%fd_btn_BTN_w_test_proc
fd_btn_BTN_w_train_proc
fd_btn_BTN_w_test_proc
clc

BTN_w_test_r = my_gpml_reg_w(fd_btn_BTN_w_train(:,:), [repmat(acc_BTNs(:,3)./acc_btn_train_margin_boxes(:,3) ,1,1)] , fd_btn_BTN_w_test(:,:),...
    [ones(size(fd_btn_BTN_w_train(1,:))) .* 0.4 1] ...
    ,  [zeros(size(fd_btn_BTN_w_train(1,:))) 1]');  

BTN_w_test = round(acc_mboxes_test(:,3) .* BTN_w_test_r);
% tmpv = abs(BTN_w_test - repmat(acc_BTNs(:,3),1,1));
% [mv,mi] = max(tmpv) 
% [smv,si] = sort(tmpv,'descend');
% sum(tmpv)
% % return;
% x = [1 : size(BTN_w_test,1)]';
% w1 = acc_BTNs(:,3);
% w2 = BTN_w_test;
% figure(1),clf,hold on,
% plot(x,w1,'-ob');
% plot(x,w2,'-or');
% hold off;



%%
fd_btn_BTN_h_train_proc
% fd_btn_BTN_h_train = importdata('fd_btn_BTN_h_train.mat');
fd_btn_BTN_h_train = [fd_btn_BTN_h_train acc_BTNs(:,3)];
fd_btn_BTN_h_test_proc
fd_btn_BTN_h_test = [fd_btn_BTN_h_test BTN_w_test];

BTN_h_test_r = my_gpml_reg_w(fd_btn_BTN_h_train(:,:), repmat(acc_BTNs(:,4)./ acc_btn_train_margin_boxes(:,4),1,1) , fd_btn_BTN_h_test(:,:),...
    [ones(size(fd_btn_BTN_h_train(1,:))) .* 0.5 1]...
    ,  [zeros(size(fd_btn_BTN_h_train(1,:))) 1]');  

BTN_h_test = round(acc_mboxes_test(:,4) .* BTN_h_test_r);


%% fd_dx_proc_test
% fd_dx_train = importdata('fd_dx_train.mat');
% fd_dx_train = [acc_BTNs(:,3:4),fd_dx_train(:,3) - acc_BTNs(:,3), fd_dx_train];
% 
% fd_dx_proc_test 
% fd_dx_test = [BTN_w_test, BTN_h_test, fd_dx_test(:,3) - BTN_w_test, fd_dx_test ];
% 
% BTNs_dxy = acc_BTNs(:,1:2) - acc_btn_train_margin_boxes(:,1:2);
% BTNs_dx_test = my_gpml_reg_w(fd_dx_train(:,:), repmat(BTNs_dxy(:,1),1,1), fd_dx_test(:,:),...
%     [ones(size(fd_dx_train(1,:))) .* [2.4721211] 0.1]...
%     ,  [zeros(size(fd_dx_train(1,:))) 1]');  
% BTNs_dx_test1 = round(BTNs_dx_test);
%% fd_dy_proc_test
% fd_dy_train = importdata('fd_dy_train.mat');
% fd_dy_train = [acc_BTNs(:,3:4), fd_dy_train(:,4) - acc_BTNs(:,4),  fd_dy_train];
% 
% fd_dy_proc_test
% fd_dy_test = [BTN_w_test, BTN_h_test, fd_dy_test(:,4) - BTN_h_test,  fd_dy_test];
% BTNs_dxy = acc_BTNs(:,1:2) - acc_btn_train_margin_boxes(:,1:2);
% 
% % fd_dy_train = [acc_BTNs(:,3:4), fd_dy_train(:,4) - acc_BTNs(:,4),  fd_dy_train];
% BTNs_dy_test = my_gpml_reg_w(fd_dy_train(:,:), repmat(BTNs_dxy(:,2),1,1), fd_dy_test(:,:),...
%     [ones(size(fd_dy_train(1,:))) * 5 1],  [zeros(size(fd_dy_train(1,:))) 1]');     
% BTNs_dy_test = round(BTNs_dy_test);
% BTNs_dy_test1 = BTNs_dy_test;
% cluster_dytest

%%

%%
if ~exist('page_imgs_train','var')
    page_imgs_train = importdata('page_imgs.mat');  
end
%% x alignment type
tic
BTN_test_x_alignment_handle
toc
%% y alignment type
tic
BTN_test_y_alignment_handle
toc
%%
handle_x_offset_by_alignment_type
handle_y_offset_by_alignment_type
