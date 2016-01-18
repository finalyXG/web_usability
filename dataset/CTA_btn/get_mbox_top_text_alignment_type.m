
acc_textline_alignment_x_type_test = importdata('acc_textline_alignment_x_type_test.mat');
page_textline_alignment_x_type_test = importdata('page_textline_alignment_x_type_test.mat');

acc_ind = 0;
page_nb_top_textline_alignment_x_type_test = [];
page_split_start_ind = cellfun(@(x) size(x,1) ,page_nb_elements_test);

for i = 1 : length(page_nb_elements_test)
    elements = page_elements_test{i};
    elements_types = page_elements_type_test{i};
    nb_elements = page_nb_elements_test{i};
    mboxes = page_btn_test_margin_boxes{i};
    nb_elements_types = page_nb_elements_type_test{i};
    textline_alignment_x_type_test = page_textline_alignment_x_type_test{i};
    tmp_rs = [];
    for j = 1 : size(nb_elements,1)

        tmp = 0;
        for k = 1 : size(elements,1)
            if nb_elements(j,5) == elements(k,1) && nb_elements(j,6) == elements(k,2)
                tmp = textline_alignment_x_type_test(k);
                break;
            end
        end
        tmp_rs = [tmp_rs; tmp];        
    end      

    page_nb_top_textline_alignment_x_type_test{i} = tmp_rs;
%     figure(1),hold on,clf,
%     imshow(page_imgs_test{i});
%     page_elements_types_test
%     plot_multi_boxes([mboxes]);
%     plot_multi_boxes(nb_elements(:,5:8));
%     tmp_rs
%     input('dump');

end