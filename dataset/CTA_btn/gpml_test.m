clear all, close all
 
  meanfunc = {@meanSum, {@meanLinear, @meanConst}}; hyp.mean = [0.5; 1];
  covfunc = {@covMaterniso, 3}; ell = 1/4; sf = 1; hyp.cov = log([ell; sf]);
  likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);
 
  n = 20;
  x = gpml_randn(0.3, n, 1);
  K = feval(covfunc{:}, hyp.cov, x);
  mu = feval(meanfunc{:}, hyp.mean, x);
  y = chol(K)'*gpml_randn(0.15, n, 1) + mu + exp(hyp.lik)*gpml_randn(0.2, n, 1);

  plot(x, y, '+')
  

%%
clc
z = linspace(-1.9, 1.9, 101)';

covfunc = @covSEiso; hyp2.cov = [0; 0]; hyp2.lik = log(0.1);
hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, x, y);

nlml2 = gp(hyp2, @infExact, [], covfunc, likfunc, x, y)

[m s2] = gp(hyp2, @infExact, [], covfunc, likfunc, x, y, z);
f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
fill([z; flipdim(z,1)], f, [7 7 7]/8);
hold on; plot(z, m); plot(x, y, '+')





%% multivariate 
clc
figure(1)
[X1,X2] = meshgrid(-pi:pi/16:+pi, -pi:pi/16:+pi);

Y = sin(X1).*sin(X2) + 0.1*randn(size(X1));
% Y = zeros(size(X1));
% Y(15,15) = 1;

imagesc(Y); drawnow;
% return;
x = [X1(:) X2(:)];
y = Y(:);
meanfunc = {@meanSum, {@meanLinear, @meanConst}};hyp2.mean = [0; 0; 0];
covfunc = @covSEiso; hyp2.cov = [0 ; 0];
% covfunc = {@covMaterniso, 3}; ell = 1/4; sf = 1; hyp.cov = log([ell; sf]);

likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);
% meanfunc = {@meanSum, {@meanLinear, @meanConst}}; hyp.mean = [0.5; 1];

    
% hyp2.lik = log(0.1);

hyp2 = minimize(hyp2, @gp, -100, @infExact, meanfunc, covfunc, likfunc, x, y);
exp(hyp2.lik)
% return;
nlml2 = gp(hyp2, @infExact, meanfunc, covfunc, likfunc, x, y);
% nlml2 = gp(hyp2, @infExact, [], covfunc, likfunc, x, y);
[m s2] = gp(hyp2, @infExact, meanfunc, covfunc, likfunc, x, y, x);
% [m s2] = gp(hyp2, @infExact, [], covfunc, likfunc, x, y, x);
m = reshape(m, size(Y));
% m = floor(m);
figure(3); imagesc(m);
