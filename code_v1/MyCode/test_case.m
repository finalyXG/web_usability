clc; clear;
warning off;
%%

HOMEANNOTATIONS = '../collection/Annotations/users/finalyXL/web_btn_images/'; %
HOMEIMAGES = '../collection/Images/users/finalyXL/web_btn_images/'; %
if ~exist('D','var')
    D = LMdatabase(HOMEANNOTATIONS);
end

HOMEANNOTATIONS = '../collection/Annotations'; %
HOMEIMAGES = '../collection/Images'; %

[tmp dj] = LMquery(D,'object.name','button');
D = D(dj);
% LMdbshowscenes(D, HOMEIMAGES);
%%
[a,img] = LMread(D,3,HOMEIMAGES);
LMplot(D, 19, HOMEIMAGES);


%% test_input_data
% test_input_data

% plot the image
test_page_ind = 3;

%%
% read_masks_mboxes_test
read_masks_mboxes_test   

%% get the training data about the alignment x(horizontal) type
user_input_textline_alignment_x_type_test

save('page_textline_alignment_x_type_test.mat','page_textline_alignment_x_type_test');
save('acc_textline_alignment_x_type_test.mat','acc_textline_alignment_x_type_test');

%% get the training data about the alignment y(vertical) type
% user_input_textline_alignment_y_type_test


%%
% get_mbox_neighbour
get_mbox_neighbour_test

% imcontour get page_mboxes_DT
% get_page_mboxes_DT_test


%% select btns
select_btns



%% wuliao
% figure(4),imshow(img),plot_multi_boxes(plbox1)
ind = 3;
figure(4),imshow(page_imgs_test{ind}),plot_multi_boxes(page_btn_test_candidata_mbox{ind})
% figure(4),imshow(page_imgs_test{ind}),plot_multi_boxes(page_btn_test_margin_boxes{ind})
s = page_score_v{ind}
% s([21,17,3,29])
% imshow(ones(size(page_elements_masks_test{1})) )
%% get_mbox_neighbour
page_btn_test_margin_boxes = page_btn_test_candidata_mbox;




get_mbox_neighbour_test

get_mbox_top_train_alignment_type
get_mbox_top_text_alignment_type

% imcontour get page_mboxes_DT
% get_page_mboxes_DT_test 

%% stage 2 size and position
stage_2_size_and_position 

%% get global color theme score
tic
get_global_color_theme_score
toc
%% get local color theme score
get_local_color_theme_score

%%
% td
fit = importdata('color_fit.mat');
testingPredictions = glmnetPredict(fit, 'response', datapoints.features(:,:));
global_score = testingPredictions;
% [allFeatures featureNames numThemes rgbs labs]= createFeaturesFromData(data,1);


%%
for i = 1 : 199
    a = data(i,1:5,:);
    rgb = [a(:,:,1)' a(:,:,2)' a(:,:,3)'];
    figure(1),imagesc([1,5],[1,1],[1:5]);
    colormap(rgb);
    input('d');
end


%% try saliency & color theme extraction



%%
r = [220:220];
for i = 1 : length(page_imgs_test)
ind = i

% handle_x_offset_by_alignment_type
% andle_y_offset_by_alignment_type

plbtn1 = page_btn_test_margin_boxes{ind};
pboxes0 = [page_BTN_test_x{ind} , page_BTN_test_y{ind} , page_BTN_test_w{ind}, page_BTN_test_h{ind}]; %+BTNs_dx_test  +BTNs_dy_test
% pboxes0_color = [page_BTN_test_color{ind}];
% pboxes0 = [plbtn1(:,1) , plbtn1(:,2) , page_BTN_test_w{ind}, page_BTN_test_h{ind}]; %+BTNs_dx_test  +BTNs_dy_test
%

pboxes = pboxes0;     
% pboxes_color = pboxes0_color;
for i = size(pboxes,1):-1:1    
    if pboxes(i,1) < 0 ||  pboxes(i,2) < 0 || pboxes(i,3) < 0 || pboxes(i,4) < 0
        pboxes(i,:) = [];
%         pboxes_color(i,:) = [];
    end
end


% 
figure(10),clf,hold on,axis ij,
imshow(page_imgs_test{ind});
% plot_label_result 
% plot_multi_boxes([pboxes(:,:)],'r',pboxes_color);
plot_multi_boxes([pboxes(:,:)],'r');
plot_multi_boxes(plbtn1(:,:),'b');
nb_elements = page_nb_elements_test{ind};
% plot_multi_boxes(nb_elements);
hold off;
% page_fd_alignment_test{ind}
% page_fd_alignment_test{ind}

[[1 : size(page_btn_alignment_test{ind},1)]'  page_btn_alignment_test{ind}]
[[1 : size(page_btn_alignment_y_test{ind},1)]'  page_btn_alignment_y_test{ind}]
% page_score_v{i}
% pages_alignment_score;
% [[1 : size(page_btn_alignment_y_test{ind},1)]'  page_btn_alignment_y_test{ind}]
% plot_multi_boxes(plbtn1(:,:));
% plot_multi_boxes(plbox1(:,:));

input('dump');
end
  


%% wuliao
% figure(4),imshow(img),plot_multi_boxes(plbox1)
clc; ind = 6;
figure(4),imshow(page_imgs_test{ind}),plot_multi_boxes(page_btn_test_candidata_mbox{ind})
page_btn_alignment_test{ind}













































































































































































































































































%%


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














