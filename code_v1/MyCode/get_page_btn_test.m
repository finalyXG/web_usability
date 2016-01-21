page_BTN_test = [];
for i = 1 : length(page_imgs_test)
    page_BTN_test{i} = [];    
    page_BTN_test{i} = [page_BTN_test{i}; floor([page_BTN_test_x{i} page_BTN_test_y{i}...
        page_BTN_test_w{i} page_BTN_test_h{i}]) ];
    
end