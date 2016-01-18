page_BTN_test_w = [];
page_BTN_test_h = [];
acc_ind = 1;
for i = 1 : length(page_split_start_ind)    
    page_BTN_test_w{i} = BTN_w_test(acc_ind : acc_ind + page_split_start_ind(i) - 1);
    page_BTN_test_h{i} = BTN_h_test(acc_ind : acc_ind + page_split_start_ind(i) - 1);   
    acc_ind = acc_ind + page_split_start_ind(i);
end

fd_alignment_y_train_proc

fd_alignment_y_test_proc

alignment_y_rs = importdata('acc_alignment_y_type.mat');
% return;
% hist(alignment_x_rs);
% return;

% fd_alignment_test = [BTN_w_test, BTN_h_test, fd_alignment_test];
% fd_alignment_test = [acc_mboxes_test(:,3) - BTN_w_test, fd_alignment_test];

%%


%% TreeBagger
mclasses = alignment_y_rs;
mclasses_labels = [];
for i = 1 : length(mclasses)
    mclasses_labels{i} = mat2str(mclasses(i));
end

BaggedEnsemble_y = TreeBagger(70,fd_alignment_y_train,mclasses_labels,'OOBPred','On');

% oobErrorBaggedEnsemble = oobError(BaggedEnsemble_y);
% plot(oobErrorBaggedEnsemble)
% xlabel 'Number of grown trees';
% ylabel 'Out-of-bag classification error';



%%
% page_fd_alignment_y_test = [];
pages_alignment_y_score = [];
page_btn_alignment_y_test = [];
acc_ind = 1;
[Y,scores] = predict(BaggedEnsemble_y, fd_alignment_y_test); 
Y = str2num(cell2mat(Y));

ensembel_names = str2num(cell2mat(BaggedEnsemble_y.ClassNames));


% % % % % specified guideline filter
for i = 1 : length(Y)
    cancel_type = zeros(1,9);
    % rule 1 : 
    if fd_alignment_test(i,1) == 0
        cancel_type([1,2,3]) = 1;
    end
    
    
    if cancel_type ~= 0 
        for j = 1 : length(ensembel_names)
            if cancel_type(ensembel_names(j)) == 1
                scores(i,j) = 0;
            end 
        end
    end
    
end

% after filtering Y, some scores become 0 and the 
% alignment type will be changed
[mxv,mxi] = max(scores,[],2);
Y1 = str2num(cell2mat(BaggedEnsemble_y.ClassNames(mxi)));






% BaggedEnsemble_full.ClassNames
for i = 1 : length(page_split_start_ind)
    page_btn_alignment_y_test{i} = [];
    pages_alignment_y_score{i} = [];
    page_btn_alignment_y_test{i} = Y(acc_ind : acc_ind + page_split_start_ind(i) - 1 , :);
    pages_alignment_y_score{i} = scores(acc_ind : acc_ind + page_split_start_ind(i) - 1 , :);
    acc_ind = acc_ind + page_split_start_ind(i);
end




%%
%% learning the shift-offset for the x-left, x-right, y-top, y-bottom, y-center
alignment_y_model_data_train = []; alignment_y_model_rs_train = [];
alignment_y_model_data_train{7} = []; alignment_y_model_rs_train{7} = [];
alignment_y_model_data_train{9} = []; alignment_y_model_rs_train{9} = [];
page_alignment_y_type_train = importdata('page_alignment_y_type.mat');



for i = 1 : length(page_alignment_y_type_train)
    alignment_y_types = page_alignment_y_type_train{i};
    mboxes = page_btn_train_margin_boxes{i};
    nb_elements = page_nb_elements_train{i};
    oBTNs = page_BTNs{i};
    for j = 1 : size(alignment_y_types,1)
        BTN = [];
        for k = 1 : size(oBTNs,1)
            if rectint(oBTNs(k,:),mboxes(j,:)) == oBTNs(k,3) * oBTNs(k,4)
                BTN = oBTNs(k,:);
                break;
            end
        end
        t = alignment_y_types(j,:); 
        nd = [];
        ns = [];
        switch t
            case 7
                nd = [ mboxes(j,3:4) BTN(3:4) nb_elements(j,3:4)];            
                ns = [ abs(BTN(2) - mboxes(j,2))];
            case 9                
                nd = [ mboxes(j,3:4) BTN(3:4) nb_elements(j,11:12)];
                ns = [ abs(BTN(2) + BTN(4) - mboxes(j,2) - mboxes(j,4))];
        end       
        if ~isempty(nd)
            alignment_y_model_data_train{t} = [alignment_y_model_data_train{t} ;nd];
            alignment_y_model_rs_train{t} = [alignment_y_model_rs_train{t}; ns];
        end
    end
end


% my_GPR
%% Gaussian Process Regression
Gaussian_Process_Regression_on_off = 1;
page_btn_dy = [];
if Gaussian_Process_Regression_on_off == 1
    
%     acc_btn_test_margin_boxes = [];
%     acc_btn_test = [];
%     acc_nb_elements_test = [];
%     for i = 1 : length(page_btn_test_margin_boxes)
%         acc_btn_test_margin_boxes = [acc_btn_test_margin_boxes; page_btn_test_margin_boxes{i}];
%         acc_btn_test = [acc_btn_test ; [page_btn_test_margin_boxes{i}(:,1:2) page_BTN_test_w{i} page_BTN_test_h{i}]];
%         acc_nb_elements_test = [acc_nb_elements_test; page_nb_elements_test{i}];
%     end
    
    nd = [acc_btn_test_margin_boxes(:,3:4) acc_btn_test(:,3:4) acc_nb_elements_test(:,3:4)];
    
    tmp = [];
    tmp{7} = my_GPR(alignment_y_model_data_train{7},alignment_y_model_rs_train{7},nd);
    tmp{9} = my_GPR(alignment_y_model_data_train{9},alignment_y_model_rs_train{9},nd);
    acc_ind = 0;
    for i = 1 : length(page_btn_alignment_y_test)
        page_btn_dy{i} = [];
        BTN_test_alignment_tyges = page_btn_alignment_y_test{i};
        for j = 1 : size(BTN_test_alignment_tyges,1)
            acc_ind = acc_ind + 1;
            t = BTN_test_alignment_tyges(j,:);
            
            tmpv = 0;
            switch t
                case 7
                   tmpv = tmp{t}(acc_ind);                   
                case 9                
                   tmpv = tmp{t}(acc_ind);                   
            end
            page_btn_dy{i} = [page_btn_dy{i} ;tmpv];
            
        end
        
    end
    
    
    
    

    
    %
% % % % % %     for i = 1 : length(page_btn_alignment_y_test)
% % % % % %         page_btn_dy{i} = [];
% % % % % %         BTN_test_alignment_tyges = page_btn_alignment_y_test{i};
% % % % % %         mboxes = page_btn_test_margin_boxes{i};
% % % % % %         nb_elements = page_nb_elements_test{i};
% % % % % %         BTNs = [mboxes(:,1) mboxes(:,2) page_BTN_test_w{i} page_BTN_test_h{i}];
% % % % % %         for j = 1 : size(BTN_test_alignment_tyges,1)
% % % % % %             BTN = BTNs(j,:);
% % % % % %             t = BTN_test_alignment_tyges(j,:);
% % % % % %             nd = [];
% % % % % %             switch t
% % % % % %                 case 7
% % % % % %                     nd = [ mboxes(j,3:4) BTN(3:4) nb_elements(j,3:4)];            
% % % % % %                     ns = [ abs(BTN(1) - mboxes(j,1))];
% % % % % %                 case 9                
% % % % % %                     nd = [ mboxes(j,3:4) BTN(3:4) nb_elements(j,11:12)];
% % % % % %                     ns = [ abs(BTN(1) + BTN(3) - mboxes(j,1) - mboxes(j,3))];
% % % % % %             end
% % % % % %             tmp = 0;
% % % % % %             if ~isempty(nd)
% % % % % %                 tmp = my_GPR(alignment_y_model_data_train{t},alignment_y_model_rs_train{t},nd);
% % % % % %             end
% % % % % %             page_btn_dy{i} = [page_btn_dy{i} ;tmp];
% % % % % %         end
% % % % % %     end
    
end

