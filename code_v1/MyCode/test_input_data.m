text_label = load('label_test_text_11_4.mat');
% text_label = text_label.tmp;
img_label = load('label_test_img_11_4.mat');
input_label = load('label_test_input_11_4.mat');
bgi_label = load('label_test_bgi_11_4.mat');
border_label = load('label_test_border_11_4.mat');
button_label = load('label_test_button_11_4.mat');


tmp_field = cell2mat(fieldnames(text_label));
files = {text_label.(tmp_field).imageFilename};

[input_label, text_label, img_label, button_label, bgi_label, border_label] = ...
    multiple_access_data_test(input_label, text_label, img_label, button_label, bgi_label, border_label, files);


text_label_file_names = {text_label.imageFilename};
img_label_file_names = {img_label.imageFilename};
input_label_file_names = {input_label.imageFilename};
bgi_label_file_names = {bgi_label.imageFilename};
button_label_file_names = {button_label.imageFilename};
border_label_file_names = {border_label.imageFilename};



%%
% save('label_test_text_11_4.mat','text_label');
% save('label_test_img_11_4.mat','img_label');
% save('label_test_input_11_4.mat','input_label');
% save('label_test_bgi_11_4.mat','bgi_label');
% save('label_test_border_11_4.mat','border_label');
% save('label_test_button_11_4.mat','button_label');

% text_label = load('label_test_text_11_4.mat');
% img_label = load('label_test_img_11_4');
% input_label = load('label_test_input_11_4.mat');
% bgi_label = load('label_test_bgi_11_4.mat');
% border_label = load('label_test_border_11_4.mat');
% button_label = load('label_test_button_11_4.mat');


