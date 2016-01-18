%% one class svm, filiter negative btns
% plbox1 = page_btn_test_margin_boxes{1};
% plbtn1 = round([ plbox1(:,1) + dxtest, plbox1(:,2) + dytest, wtest, htest]);
plbox1 = plbox0;
plbtn1 = plbox1;


% fd_train = importdata('fd.mat');
fd_train_proc_1;
split_inds = []; fd_train_proc_test
% return;
clc
x0 = fd_train;
dx1 = 3 * ones(size(fd_train(1,:)));
dx2 = -3 * ones(size(fd_train(1,:)));
dx1(1:2) = 0.1;
dx2(1:2) = -0.1;

% dx1(3:10) = 5;
% dx2(3:10) = -5;

dx1(4:5) = 0.03;
dx2(4:5) = -0.03;

x1 = x0 + repmat(dx1,size(x0,1),1);
x2 = x0 + repmat(dx2,size(x0,1),1);


x = [x0;x1;x2];
y = ones(size(x,1),1); 
SVMModel = fitcsvm(x,y,'KernelScale','auto','Standardize',true,'OutlierFraction',0.1,'Nu',0.99);
% return;
page_score_v = [];
page_btn_test_candidata_mbox = [];
th_v = 0;
for i = 1 : size(split_inds,1)
    xtest = fd_test(1:split_inds(i),:); 
    tmpboxes = page_btn_test_margin_boxes{i};

    [~,score] = predict(SVMModel,xtest);
    %scale score to 0 1
    score = score ./ max(score);
    
    ind = find(score >= th_v);
    tmpboxes = tmpboxes(ind,:);

    score = score(ind);
    [v ind1] = sort(score);
    tmpboxes = tmpboxes(ind1,:);
    
    for j = size(tmpboxes,1):-1:1
        if tmpboxes(j,1) < 0 || tmpboxes(j,2) < 0 || tmpboxes(j,3) < 0 || tmpboxes(j,4) < 0 
                
            tmpboxes(j,:) = [];
            v(j,:) = [];
        end
    end

    bandwidth = 120;
    [~,~,clustMembsCell] = MeanShiftCluster(tmpboxes(:,[1,2])',bandwidth);
    cind = [];
    for j = 1 : length(clustMembsCell)
        tmpCell = cell2mat(clustMembsCell(j));
        if length(tmpCell) > 0
            tmpv = v( tmpCell );        
            [mv mi] = max(tmpv);
            maxind = tmpCell(mi);        
        else
            maxind = 1;
        end
        cind = [cind; maxind];
    end
    tmpboxes = tmpboxes(cind,:);
    v1 = v(cind,:);
    page_score_v{i} = v1;
    page_btn_test_candidata_mbox{i} = tmpboxes;
    fd_test(1:split_inds(i),:) = [];
    
    size(tmpboxes)
   
end

acc_mboxes_test = [];
for i = 1 : length(page_btn_test_candidata_mbox)
    acc_mboxes_test = [acc_mboxes_test; page_btn_test_candidata_mbox{i}];
end
% rx = randi([-3 5],size(x) );
% save('SVMModel_test.mat','SVMModel');
% SVMModel = importdata('SVMModel_test.mat');


% plbtn1 = plbtn1(ind,:);
% plbox1 = plbox1(ind,:);
% score = score(ind);
% [v ind1] = sort(score);
% plbtn1 = plbtn1(ind1,:);
% plbox1 = plbox1(ind1,:);

% for i = size(plbtn1,1):-1:1
%     if plbtn1(i,1) < 0 || plbtn1(i,2) < 0 || plbtn1(i,3) < 0 || plbtn1(i,4) < 0
%         plbtn1(i,:) = [];
%         plbox1(i,:) = [];
%         v(i,:) = [];
%     end
% end

% cluster based on x,y
% % 


% 
% bandwidth = 120;
% [~,~,clustMembsCell] = MeanShiftCluster(plbtn1(:,[1,2])',bandwidth);
% cind = [];
% for i = 1 : length(clustMembsCell)
%     tmpCell = cell2mat(clustMembsCell(i));
%     if length(tmpCell) > 0
%         tmpv = v( tmpCell );        
%         [mv mi] = max(tmpv);
%         maxind = tmpCell(mi);        
%     else
%         maxind = 1;
%     end
%     cind = [cind; maxind];
% end

% plbtn1 = plbtn1(cind,:);
% plbox1 = plbox1(cind,:);
% v1 = v(cind,:);



% for i = size(plbtn1,1) : -1 : 1
%     for j = size(plbtn1,1): -1 : 1
%         if i == j
%             continue;
%         end
%         tmp = rectint(plbtn1(i,:),plbtn1(j,:));
%         if tmp > 0 && v1(i) < v1(j)
%             plbtn1(i,:) = [];
%             plbox1(i,:) = [];
%             v(i,:) = [];
%             break;
%         end
%     end
% end


% size(plbtn1)







