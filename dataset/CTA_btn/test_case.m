
clc; clear;
warning off;

%% test_input_data
test_input_data

% plot the image
test_page_ind = 3;

%%
plot_the_image

%%
% read_masks_mboxes_test
read_masks_mboxes_test   

%% get the training data about the alignment x(horizontal) type
user_input_textline_alignment_x_type_test

%% get the training data about the alignment y(vertical) type
% user_input_textline_alignment_y_type_test


%%
% get_mbox_neighbour
get_mbox_neighbour_test

% imcontour get page_mboxes_DT
% get_page_mboxes_DT_test





%%
test_page_ind = 1;
figure(4), 

% imshow(ones(size(page_elements_masks_test{3})) )
hold on,
imshow(page_imgs_test{test_page_ind}),
tmp = page_nb_elements_test{test_page_ind};
tmp = tmp(7,:);
plot_multi_boxes(page_btn_test_margin_boxes{test_page_ind}),
plot_multi_boxes([tmp(5:8); tmp(13:16)]),

hold off;


%% select btns
select_btns



%% wuliao
% figure(4),imshow(img),plot_multi_boxes(plbox1)
ind = 1;
figure(4),imshow(page_imgs_test{ind}),plot_multi_boxes(page_btn_test_candidata_mbox{ind})
page_score_v{1}
% imshow(ones(size(page_elements_masks_test{1})) )
%% get_mbox_neighbour
page_btn_test_margin_boxes = page_btn_test_candidata_mbox;
get_mbox_neighbour_test
get_mbox_top_text_alignment_type
% imcontour get page_mboxes_DT
% get_page_mboxes_DT_test 

%% stage 2 size and position
stage_2_size_and_position

%%
get_BTNs_colors
get_xBtn_colors_test
get_images
get_mbox_color
get_images_test
get_mbox_color_test



%%
get_td_color
get_td_color_test
%%
% test_CR = my_gpml_reg_c(td_train_color,td_train_color_y(:,1),td_test_color,...
%     [ones(size(td_train_color(1,:))) .* 3 1] ...
%     ,  [zeros(size(td_train_color(1,:))) 1]');
% test_CG = my_gpml_reg_c(td_train_color,td_train_color_y(:,2),td_test_color,...
%     [ones(size(td_train_color(1,:))) .* 3 1] ...
%     ,  [zeros(size(td_train_color(1,:))) 1]');
% test_CB = my_gpml_reg_c(td_train_color,td_train_color_y(:,3),td_test_color,...
%     [ones(size(td_train_color(1,:))) .* 3 1] ...
%     ,  [zeros(size(td_train_color(1,:))) 1]');
td_train_color_y_hsv = rgb2hsv(td_train_color_y) ;
td_train_color_y_lab = rgb2lab(td_train_color_y) ;

% test_CH = my_GPR(td_train_color,td_train_color_y_hsv(:,1),td_test_color);
% test_CS = my_GPR(td_train_color,td_train_color_y_hsv(:,2),td_test_color);
% test_CV = my_GPR(td_train_color,td_train_color_y_hsv(:,3),td_test_color);
% 
% test_CR = my_GPR(td_train_color,td_train_color_y(:,1),td_test_color);
% test_CG = my_GPR(td_train_color,td_train_color_y(:,2),td_test_color);
% test_CB = my_GPR(td_train_color,td_train_color_y(:,3),td_test_color);

test_CL = my_GPR(td_train_color,td_train_color_y_lab(:,1),td_test_color);
test_CA = my_GPR(td_train_color,td_train_color_y_lab(:,2),td_test_color);
test_CB = my_GPR(td_train_color,td_train_color_y_lab(:,3),td_test_color);

%% filter color data
% test_CH(find(test_CH < 0)) = 0; test_CH(find(test_CH > 1)) = 1; 
% test_CS(find(test_CS < 0)) = 0; test_CS(find(test_CS > 1)) = 1; 
% test_CV(find(test_CV < 0)) = 0; test_CV(find(test_CV > 1)) = 1; 

% test_CR(find(test_CR < 0)) = 0; test_CR(find(test_CR > 1)) = 1; 
% test_CG(find(test_CG < 0)) = 0; test_CG(find(test_CG > 1)) = 1; 
% test_CB(find(test_CB < 0)) = 0; test_CB(find(test_CB > 1)) = 1; 


% test_color_hsv = [test_CH test_CS test_CV];
test_color_lab = [test_CL test_CA test_CB];
% test_color_rgb = hsv2rgb(test_color_hsv);
test_color_rgb = lab2rgb(test_color_lab);
%% convert rgb to hsv color model
% lab_gt = applycform(td_train_color_y, colorTransform);
% lab_test = applycform(test_color, colorTransform);

%%
acc_ind = 1;
page_BTN_test_color = [];
for i = 1 : length(page_split_start_ind)    
    page_BTN_test_color{i} = [test_color_rgb(acc_ind : acc_ind + page_split_start_ind(i) - 1, :)];
    tmp = page_BTN_test_color{i};
    tmp_rs = [];
    for j = 1 : size(tmp,1)
        each_test_color = tmp(j,:);
        m = repmat(each_test_color,size(td_train_color_y,1),1);
        
        t =  sqrt(sum(abs(m - td_train_color_y).^2,2));
        [~,I] = min(t );       
        c = td_train_color_y(I,:);
        tmp_rs = [tmp_rs ; c];
    end
    page_BTN_test_color{i} = tmp_rs;

    acc_ind = acc_ind + page_split_start_ind(i);
end



%%
%%
r = [220:220];
ind = 1;

% handle_x_offset_by_alignment_type
% handle_y_offset_by_alignment_type

plbtn1 = page_btn_test_margin_boxes{ind};
pboxes0 = [page_BTN_test_x{ind} , page_BTN_test_y{ind} , page_BTN_test_w{ind}, page_BTN_test_h{ind}]; %+BTNs_dx_test  +BTNs_dy_test
pboxes0_color = [page_BTN_test_color{ind}];
% pboxes0 = [plbtn1(:,1) , plbtn1(:,2) , page_BTN_test_w{ind}, page_BTN_test_h{ind}]; %+BTNs_dx_test  +BTNs_dy_test
%

pboxes = pboxes0;     
pboxes_color = pboxes0_color;
for i = size(pboxes,1):-1:1    
    if pboxes(i,1) < 0 ||  pboxes(i,2) < 0 || pboxes(i,3) < 0 || pboxes(i,4) < 0
        pboxes(i,:) = [];
        pboxes_color(i,:) = [];
    end
end


% 
figure(10),clf,hold on,axis ij,
imshow(page_imgs_test{ind});
% plot_label_result 
plot_multi_boxes([pboxes(:,:)],'r',pboxes_color);
% plot_multi_boxes(plbtn1(:,:),'b');
nb_elements = page_nb_elements_test{ind};
% plot_multi_boxes(nb_elements);
hold off;
% page_fd_alignment_test{ind}
% page_fd_alignment_y_test{ind}

% [[1 : size(page_btn_alignment_y_test{ind},1)]'  page_btn_alignment_test{ind}]
% page_score_v{i}
% pages_alignment_score;
% [[1 : size(page_btn_alignment_y_test{ind},1)]'  page_btn_alignment_y_test{ind}]
% plot_multi_boxes(plbtn1(:,:));
% plot_multi_boxes(plbox1(:,:));







%% wuliao
% figure(4),imshow(img),plot_multi_boxes(plbox1)
clc; ind = 6;
figure(4),imshow(page_imgs_test{ind}),plot_multi_boxes(page_btn_test_candidata_mbox{ind})
page_btn_alignment_test{ind}
















%%















