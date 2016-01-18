function [ rs ] = get_4_edge_freq( four_edges_analysis )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    rs = [];
    acc = zeros(6+1,6+1,6+1,6+1);
    for i = 1 : length(four_edges_analysis)
        tmp = four_edges_analysis{i};
        tmp = [tmp{5:8}];
%         return;
        acc(tmp(1)+1,tmp(2)+1,tmp(3)+1,tmp(4)+1) = acc(tmp(1)+1,tmp(2)+1,tmp(3)+1,tmp(4)+1) + 1;
    end
    rs = acc ./ length(four_edges_analysis);
    
end

