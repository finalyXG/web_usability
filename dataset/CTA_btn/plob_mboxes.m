file_names = button_label_file_names;
for i = tid : length(page_btn_train_margin_boxes)
    i
    file_name = cell2mat(file_names(i));
    img = imread(file_name);
    mbox = page_btn_train_margin_boxes{i};
    BTNs = page_BTNs{i};
    nb_box = page_nb_elements{i};
    
    for j = 1 : size(BTNs,1)
        figure(5),clf,hold on
        imshow(img);
        plot_multi_boxes([mbox(j,:)]); 
        plot_multi_boxes([BTNs(j,:)]); 
        plot_multi_boxes([nb_box(j,1:4);nb_box(j,5:8);nb_box(j,9:12);nb_box(j,13:16)]);
        input('dump');
    end
    
%     plot_multi_boxes([page_elements_train{i}]);
    

    
%     hold off;
    
%     return;
end