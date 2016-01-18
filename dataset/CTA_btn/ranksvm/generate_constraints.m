function A = generate_constraints(Y)
  nq = length(Y);
  
  I=zeros(1e7,1); J=I; V=I; nt = 0;
  
  ind = 0;
  for i=1:nq
    ind = ind(end)+[1:length(Y{i})]';
    Y2 = Y{i};
    n = length(ind);
    [I1,I2] = find(repmat(Y2,1,n)>repmat(Y2',n,1));
    n = length(I1);
    I(2*nt+1:2*nt+2*n) = nt+[1:n 1:n]'; 
    J(2*nt+1:2*nt+2*n) = [ind(I1); ind(I2)];
    V(2*nt+1:2*nt+2*n) = [ones(n,1); -ones(n,1)];
    nt = nt+n;
  end;
  A = sparse(I(1:2*nt),J(1:2*nt),V(1:2*nt));    
  