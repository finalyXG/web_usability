page_btn_train_margin_boxes = importdata('page_btn_train_margin_boxes.mat');
page_elements_train = importdata('page_elements_train.mat');
page_elements_type_train = importdata('page_elements_type_train.mat');
page_BTNs = importdata('page_BTNs.mat');
page_imgs = importdata('page_imgs.mat');
return; 

% 
tic  


[page_btn_train_margin_boxes,page_BTNs,...
page_elements_train,page_elements_type_train,page_imgs,acc_btn_train_margin_boxes,Delement] = ...
    get_page_mask_mboxes(D,HOMEIMAGES, 1);
toc

tic


%%
save('page_elements_type_train.mat','page_elements_type_train');
save('page_btn_train_margin_boxes.mat','page_btn_train_margin_boxes');
save('page_elements_train.mat','page_elements_train');
save('page_imgs.mat','page_imgs');
save('page_BTNs.mat','page_BTNs');
save('acc_btn_train_margin_boxes.mat','acc_btn_train_margin_boxes');
%%


        