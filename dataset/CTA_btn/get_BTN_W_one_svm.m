clc
data = [fd_btn_BTN_w_train];

x0 = data;
x1 = x0 * 1.1; 
x2 = x0 * 0.9; 
x = [x0;];
x = [x repmat(acc_BTNs(:,3),1,1)];
y = ones(size(x,1),1); 
% rx = randi([-3 5],size(x) );



datatest = [data(1,:) * 1.0];
wtest = [100:2:800]';
xtest = [repmat(datatest,size(wtest)) wtest];

% return;
SVMModel = fitcsvm(x,y,'KernelScale','auto','Standardize',true,'OutlierFraction',0.001,'Nu',0.9);
[~,score] = predict(SVMModel,xtest);

[mv mind] = max(score);
score(mind)
wtest(mind)
% mind

% ind = find(score > 0);
% size(ind)