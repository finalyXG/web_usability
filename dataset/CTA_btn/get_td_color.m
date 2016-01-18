
td_train_color = []; % x vector
td_train_color_y = []; % y prediction value
page_BTNs = importdata('page_BTNs.mat');
page_BTNs_colors = importdata('page_BTNs_colors.mat');
page_mbox_color = importdata('page_mbox_color.mat');
page_color_Nhist = importdata('page_color_Nhist.mat');
page_color_Nindexes = importdata('page_color_Nindexes.mat');


for i  = 1 : length(page_BTNs_colors)
    BTNs = page_BTNs{i};
    BTNs_colors = page_BTNs_colors{i};
    mbox_colors = page_mbox_color{i};
    
    a1 = page_color_Nhist{i}';
    a2 = page_color_Nindexes{i};
    a2 = a2(:)';
    tmp_td = [];
    for j = 1 : size(BTNs,1)
        tmp_td = [a2];        
%         tmp_td = [a1 a2];        
        BTN = BTNs(j,:);        
        BTN_color = BTNs_colors(j,:);
        mbox_color = mbox_colors(j,:); mbox_color = [];
        tmp_td = [tmp_td mbox_color ]; 
        td_train_color = [td_train_color; tmp_td];
        td_train_color_y = [td_train_color_y; BTN_color];
    end
        
end

% save('td_train_color.mat','td_train_color');
% save('td_train_color_y.mat','td_train_color_y');