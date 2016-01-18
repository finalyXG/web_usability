file_len = length(text_label);
file_names = text_label_file_names;

page_color_Nhist_test = [];
page_color_Nindexes_test = [];

if ~exist('page_imgs_test','var')
    page_imgs_test = importdata('page_imgs_test.mat');
end
page_color_Nhist_test = importdata('page_color_Nhist_test.mat');
page_color_Nindexes_test = importdata('page_color_Nindexes_test.mat');

for i = 1 : length(file_names)
    i
    img = page_imgs_test{i};
%     hsvImage = rgb2hsv(img);  
%     nbin = 360; 
%     hPlane = nbin.*hsvImage(:,:,1); 
%     binEdges = 0:nbin; 
    
    nBars = 6;
    [X,RGBmap] = rgb2ind(img,nBars);
    [counts,ind] = imhist(X,RGBmap);
    [~, mx_ind] = sort(counts,'descend');    
    
    %imhist(X,RGBmap)
    
    
    page_imgs_test{i} = img;
    page_color_Nhist_test{i} = counts;
    page_color_Nindexes_test{i} = RGBmap;
   
    
end


%%
% save('page_color_Nhist_test.mat','page_color_Nhist_test');
% save('page_color_Nindexes_test.mat','page_color_Nindexes_test');
% save('page_imgs_test.mat','page_imgs_test');


