fd_h_train_block1 = round(fd_h_train_block * 1.1);
btn_block_dy_test1 = round(fd_dy_train_block * 1.1);

btn_blocks_dxdy = acc_mbox2btn_oxoy(:,1:2) -  acc_btn_train_margin_boxes(:,1:2);
btn_block_dy_test = my_gpml_reg_w(fd_dy_train_block(:,:), [btn_blocks_dxdy(:,2)] , btn_block_dy_test1(:,:),...
    [ones(size(fd_dy_train_block(1,:))) * 0.3 3],  [zeros(size(fd_dy_train_block(1,:))) 1]');  

% sum(abs(btn_block_dy_test - repmat(btn_blocks_dxdy(:,2),1,1) )) 
% return;

btn_block_h_test = my_gpml_reg_w(fd_h_train_block(:,:), [acc_mbox2btn_wh(:,2)] , fd_h_train_block1(:,:),...
    [ones(size(fd_h_train_block(1,:))) * 0.3 1],  [zeros(size(fd_h_train_block(1,:))) 1]');  

% sum(abs(btn_block_h_test - repmat(acc_mbox2btn_wh(:,2),1,1) ) )
% return;
acc_btn_blocks = [acc_btn_train_margin_boxes(:,1),...
    acc_btn_train_margin_boxes(:,2) + btn_block_dy_test, acc_btn_train_margin_boxes(:,3),...
    btn_block_h_test];


acc_btn_blocks_dump = acc_btn_blocks;
page_btn_blocks = [];
for i = 1 : length(page_BTNs)    
    BTNs = page_BTNs{i};
    page_btn_blocks{i} = acc_btn_blocks_dump(1:size(BTNs,1),:);
    acc_btn_blocks_dump(1:size(BTNs,1),:) = [];
end
