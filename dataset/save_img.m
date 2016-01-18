clc; clear;

data_dir = 'data/';
page_names = dir([data_dir '*.mat']);
img_dir = 'images/';
for i = 1:length(page_names)
    page = importdata([data_dir '/' page_names(i).name]);
    
    tmp_I = page.I;
    tmp_name = ['image' num2str(i)];
%     imshow(tmp_I);
    imwrite(tmp_I, [img_dir tmp_name '.jpg']);
    
end

