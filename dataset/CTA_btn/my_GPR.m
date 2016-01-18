function [ ymu ys2 fmu fs2 ] = my_GPR( x,y,testx, cov,meanv )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%     meanfunc = {@meanSum, {@meanLinear, @meanConst}};
%     hyp.mean = [0.5 0.5; 1 1];

    % ---------------------------------- normalize data ----------------------------------
%     clc
    
    max_x = max(x,[],1) ;
    min_x = min(x,[],1) ;
    [row,col] = size(x);
    [row1,col1] = size(testx);
    
    x = ((repmat(max_x,row,1)-x) ./ repmat(max_x - min_x + 0.00001,row,1));
    testx = ((repmat(max_x,row1,1)-testx) ./ repmat(max_x - min_x + 0.00001,row1,1));
    z = testx;
    % ---------------------------------- normalize data ----------------------------------
    meanfunc = {@meanSum, {@meanLinear, @meanConst}}; 
    likfunc = @likGauss; 
    covfunc = @covSEiso; 
    hyp.cov = [0 ; 0]; hyp.mean = [zeros(size(x(1,:)))'; 0]; hyp.lik = log(0.1); 
    hyp = minimize(hyp, @gp, -100, @infExact, meanfunc, covfunc, likfunc, x, y);
    [ymu ys2 fmu fs2] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, x, y, z);

    return;
    
    
    
    
    
    
    
    
  
end

