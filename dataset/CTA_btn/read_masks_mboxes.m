page_elements_masks_train = importdata('page_elements_masks_train.mat');
page_btn_train_margin_boxes = importdata('page_btn_train_margin_boxes.mat');
page_elements_train = importdata('page_elements_train.mat');
page_elements_type_train = importdata('page_elements_type_train.mat');
page_BTNs = importdata('page_BTNs.mat');
page_btns = importdata('page_btns.mat');
 
 
return; 
% 
tic  
page_elements_masks = []; 
page_btn_train_margin_boxes = [];
[page_elements_masks_train,page_btn_train_margin_boxes,page_BTNs,page_btns,...
page_elements_train,page_elements_type_train] = ...
    get_page_mask_mboxes(...
    text_label_file_names,...
    button_label,BTN_label, img_label,input_label,text_label,bgi_label,border_label);
toc

%%
save('page_BTNs.mat','page_BTNs');
%%
save('page_btns.mat','page_btns');
%%
save('page_elements_type_train.mat','page_elements_type_train');
%%
save('page_elements_masks_train.mat','page_elements_masks_train');
%%
save('page_btn_train_margin_boxes.mat','page_btn_train_margin_boxes');
%%
save('page_elements_train.mat','page_elements_train');

%%


        