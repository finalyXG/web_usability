page_btn_train_margin_boxes = importdata('page_btn_train_margin_boxes.mat');
acc_btn_train_margin_boxes = importdata('acc_btn_train_margin_boxes.mat');



page_elements_masks_test = importdata('page_elements_masks_test.mat');
page_btn_test_margin_boxes = importdata('page_btn_test_margin_boxes.mat');
page_elements_test = importdata('page_elements_test.mat');
page_elements_type_test = importdata('page_elements_type_test.mat');
page_imgs_test = importdata('page_imgs_test.mat');

return;





% 
% tic
% 
% 
% [page_elements_masks_test,page_btn_test_margin_boxes,page_elements_test,page_elements_type_test,four_edges_analysis_test...
%     ,page_imgs_test] = get_page_mask_mboxes_test(...
%     text_label_file_names,...
%     button_label,img_label,input_label,text_label,bgi_label,border_label, 1);
% toc
% 
% 
% % 
% return;


%   figure(1),clf,hold on,
%     imshow(img); 
%     plot_multi_boxes([page_elements_test{2}]);
%     hold off;
%     i
%     d = input('dump');

% param = importdata('param.mat');
% freq_4_edge = importdata('freq_4_edge.mat');
% density = importdata('density.mat');
% freq_v = importdata('freq_v.mat');
% freq_w = importdata('freq_w.mat'); 
% btns = importdata('btns.mat');
% acc_freq_v = importdata('acc_freq_v.mat');
% acc_freq_w = importdata('acc_freq_w.mat');


% page_btn_train_margin_boxes = importdata('page_btn_train_margin_boxes.mat');
% acc_btn_train_margin_boxes = importdata('acc_btn_train_margin_boxes.mat');



%%
tic
save('page_elements_type_test.mat','page_elements_type_test');
save('page_elements_masks_test.mat','page_elements_masks_test');
save('page_btn_test_margin_boxes.mat','page_btn_test_margin_boxes');
save('page_elements_test.mat','page_elements_test');
save('page_imgs_test.mat','page_imgs_test');
toc






