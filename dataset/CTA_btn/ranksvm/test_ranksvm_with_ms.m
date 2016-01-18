
function ndcg = test_ranksvm_with_ms()
% Same as before but find the C on the validation set
  load ohsumed
  for i=1:5
    A = generate_constraints(Yall(i).Y);
    for j=1:7
      w(:,j) = ranksvm(Xall(i).X, A, 10^(j-5)*ones(size(A,1),1));
      ndcg_ms(j) = compute_ndcg(Xall(i).Xv*w(:,j),Yall(i).Yv,10);
    end;
    fprintf('C = %f, ndcg = %f\n',[10.^[-4:2]; ndcg_ms])
    [foo, k] = max(ndcg_ms);
    for j=1:10
      ndcg(i,j) = compute_ndcg(Xall(i).Xt*w(:,k),Yall(i).Yt,j);
    end;
    fprintf('Fold %d: ',i);
    fprintf('%f ',ndcg(i,:));
    fprintf('\n');
  end;
  fprintf('Average: ');
  fprintf('%f ',mean(ndcg));
  fprintf('\n');
      
  
  
% Build the sparse matrix of constraints
% Each row is constraint. If the p-th example is prefered to the
% q-th one, there is a +1 on column p and a -1 on column q.
