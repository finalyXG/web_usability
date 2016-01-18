
page_btn_test_margin_boxes = importdata('page_btn_test_margin_boxes.mat');
page_elements_test = importdata('page_elements_test.mat');
page_elements_type_test = importdata('page_elements_type_test.mat');
page_imgs_test = importdata('page_imgs_test.mat');

return;





% 
tic

[page_elements_masks_test,page_btn_test_margin_boxes,page_elements_test,...
    page_elements_type_test...
    ,page_imgs_test,Dtest] = get_page_mask_mboxes_test(D,HOMEIMAGES, 1);

toc



%%
tic
save('page_elements_type_test.mat','page_elements_type_test');
save('page_btn_test_margin_boxes.mat','page_btn_test_margin_boxes');
save('page_elements_test.mat','page_elements_test');
save('page_imgs_test.mat','page_imgs_test');
toc






