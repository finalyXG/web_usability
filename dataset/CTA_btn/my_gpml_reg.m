function [ ymu ys2 fmu fs2 ] = my_gpml_reg( x,y,testx, cov,meanv )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%     meanfunc = {@meanSum, {@meanLinear, @meanConst}};
%     hyp.mean = [0.5 0.5; 1 1];
    
    covfunc = @covSEard; 
    likfunc = @likGauss; 
    sn = 0.1; 
    sf = 1;
    hyp2.lik = log(sn);
    meanfunc = {@meanSum, {@meanLinear, @meanConst}};
    hyp2.mean = meanv;
%     hyp2.mean = zeros(size(testx,2)+1,1);
    hyp2.cov = log(cov) ;
%     [ones(size(testx,2),1)*0.5; 0.1]
    hyp2.lik = log(0.1);
    
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

