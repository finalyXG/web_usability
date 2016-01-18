function [ rs ] = get_four_edge_total_num( four_edges_analysis, type )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    rs = [];
    for i = 1 : length(four_edges_analysis)
        tmp = four_edges_analysis{i};
        s1 = size(tmp{1},1);
        s2 = size(tmp{2},1);
        s3 = size(tmp{3},1);
        s4 = size(tmp{4},1);
        s = [s1 s2 s3 s4];
        rs = [rs; s];
    end

end

