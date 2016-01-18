% function ndcg = test_ranksvm()
%   load ohsumed
%   C = 1e-4; % Constant penalizing the training errors
%   for i=1:5
%     A = generate_constraints(Yall(i).Y);
%     tic;
%     w = ranksvm(Xall(i).X, A, C*ones(size(A,1),1));
%     t = toc;
%     tmp = Xall(i).Xt*w;
%     ndcg(i) = compute_ndcg(Xall(i).Xt*w,Yall(i).Yt,10);
%     fprintf('Fold %d, NDCG@10 = %f, Time = %fs\n',i,ndcg(i),t);
%     return;
%   end;


 C = 1e-4;
 A = generate_constraints(Yall(i).Y);