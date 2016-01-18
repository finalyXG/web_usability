%% train input
text_label = load('label_11_3_text.mat');
img_label = load('label_11_3_img.mat');
input_label = load('label_11_18_input.mat');
button_label = load('label_11_3_button.mat');
% button_label = load('label_11_3_button_block.mat');
BTN_label = load('label_11_3_button.mat');
bgi_label = load('label_11_3_bgi.mat');
border_label = load('label_11_3_border.mat');

tmp_field = cell2mat(fieldnames(button_label));
files = {button_label.(tmp_field).imageFilename};

[input_label, text_label, img_label, button_label,BTN_label, bgi_label, border_label] = ...
    multiple_access_data(input_label, text_label, img_label, button_label,BTN_label,bgi_label, border_label, files);

text_label_file_names = {text_label.imageFilename};
img_label_file_names = {img_label.imageFilename};
input_label_file_names = {input_label.imageFilename};
bgi_label_file_names = {bgi_label.imageFilename};
button_label_file_names = {button_label.imageFilename};
border_label_file_names = {border_label.imageFilename};
BTN_label_file_names = {BTN_label.imageFilename};

btns = get_btns(button_label);
save('btns.mat','btns');
