function [ ymu ys2 fmu fs2 ] = my_gpml_reg_w( x,y,testx, cov,meanv )
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
    
    % ---------------------------------- normalize data ----------------------------------
    covfunc = @covSEard; 
%     covfunc = {@covMaterniso, 3}
    likfunc = @likGauss; 
    sn = 0.1; 
    sf = 1;
    hyp2.lik = log(sn);
    meanfunc = {@meanSum, {@meanLinear, @meanConst}};
    hyp2.mean = meanv;
%     hyp2.mean = zeros(size(testx,2)+1,1);
    hyp2.cov = log(cov) ;
%     hyp2.cov = log([10;1]) ;
%     [ones(size(testx,2),1)*0.5; 0.1]
    hyp2.lik = log(0.01);
    
%     covfunc = @covSEiso; 
%     hyp2.cov = [0.1, 0.1];
%     hyp2 = minimize(hyp2, @gp, -300, @infExact, [], covfunc, likfunc, x, y);
    hyp2 = minimize(hyp2, @gp, -100, @infExact, meanfunc, covfunc, likfunc, x, y);
    exp(hyp2.lik);
    
%     nlml2 = gp(hyp2, @infExact, [], covfunc, likfunc, x, y);
%     [ymu ys2 fmu fs2] = gp(hyp2, @infExact, [], covfunc, likfunc, x, y, testx);
    [ymu ys2 fmu fs2] = gp(hyp2, @infExact, meanfunc, covfunc, likfunc, x, y, testx);
%     [m s2] = gp(hyp2, @infExact, meanfunc, covfunc, likfunc, x, y, testx);


end

