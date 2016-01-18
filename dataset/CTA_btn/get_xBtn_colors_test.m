% page_imgs_xBTNs_test = importdata('page_imgs_xBTNs_test.mat');
% return;
page_imgs_xBTNs_test = [];
nBars = 6; 
for i = 1 : length(page_BTN_test_x)
%     page_BTNs_test = round([page_BTN_test_x{i}  page_BTN_test_y{i} page_BTN_test_w{i} page_BTN_test_h{i}]);
    page_BTNs_test = [page_btn_test_margin_boxes{i}];
    img = page_imgs_test{i};
    img_dump = img;
    BTNs = page_BTNs_test;
    BTN_colors = [];    
    for j = 1 : size(BTNs,1)
        BTN = BTNs(j,:);
        BTN_mask = img(BTN(2) + 2: BTN(2) + BTN(4) - 2, BTN(1) + 2 : BTN(1) + BTN(3) - 2 , : );

        ofs = 1;
%         BTN_border_colors1 = img_dump(BTN(2) : BTN(2) + BTN(4) , BTN(1) + BTN(3)+ofs, :);
%         BTN_border_colors2 = img_dump(BTN(2) - ofs  , BTN(1)-ofs : BTN(1) + BTN(3)+ofs, :);
%         BTN_border_colors3 = img_dump(BTN(2) - ofs : BTN(2) + BTN(4) + ofs , BTN(1) - ofs, :);
%         BTN_border_colors4 = img_dump(BTN(2) + BTN(4)+ ofs , BTN(1)-ofs : BTN(1) + BTN(3)+ofs, :);
        BTN_region_color = img_dump(BTN(2) : BTN(2) + BTN(4) - 1, BTN(1) : BTN(1) + BTN(3) - 1, :);
        
%         BTN_border_colors_mean = mean([mean(BTN_border_colors1); mean(BTN_border_colors2); mean(BTN_border_colors3); mean(BTN_border_colors4)]);
        BTN_border_colors_mean = mean(BTN_region_color);
        
        img_dump(BTN(2) : BTN(2) + BTN(4) , BTN(1) : BTN(1) + BTN(3) , 1 ) = BTN_border_colors_mean(1,1,1);
        img_dump(BTN(2) : BTN(2) + BTN(4) , BTN(1) : BTN(1) + BTN(3) , 2 ) = BTN_border_colors_mean(1,1,2);
        img_dump(BTN(2) : BTN(2) + BTN(4) , BTN(1) : BTN(1) + BTN(3) , 3 ) = BTN_border_colors_mean(1,1,3);

%         [X,RGBmap] = rgb2ind(BTN_mask,nBars);
%         [counts,binLocations] = imhist(X,RGBmap);
%         [maxv,maxi] = max(counts);      
        
    end
    
    page_BTNs_colors{i} = BTN_colors;
    page_imgs_xBTNs_test{i} = img_dump;
    figure(10),imshow(page_imgs_xBTNs_test{i});
    input('d');
end

%%
save('page_imgs_xBTNs_test.mat','page_imgs_xBTNs_test');








