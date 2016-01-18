page_BTNs_colors = importdata('page_BTNs_colors.mat');
page_imgs_xBTNs = importdata('page_imgs_xBTNs.mat');
return;

page_BTNs_colors = [];
page_imgs_xBTNs = [];
nBars = 6;
for i = 1 : length(page_BTNs)
    img = page_imgs{i};
    img_dump = img;
    BTNs = page_BTNs{i};
    BTN_colors = [];
    
    for j = 1 : size(BTNs,1)
        BTN = BTNs(j,:);
        BTN_mask = img(BTN(2) + 2: BTN(2) + BTN(4) - 2, BTN(1) + 2 : BTN(1) + BTN(3) - 2 , : );

        ofs = 4;
        BTN_border_colors1 = img_dump(BTN(2):BTN(2) + BTN(4) , BTN(1) + BTN(3)+ofs, :);
        BTN_border_colors2 = img_dump(BTN(2) - ofs  , BTN(1)-ofs : BTN(1) + BTN(3)+ofs, :);
        BTN_border_colors3 = img_dump(BTN(2) - ofs : BTN(2) + BTN(4) + ofs , BTN(1) - ofs, :);
        BTN_border_colors4 = img_dump(BTN(2) + BTN(4)+ ofs , BTN(1)-ofs : BTN(1) + BTN(3)+ofs, :);
            
        BTN_border_colors_mean = mean([mean(BTN_border_colors1); mean(BTN_border_colors2); mean(BTN_border_colors3); mean(BTN_border_colors4)]);
        img_dump(BTN(2) - 4: BTN(2) + BTN(4) + 4, BTN(1) - 4 : BTN(1) + BTN(3) + 4, 1 ) = BTN_border_colors_mean(1,1,1);
        img_dump(BTN(2) - 4: BTN(2) + BTN(4) + 4, BTN(1) - 4 : BTN(1) + BTN(3) + 4, 2 ) = BTN_border_colors_mean(1,1,2);
        img_dump(BTN(2) - 4: BTN(2) + BTN(4) + 4, BTN(1) - 4 : BTN(1) + BTN(3) + 4, 3 ) = BTN_border_colors_mean(1,1,3);
        
        [X,RGBmap] = rgb2ind(BTN_mask,nBars);
        [counts,binLocations] = imhist(X,RGBmap);
        [maxv,maxi] = max(counts);

        BTN_color = RGBmap(maxi,:);
        ms = size(BTN_mask);
        BTN_mask1 = zeros(ms(1),ms(2),ms(3)) ;
        for k1 = 1 : ms(1)
            for k2 = 1 : ms(2)
                BTN_mask1(k1,k2,:) = BTN_color;
            end
        end
        
        BTN_colors = [BTN_colors; BTN_color];
%         figure(1),imhist(X,RGBmap);
%         figure(2),imshow(BTN_mask1);
%         figure(3),imshow(BTN_mask);
%         input('d');
%         return;
        
    end
    
    page_BTNs_colors{i} = BTN_colors;
    page_imgs_xBTNs{i} = img_dump;
%     figure(10),imshow(page_imgs_xBTNs{i});
%     input('d');
end


save('page_BTNs_colors.mat','page_BTNs_colors');
save('page_imgs_xBTNs.mat','page_imgs_xBTNs');








