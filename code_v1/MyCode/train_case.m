
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
%plot the image
test_page_ind = 1 %10


%% read_masks_mboxes
read_masks_mboxes

%% readjust the BTNs in right order to mboxes
get_page_BTNs_in_order


%%
tmp = importdata('page_BTNs.mat');
for i = 1 : length(page_imgs)
    i
%     figure(10),imshow(page_imgs{i});plot_multi_boxes(tmp{i})
    figure(10),imshow(page_imgs{i});plot_multi_boxes(page_btn_train_margin_boxes{i})
    input('d');
end


%% freq_staffs
% freq_staffs

% get_mbox_neighbour
clc
get_mbox_neighbour  
save('page_nb_elements_train.mat','page_nb_elements');
save('page_nb_elements_type_train.mat','page_nb_elements_type');
%%


%% plot mboxes
tid = 1;
plob_mboxes

%%
fd_btn_BTN_w_train_proc


%% wuliao test mbox
fd_btn_BTN_h_train_proc

%% get the training element's alignment x type
user_input_textline_alignment_x_type

%% get the training data about the alignment x type
user_input_alignment_x_type

%% get the training data about the alignment y type
user_input_alignment_y_type










%% verify the alignment type training data
page_alignment_x_type = importdata('page_alignment_x_type.mat');
verify_the_alignment_type_training_data
%%
page_imgs_train = importdata('page_imgs.mat');
%%
fd_alignment_train_proc
fd_alignment_train = importdata('fd_alignment_train.mat');
alignment_x_rs = importdata('acc_alignment_x_type.mat');
% hist(alignment_x_rs)
%% calculate euclidean distance of LAB color space
fd_alignment_test_proc
TrainingSet = fd_alignment_train; 
TestSet = fd_alignment_train; 
GroupTrain = alignment_x_rs; 
results = multisvm(TrainingSet, GroupTrain, TestSet); 
disp('multi class problem'); 
disp(results); 
% sum([alignment_x_rs - results])
%%
test_results = results;
verify_the_alignment_type_testing_data

%%
get_td_color
test_CR = my_gpml_reg_c(td_train_color,td_train_color_y(:,1),td_train_color,...
    [ones(size(td_train_color(1,:))) .* 3 1] ...
    ,  [zeros(size(td_train_color(1,:))) 1]');
test_CG = my_gpml_reg_c(td_train_color,td_train_color_y(:,2),td_train_color,...
    [ones(size(td_train_color(1,:))) .* 3 1] ...
    ,  [zeros(size(td_train_color(1,:))) 1]');
test_CB = my_gpml_reg_c(td_train_color,td_train_color_y(:,3),td_train_color,...
    [ones(size(td_train_color(1,:))) .* 3 1] ...
    ,  [zeros(size(td_train_color(1,:))) 1]');

test_color = [test_CR test_CG test_CB];

% lab_gt = applycform(td_train_color_y, colorTransform);
% lab_test = applycform(test_color, colorTransform);


%% plot the buttons to see differences
plot_the_buttons_to_see_differences

%%
clc
for i = 1 : size(si,1)
    acc_ind = si(i);
    get_pind_by_accind;
    img = img_label_file_names{pid};
    figure(1),imshow(img);
    % plot_multi_boxes(page_BTNs{pid})
    pbs = page_BTNs{pid};
    mbox = page_btn_train_margin_boxes{pid};
    mbox = mbox(Bid,:);
    pb = pbs(Bid,:);
    pb(1) = mbox(1) ;%+ dxtest(acc_ind);
    pb(2) = mbox(2) ;%+ dytest(acc_ind);
    
    pb(3) = BTN_w_test(acc_ind);
    pb(4) = BTN_h_test(acc_ind);
    plot_multi_boxes([pb; mbox]);
    pb(3) - acc_BTNs(acc_ind,3);
    input('d');
end

%% plot mboxes
tid = 10;
plob_mboxes



%%





%%















%%








clc
% analysis margin boxes position, width and height
x_y_w_h = get_x_y_w_h(page_elements_masks_train, page_btn_train_margin_boxes); 
xy = x_y_w_h(:,1:2);
wh = x_y_w_h(:,3:4);
ar = x_y_w_h(:,5:6);

MIN_XY = [0,0];
MAX_XY = [1,1];
MIN_WH = [0,0];
MAX_WH = [1.2,1.2];

[bandwidth1,density_1,X1,Y1]=kde2d(xy,2^8,MIN_XY,MAX_XY);
[bandwidth2,density_2,X2,Y2]=kde2d(wh,2^8,MIN_WH,MAX_WH);
density = [];
density.density_1 = density_1;
density.density_2 = density_2;
density.X1 = X1;
density.X2 = X2;
density.Y1 = Y1;
density.Y2 = Y2;


%%

tic
save('freq_4_edge.mat','freq_4_edge');
save('density.mat','density');
save('param.mat','param');

toc

%%
clc
b = {page_btn_train_margin_boxes{2}};
file_len = length(button_label);
file_names = button_label_file_names;
for i = 1 : file_len
    i 
    mbox = page_btn_train_margin_boxes{i};
    file_name = cell2mat(file_names(i));
    img = imread(file_name);
    clf
    figure(1),hold on,
    imshow(img); 
    plot_multi_boxes(mbox);
    hold off;
    d = input('dump');
    
end


%%
tic
save('freq_4_edge.mat','freq_4_edge');
save('density.mat','density');
save('param.mat','param');
% save('pca_coeff.mat','coeff');
% save('density_X.mat','X');
% save('density_Y.mat','Y');
toc
%%
























%%





x = 1:100;
y = sin(x/10)+(x/50).^2;
yn = y + 0.2*randn(1,100);
r=ksr(x,yn);
plot(x,y,'b-',x,yn,'co',r.x,r.f,'r--','linewidth',2)
legend('true','data','regression','location','northwest');
title('Gaussian kernel regression')





%% analysis 1

%length & width
x = acc_btn_boxes(:,3);
y = acc_btn_boxes(:,4);
figure(1),hold on,
xlim([0 500])
ylim([0 500])
scatter(x,y)
hold off;

%% analysis 1
for i = 1 : 4
    minv = min(margin_box_total_nsplit(:,i));
    maxv = max(margin_box_total_nsplit(:,i));
    % h = histogram(margin_box_total_nsplit);
    histcounts(margin_box_total_nsplit(:,i), maxv - minv + 1)
end


%% test 
% n = 1e3;
% p = [0.2,0.3,0.5];
% R = mnrnd(n,p,20)
% pd = fitdist(R,'Multinomial')
a=[20,50,30];
X=[0.2,0.5,0.3];
Y=dirpdf(X,a)

%%
clc
tmp = drchrnd(a,100)






%%
figure(1),imshow(img);
map = ittikochmap(img);
figure(2),imcontour(map.master_map_resized);




%% test pca
clc
a = [1,1;2,2;3,3;4,4];
[coeff,score,latent] = pca(a);



a * coeff(:,1)


cumsum(latent)./sum(latent)
%% test kernel density
clc
data=[randn(500,2);
  randn(500,1)+3.5, randn(500,1);];
% call the routine
[bandwidth,density,X,Y]=kde2d(data);
% plot the data and the density estimate
contour3(X,Y,density,50), hold on
plot(data(:,1),data(:,2),'r.','MarkerSize',5)




