clc
x = [0,0;1,0;0 1;1 1;0.5 0;0 0.5;0.5 1;1 0.5];
y = ones(size(x,1),1);
xtest = [x; [-1 0;2 0;0.5 1.1;0.5 1;0.5 0.5;0.9 0;0.5,0.9;0.5,0.5]];
SVMModel = fitcsvm(x,y,'KernelScale','auto','Standardize',true,'OutlierFraction',0);
[~,score] = predict(SVMModel,xtest);
CVSVMModel = crossval(SVMModel);
[~,scorePred] = kfoldPredict(CVSVMModel);
outlierRate = mean(scorePred < 0.00001)
% [xtest score]
