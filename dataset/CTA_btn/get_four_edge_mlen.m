function [ rs ] = get_four_edge_mlen( four_edges_analysis )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    rs = [];
%     if length(edge_ind) ~= 2  
%         input('error: get_four_edge_mlen');
%         return;
%     end
    
    for i = 1 : length(four_edges_analysis)
        
        tmp = four_edges_analysis{i};
        major_label = cell2mat({tmp{[5,6,7,8]}});

        mlen_one = zeros(1,4);
        for j = 1 : 4
            dump = cell2mat({tmp{j}});
            [v ord] = sort(dump(:,1),'descend');
            dump = dump(ord,:);
            ind = find(dump(:,2) ==  major_label(j));
            ind = ind(1);
            mlen_one(j) = dump(ind,1);                    
        end
        rs = [rs; mlen_one];
    end

end

