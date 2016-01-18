
page_textline_alignment_x_type_test = [];
acc_textline_alignment_x_type_test = [];

for i = 1 : length(page_imgs_test)
    elements = page_elements_test{i};
    img = page_imgs_test{i};               
    elements_types = page_elements_type_test{i};
    acc_rs = [];
    atbs = {D(i).annotation.object.attributes};
    for j = 1 : size(elements,1) 
        tmp = 0;
        if ismember('center', cell2mat(atbs(j)))
            tmp = 1;
        end
        acc_rs = [acc_rs; tmp];
    end
    page_textline_alignment_x_type_test{i} = acc_rs; 
    acc_textline_alignment_x_type_test = [acc_textline_alignment_x_type_test; acc_rs];
end

%%

%%
return;

page_elements_types_test = importdata('page_elements_type_test.mat');
page_elements_test = importdata('page_elements_test.mat');

page_textline_alignment_x_type_test = importdata('page_textline_alignment_x_type_test.mat');
acc_textline_alignment_x_type_test = [];
acc_textline_alignment_x_type_test = importdata('acc_textline_alignment_x_type_test.mat');

return;
%%
% page_top_textline_alignment_x_type_test = [];

% 1 - 3 : top; 4 - 6 : bottom : 7 - 9 : mbox; 0 : unchanged

acci = 0;
for i = 1 : 6%length(page_elements_test)
    i
    elements = page_elements_test{i};
    img = page_imgs_test{i};               
    elements_types = page_elements_types_test{i};

    acc_rs = [];
    record = page_textline_alignment_x_type_test{i};
%     acc_rs = page_textline_alignment_x_type_test{i};
    
    for j = 1 : size(elements,1) 
        j
        acci = acci + 1
        element = elements(j,:);
        figure(1),clf,
        imshow(img);
        plot_multi_boxes([element]);
        
%         tmp = record(j);
        tmp = 0;
        
        if elements_types(j) == 3
            tmp = input('1 - 3(left center right alignment):');
%             tmp = [];
        end

        acc_rs = [acc_rs; tmp];        
        
    end
    page_textline_alignment_x_type_test{i} = acc_rs; 
    acc_textline_alignment_x_type_test = [acc_textline_alignment_x_type_test; acc_rs];

end
%%
return;
save('acc_textline_alignment_x_type_test.mat','acc_textline_alignment_x_type_test');
save('page_textline_alignment_x_type_test.mat','page_textline_alignment_x_type_test');