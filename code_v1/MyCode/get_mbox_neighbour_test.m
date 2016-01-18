page_elements_train = page_elements_test;
% page_elements_masks_train = page_elements_masks_test;
page_btn_train_margin_boxes = page_btn_test_margin_boxes;
page_elements_type_train = page_elements_type_test;
page_imgs = page_imgs_test;

get_mbox_neighbour

page_nb_elements_type_test = page_nb_elements_type;
page_nb_elements_test = page_nb_elements;
plbox0 = page_btn_test_margin_boxes{1};

save('page_nb_elements_test.mat','page_nb_elements_test');
save('page_nb_elements_type_test.mat','page_nb_elements_type_test');
