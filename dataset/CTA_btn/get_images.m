

page_imgs = importdata('page_imgs.mat');

page_color_Nhist = [];
page_color_Nindexes = [];
if ~exist('page_imgs_xBTNs','var')
    page_imgs_xBTNs = importdata('page_imgs_xBTNs.mat');
end
if ~exist('page_imgs','var')
    page_imgs = importdata('page_imgs.mat');
end
return;
% page_imgs = importdata('page_imgs.mat');
% page_color_Nhist = importdata('page_color_Nhist.mat');
% page_color_Nindexes = importdata('page_color_Nindexes.mat');

for i = 1 : length(page_imgs)
    i
%     img = imread(file_names{i});
    img = page_imgs{i};
%     map = gbvs(img);
%     figure(1),show_imgnmap( img , map );
%     figure(2),imcontour(map.master_map_resized);
%     return;
%     hsvImage = rgb2hsv(img);  
%     nbin = 360;
%     hPlane = nbin.*hsvImage(:,:,1);
%     binEdges = 0:nbin; 

    nBars = 6;
    
    [X,RGBmap] = rgb2ind(img, nBars);
    [counts,ind] = imhist(X,RGBmap);    
    [~, mx_ind] = sort(counts,'descend');    
    
    
%     t_RGB = ind2rgb(X,RGBmap);      
%     figure(1),imhist(X,RGBmap(mx_ind(1:nBars),:))
%     figure(3),imhist(X,RGBmap(:,:))
%     figure(2),
%     imagesc(t_RGB)
%     colormap(RGBmap)
    
%     return;
%     page_imgs{i} = img;
    page_color_Nhist{i} = counts;
    page_color_Nindexes{i} = RGBmap(mx_ind(1:nBars),:);
    
%     return;
end


%%
save('page_color_Nhist.mat','page_color_Nhist');
save('page_color_Nindexes.mat','page_color_Nindexes');
save('page_imgs.mat','page_imgs');


