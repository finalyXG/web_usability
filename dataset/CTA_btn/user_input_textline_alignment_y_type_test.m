

page_elements_types_test = importdata('page_elements_type_test.mat');
page_elements_test = importdata('page_elements_test.mat');

page_textline_alignment_y_type_test = [];
% page_textline_alignment_y_type_test = importdata('page_textline_alignment_y_type_test.mat');
acc_textline_alignment_y_type_test = [];
% acc_textline_alignment_y_type_test = importdata('acc_textline_alignment_y_type_test.mat');

return;
%%
% page_top_textline_alignment_x_type_test = [];

 % 1 - 3 : top; 4 - 6 : bottom : 7 - 9 : mbox; 0 : unchanged

acci = 0;
for i = 1 : length(page_elements_test)
    i
    elements = page_elements_test{i};
    img = page_imgs_test{i};               
    elements_types = page_elements_types_test{i};

    acc_rs = [];    
    acc_rs = page_textline_alignment_y_type_test{i};
    
    for j = 1 : size(elements,1) 
        j
        acci = acci + 1
        element = elements(j,:);
        figure(1),clf,
        imshow(img);
        plot_multi_boxes([element]);
        acc_rs(j)
        if elements_types(j) == 3
            tmp = input('1 - 3(left center right alignment):');
%             tmp = [];
        end

        if isempty(tmp)            
            continue;
        else
            acc_rs(j) = tmp;
        end
        


    end
    page_textline_alignment_y_type_test{i} = acc_rs;
    acc_textline_alignment_y_type_test = [acc_top_textline_alignment_x_type_test; acc_rs];

end
%%
save('acc_textline_alignment_y_type_test.mat','acc_textline_alignment_y_type_test');
save('page_textline_alignment_y_type_test.mat','page_textline_alignment_y_type_test');