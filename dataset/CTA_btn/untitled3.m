clc
n = 20;
x = gpml_randn(0.3, n, 1);
y = x;
z = linspace(min(x), max(x), 20)';
meanfunc = {@meanSum, {@meanLinear, @meanConst}}; 
likfunc = @likGauss; 
covfunc = @covSEiso; 
hyp.cov = [0; 0]; hyp.mean = [0; 0]; hyp.lik = log(0.1); 
hyp = minimize(hyp, @gp, -100, @infExact, meanfunc, covfunc, likfunc, x, y);
[ymu ys2 fmu fs2] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, x, y, z);

return;