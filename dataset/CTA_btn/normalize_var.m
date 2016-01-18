    
x = [1,2,3;4,5,6;7,8,9];
max_x = max(x,[],1)
min_x = min(x,[],1)
[row,col] = size(x);
x = ((repmat(max_x,row,1)-x) ./ repmat(max_x - min_x,row,1))
%     testx = ((repmat(max_x,row,1)-testx) ./ repmat(max_x - min_x,row,1));
