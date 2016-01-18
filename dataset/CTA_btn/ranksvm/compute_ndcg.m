
function ndcg = compute_ndcg(Y,Yt,p)
  conv = [0 1 3];
  ind = 0;
  for i=1:length(Yt)
    ind = ind(end)+[1:length(Yt{i})];
    q = min(p,length(ind));
    disc = [1 log2(2:q)];
    [foo,ind2] = sort(-Yt{i});
    best_dcg = sum(conv(Yt{i}(ind2(1:q))+1) ./ disc) + eps;
    [foo,ind2] = sort(-Y(ind));
    ndcg(i) = sum(conv(Yt{i}(ind2(1:q))+1) ./ disc) / best_dcg;
  end; 
  ndcg = mean(ndcg);
