% clear all
close all
[Target,PHI,W,X] = PolynomialExpertToyData();
%Labels  should be from 1,.,K

RegulationTerm=1;

NumberSamples=length(Target);
%Number of Training Samples
NumberTraining=floor(NumberSamples*0.05);
%Number Validation Samples
NumberValidation =floor(NumberSamples*0.05);
%Number of testing Samples
NumberTesting=floor(NumberSamples*0.01);
% partition data into training validation data 
[ Train,Validation,Test] = GetTrainValidateTest(NumberSamples,NumberTraining,NumberValidation,NumberTesting);
 

Paramter=[1 2];
%Create a KernelRidgeRegressio object  
KernelRegression =KernelRidgeRegression(['poly'],X(Train),Paramter,Target(Train),1);
% KernelRegression =KernelRidgeRegression(['poly'],X(Train),Paramter,Target(Train),1);

Out=KernelPrediction(KernelRegression ,X(Validation));

 figure 
plot(X(Validation),Out,'LineWidth',4)
hold on



plot(X(Train),Target(Train),'ro','LineWidth', 4)
%hold off
legend('Output of Model Using Validation Data ','Training Samples')
title('Validation Results')



%% my testing codes
clc
x = [-30:.1:30]';
norm = normpdf(x,0,10);
target = norm;
NumberSamples=length(target);
NumberTraining=floor(NumberSamples*0.1);
%Number Validation Samples
NumberValidation =floor(NumberSamples*0.1);
%Number of testing Samples
NumberTesting=floor(NumberSamples*0.05);
[ train,validation,test] = GetTrainValidateTest(NumberSamples,NumberTraining,NumberValidation,NumberTesting);
% return;
Paramter = [7];
% Paramter=[1 2];

% train = logical([1;1;1;1;0;1]);
% validation = train;
% x(train)
% target(train)
% return;
KernelRegression =KernelRidgeRegression(['rbf'],x(train),Paramter,target(train),1);
% % return;
Out=KernelPrediction(KernelRegression ,x(validation));
% return;

 figure 
plot(x(validation),Out,'LineWidth',4)
hold on

plot(x(train),target(train),'ro','LineWidth', 4)
hold off
legend('Output of Model Using Validation Data ','Training Samples')
title('Validation Results')


%%
clc
mu = [1]; 
SIGMA = [1]; 
X = mvnrnd(mu,SIGMA,1000); 
p = mvnpdf(X,mu,SIGMA); 
target = p;
NumberSamples=length(target);
NumberTraining=floor(NumberSamples*0.1);
%Number Validation Samples
NumberValidation =floor(NumberSamples*0.1);
%Number of testing Samples
NumberTesting=floor(NumberSamples*0.05);

[ train,validation,test] = GetTrainValidateTest(NumberSamples,NumberTraining,NumberValidation,NumberTesting);
Paramter = [1];

KernelRegression =KernelRidgeRegression(['rbf'],X(train),Paramter,target(train),1);

Out=KernelPrediction(KernelRegression ,X(validation));
[Out p(validation)]






%%
% [X,Y,Z] = peaks(25);
% figure
mu = [1 -1]; 
SIGMA = [.5 0; 0 .5]; 
X = mvnrnd(mu,SIGMA,100); 
[x y] = meshgrid(X(:,1),X(:,2));
Z = mvnpdf([x(:) y(:)],mu,SIGMA);
z = reshape(Z,size(x));
surf(x,y,z)


