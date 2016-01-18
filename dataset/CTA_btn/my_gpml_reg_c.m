function [ ymu ys2 fmu fs2 ] = my_gpml_reg_c( x,y,testx, cov,meanv )
%UNTITLED Summary of this function goes here
    % ---------------------------------- normalize data ----------------------------------
    %     clc
    
    max_x = max(x,[],1) ;
    min_x = min(x,[],1) ;
    [row,col] = size(x);
    [row1,col1] = size(testx);
    
    x = ((repmat(max_x,row,1)-x) ./ repmat(max_x - min_x + 0.00001,row,1));
    testx = ((repmat(max_x,row1,1)-testx) ./ repmat(max_x - min_x + 0.00001,row1,1));
    
    % ---------------------------------- normalize data ----------------------------------
    covfunc = @covSEard; 
    likfunc = @likGauss; 
    
    sn = 0.1; 
    sf = 1;
    hyp2.lik = log(sn);
    meanfunc = {@meanSum, {@meanLinear, @meanConst}};
    hyp2.mean = meanv;

    hyp2.cov = log(cov) ;
    hyp2.lik = log(0.01);
    
    hyp2 = minimize(hyp2, @gp, -100, @infExact, meanfunc, covfunc, likfunc, x, y);
    exp(hyp2.lik);
    
    [ymu ys2 fmu fs2] = gp(hyp2, @infExact, meanfunc, covfunc, likfunc, x, y, testx);


end

