
td_test_color = []; % x vector

% page_BTNs = importdata('page_BTNs.mat');
page_mbox_color_test = importdata('page_mbox_color_test.mat');
page_color_Nhist_test = importdata('page_color_Nhist_test.mat');
page_color_Nindexes_test = importdata('page_color_Nindexes_test.mat');


for i  = 1 : length(page_mbox_color_test)
    BTNs = [page_BTN_test_x{i} , page_BTN_test_y{i} , page_BTN_test_w{i}, page_BTN_test_h{i}];
    
    mbox_colors = page_mbox_color_test{i};
    
    a1 = page_color_Nhist_test{i}';
    a2 = page_color_Nindexes_test{i};
    a2 = a2(:)';
    tmp_td = [];
    for j = 1 : size(BTNs,1)
        tmp_td = [a2];        
        BTN = BTNs(j,:);        
        mbox_color = mbox_colors(j,:); mbox_color = [];
        tmp_td = [tmp_td mbox_color];
        td_test_color = [td_test_color; tmp_td];
    end 
        
end

% save('td_test_color.mat','td_test_color');
% save('td_test_color_y.mat','td_test_color_y');