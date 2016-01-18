for i = 1 : size(acc_BTNs,1)
    BTN_gt = zeros(floor(acc_BTNs(i,4) / 5),floor(acc_BTNs(i,3) / 5),3);
    BTN_gt(:,:,1) = td_train_color_y(i,1);
    BTN_gt(:,:,2) = td_train_color_y(i,2);
    BTN_gt(:,:,3) = td_train_color_y(i,3);
    
    BTN_test = zeros(floor(BTN_h_test(i) / 5) , floor(BTN_w_test(i) / 5) ,3);
    BTN_test(:,:,1) = test_color(i,1);
    BTN_test(:,:,2) = test_color(i,2);
    BTN_test(:,:,3) = test_color(i,3);
    
    colorTransform = makecform('srgb2lab');

end

figure(1),clf,

for i = 1 : size(acc_BTNs,1)
    BTN_gt = zeros(floor(acc_BTNs(i,4) / 5),floor(acc_BTNs(i,3) / 5),3);
    BTN_gt(:,:,1) = td_train_color_y(i,1);
    BTN_gt(:,:,2) = td_train_color_y(i,2);
    BTN_gt(:,:,3) = td_train_color_y(i,3);
    
    BTN_test = zeros(floor(BTN_h_test(i) / 5) , floor(BTN_w_test(i) / 5) ,3);
    BTN_test(:,:,1) = test_color(i,1);
    BTN_test(:,:,2) = test_color(i,2);
    BTN_test(:,:,3) = test_color(i,3);
    
    subplot(16,16,i * 2) 
    imshow(BTN_gt);
    
    subplot(16,16,i * 2 - 1)
    imshow(BTN_test);
    i
%     input('d');
    
end