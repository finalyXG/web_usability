c_num = 3;
[idx,~] = kmeans([fd_alignment_train(:,1); fd_alignment_test(:,1)] ,c_num ,'Replicates',2 );


tmp_cluster = zeros(size(fd_alignment_train,1),c_num);
% [idx,~] = kmeans(fd_alignment_train(:,1),2,'Replicates',2);
for i = size(fd_alignment_train,1) : -1 : 1
    tmp_cluster(i,idx(i)) = 1;   
    idx(i) = [];
end

fd_alignment_train(:,1) = [];
fd_alignment_train = [tmp_cluster fd_alignment_train];


tmp_cluster = zeros(size(fd_alignment_test,1),c_num);
for i = size(fd_alignment_test,1): - 1 : 1
    tmp_cluster(i,idx(i)) = 1; 
    idx(i) = [];
end

fd_alignment_test(:,1) = [];
fd_alignment_test = [tmp_cluster fd_alignment_test];

size(idx)

