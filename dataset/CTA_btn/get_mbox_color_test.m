% page_mbox_color_test = importdata('page_mbox_color_test.mat');
% 
% return;
page_mbox_color_test = [];

for i = 1 : length(page_btn_test_margin_boxes)
    mboxes = page_btn_test_margin_boxes{i};
    img = page_imgs_test{i};
%     figure(1),hold on, imshow(img),
%     plot_multi_boxes(mboxes); hold off;
    mbox_colors = [];
    for j = 1 : size(mboxes,1)
        mbox = mboxes(j,:);
        expand_width = 100;
%         mbox1 = [mbox(1) - expand_width; mbox(2) - expand_width; 
        
        mbox_mask = img(mbox(2) : mbox(2) + mbox(4) - 1 , mbox(1) : mbox(1) + mbox(3) - 1 , : );
        [IND,colormap] = rgb2ind(mbox_mask,1);
        pmask = ones(size(mbox_mask,1),size(mbox_mask,2),3);
        mbox_colors = [mbox_colors; colormap];
        
%         pmask(:,:,1) = colormap(1);
%         pmask(:,:,2) = colormap(2);
%         pmask(:,:,3) = colormap(3);
%         figure(12),imshow(pmask);
%         return;
%         figure(11),imshow(img);
%         figure(10),clf,imshow(mbox_mask);
%         input('d');
    end
    page_mbox_color_test{i} = mbox_colors;
%     return;
end

save('page_mbox_color_test.mat','page_mbox_color_test');