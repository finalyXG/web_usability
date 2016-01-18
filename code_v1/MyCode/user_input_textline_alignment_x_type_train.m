page_imgs_train = importdata('page_imgs.mat');
page_elements_train = importdata('page_elements_train.mat');
page_elements_type_train = importdata('page_elements_type_train.mat');

page_textline_alignment_x_type_train = [];
acc_textline_alignment_x_type_train = [];

for i = 1 : length(page_imgs_train)
    elements = page_elements_train{i};
    img = page_imgs_train{i};               
    elements_types = page_elements_type_train{i};
    acc_rs = [];
    atbs = {D(i).annotation.object.attributes};
    for j = 1 : size(elements,1) 
        tmp = 0;
        if ismember('center', cell2mat(atbs(j)))
            tmp = 1;
        end
        acc_rs = [acc_rs; tmp];
    end
    page_textline_alignment_x_type_train{i} = acc_rs; 
    acc_textline_alignment_x_type_train = [acc_textline_alignment_x_type_train; acc_rs];
end
