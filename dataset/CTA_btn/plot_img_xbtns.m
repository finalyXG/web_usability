for i = 1 : length(page_imgs_xBTNs)
    i
    figure(1),clf,imshow(page_imgs_xBTNs{i});
    input('dump');
end