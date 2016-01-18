function [result,models,page_alignment_score] = multisvm(TrainingSet,GroupTrain,TestSet,c,kt)
%Models a given training set with a corresponding group vector and 
%classifies a given test set using an SVM classifier according to a 
%one vs. all relation. 
%
%This code was written by Cody Neuburger cneuburg@fau.edu
%Florida Atlantic University, Florida USA
%This code was adapted and cleaned from Anand Mishra's multisvm function
%found at http://www.mathworks.com/matlabcentral/fileexchange/33170-multi-class-support-vector-machine/
if nargin < 4
    c = 5;
end

if nargin < 5
    kt = 'rbf';
end

u=unique(GroupTrain);
numClasses=length(u);
result = zeros(length(TestSet(:,1)),1);
models = [];
%build models
for k=1:numClasses
    %Vectorized statement that binarizes Group
    %where 1 is the current class and 0 is all other classes
    G1vAll=(GroupTrain==u(k));    
    G1vAll = logical(G1vAll);    
%     G1vAll = mat2cell(G1vAll,size(G1vAll,1),size(G1vAll,2));
%     models(k) = svmtrain(TrainingSet,G1vAll,'boxconstraint',c,'kernel_function',k); % ,
    tmp = fitcsvm(TrainingSet,G1vAll,'boxconstraint',c,'KernelFunction',kt,'KernelScale','auto','Standardize',true); % ,
    models{k} = tmp;
end

% return;
%classify test cases
page_alignment_score = [];
for j=1:size(TestSet,1)
    max_score = -Inf;
    rs = [];
    tmp_score = [];
    for k=1:numClasses
%         if(svmclassify(models{k},TestSet(j,:))) 
        [~,score] = predict(models{k},TestSet(j,:)) ;
        tmp_score = [tmp_score score(1)];
        if score(1) > max_score
           max_score = score(1);
           rs = k;
        end

    end
    page_alignment_score{j} = tmp_score;
    result(j) = u(rs);
end


