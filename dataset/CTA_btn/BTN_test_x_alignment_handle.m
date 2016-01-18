page_BTN_test_w = [];
page_BTN_test_h = [];
acc_ind = 1;
alignment_x_rs = importdata('acc_alignment_x_type.mat');
page_alignment_x_type_train = importdata('page_alignment_x_type.mat');



for i = 1 : length(page_split_start_ind)    
    page_BTN_test_w{i} = BTN_w_test(acc_ind : acc_ind + page_split_start_ind(i) - 1);
    page_BTN_test_h{i} = BTN_h_test(acc_ind : acc_ind + page_split_start_ind(i) - 1);      
    acc_ind = acc_ind + page_split_start_ind(i);
end

fd_alignment_train_proc
fd_alignment_test_proc
% alignment_kmeans
% return;


%% TreeBagger
mclasses = alignment_x_rs;
mclasses_labels = [];
for i = 1 : length(mclasses)
    mclasses_labels{i} = mat2str(mclasses(i));
end
ind1 = find(acc_top_exist_train == 1);
ind0 = find(acc_top_exist_train == 0);
BaggedEnsemble1 = TreeBagger(100,fd_alignment_train(ind1,:),mclasses_labels(ind1),'OOBPred','On','MinLeafSize',1,'CategoricalPredictors',[1:10]);
oobErrorBaggedEnsemble1 = oobError(BaggedEnsemble1);

BaggedEnsemble0 = TreeBagger(60,fd_alignment_train(ind0,:),mclasses_labels(ind0),'OOBPred','On','MinLeafSize',1,'CategoricalPredictors',[1:10]);
oobErrorBaggedEnsemble0 = oobError(BaggedEnsemble0);

% plot(oobErrorBaggedEnsemble1)
% plot(oobErrorBaggedEnsemble0)
% xlabel 'Number of grown trees';
% ylabel 'Out-of-bag classification error of x alignment';

%% predicting stage
page_fd_alignment_test = [];
pages_alignment_score = [];
page_btn_alignment_test = [];
acc_ind = 1;

for i = 1 : length(page_split_start_ind)
    tmp_acc_top_exist = acc_top_exist_test(acc_ind : acc_ind + page_split_start_ind(i) - 1 , :);        
    fd_alignment_test_one = fd_alignment_test(acc_ind : acc_ind + page_split_start_ind(i) - 1 , : );              
    page_fd_alignment_test{i} = fd_alignment_test_one; 
    page_btn_alignment_test{i} = [];
%     pages_alignment_score{i} = -inf .* ones(length(tmp_acc_top_exist),9);
    for j = 1 : length(tmp_acc_top_exist)
        if tmp_acc_top_exist(j) == 0
            [Y,scores] = predict(BaggedEnsemble0, fd_alignment_test_one(j,:));
            
        else
            [Y,scores] = predict(BaggedEnsemble1, fd_alignment_test_one(j,:));            
        end        
        page_btn_alignment_test{i} = [page_btn_alignment_test{i}; cell2mat(Y)];
%         pages_alignment_score{i} = [pages_alignment_score{i}; scores];
    end
    
    page_btn_alignment_test{i} = str2num(page_btn_alignment_test{i});
    acc_ind = acc_ind + page_split_start_ind(i);
end

%% learning the shift-offset for the x-left, x-right, y-top, y-bottom, y-center
alignment_x_model_data_train = []; alignment_x_model_rs_train = [];
alignment_x_model_data_train{7} = []; alignment_x_model_rs_train{7} = [];
alignment_x_model_data_train{9} = []; alignment_x_model_rs_train{9} = [];

for i = 1 : length(page_alignment_x_type_train)
    alignment_x_types = page_alignment_x_type_train{i};
    mboxes = page_btn_train_margin_boxes{i};
    nb_elements = page_nb_elements_train{i};
    oBTNs = page_BTNs{i};
    for j = 1 : size(alignment_x_types,1)
        BTN = [];
        for k = 1 : size(oBTNs,1)
            if rectint(oBTNs(k,:),mboxes(j,:)) == oBTNs(k,3) * oBTNs(k,4)
                BTN = oBTNs(k,:);
                break;
            end
        end
        t = alignment_x_types(j,:); 
        nd = [];
        ns = [];
        switch t
            case 7
                nd = [ mboxes(j,3:4) BTN(3:4) nb_elements(j,3:4)];            
                ns = [ abs(BTN(1) - mboxes(j,1))];
            case 9                
                nd = [ mboxes(j,3:4) BTN(3:4) nb_elements(j,11:12)];
                ns = [ abs(BTN(1) + BTN(3) - mboxes(j,1) - mboxes(j,3))];
        end
        if ~isempty(nd)
            alignment_x_model_data_train{t} = [alignment_x_model_data_train{t} ;nd];
            alignment_x_model_rs_train{t} = [alignment_x_model_rs_train{t}; ns];
        end
    end
end


% my_GPR
%%

%% Gaussian Process Regression
Gaussian_Process_Regression_on_off = 1;
page_btn_dx = [];
if Gaussian_Process_Regression_on_off == 1
    for i = 1 : length(page_btn_alignment_test)
        page_btn_dx{i} = [];
        BTN_test_alignment_tyges = page_btn_alignment_test{i};
        mboxes = page_btn_test_margin_boxes{i};
        nb_elements = page_nb_elements_test{i};
        BTNs = [mboxes(:,1) mboxes(:,2) page_BTN_test_w{i} page_BTN_test_h{i}];
        for j = 1 : size(BTN_test_alignment_tyges,1)
            BTN = BTNs(j,:);
            t = BTN_test_alignment_tyges(j,:);
            nd = [];
            switch t
                case 7
                    nd = [ mboxes(j,3:4) BTN(3:4) nb_elements(j,3:4)];            
                    ns = [ abs(BTN(1) - mboxes(j,1))];
                case 9                
                    nd = [ mboxes(j,3:4) BTN(3:4) nb_elements(j,11:12)];
                    ns = [ abs(BTN(1) + BTN(3) - mboxes(j,1) - mboxes(j,3))];
            end
            tmp = 0;
            if ~isempty(nd)
                tmp = my_GPR(alignment_x_model_data_train{t},alignment_x_model_rs_train{t},nd);
            end
            page_btn_dx{i} = [page_btn_dx{i} ;tmp];
        end
    end
%     end
end
%% TreeBagger method and it's test parameters
TreeBagger_on_off = 0;
if TreeBagger_on_off == 1
    leaf = [5 7 10 20 50];
    col = 'rbcmy';
    figure(1),
    for i=1:length(leaf)
        B = TreeBagger(500,alignment_x_model_data_train{7},alignment_x_model_rs_train{7},'method',...
            'regression','OOBPred','On','MinLeaf',leaf(i));
        plot(oobError(B),col(i));    
        hold on;
    end
    %
    B_shift_dx = cell(1,9);
    ind = 7;
    B_shift_dx{ind} = TreeBagger(100,alignment_x_model_data_train{ind},alignment_x_model_rs_train{ind},'method',...
        'regression','OOBPred','On','MinLeaf',5);
    test_y = [];
    test_y(:,1) = predict(B_shift_dx{ind}, alignment_x_model_data_train{ind});
    test_y(:,2) = alignment_x_model_rs_train{ind};
    
end
%% 

% save('B_shift_dx.mat','B_shift_dx');

%%
return;
length(find(alignment_x_rs == 1))
length(find(alignment_x_rs == 2))
length(find(alignment_x_rs == 3))
length(find(alignment_x_rs == 4))
length(find(alignment_x_rs == 5))
length(find(alignment_x_rs == 6))
length(find(alignment_x_rs == 7))
length(find(alignment_x_rs == 8))
length(find(alignment_x_rs == 9))
return;