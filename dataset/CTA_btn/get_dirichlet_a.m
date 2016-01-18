function [ rs ] = get_dirichlet_a( four_edges_analysis, edg_ind )
%UNTITLED17 Summary of this function goes here
%   Detailed explanation goes here
%     clc

    rs = [];
    min_val = 0;
    min_len = 2;
    
    l_n = cellfun(@(x) [x{edg_ind + 4} x{edg_ind + 8}], four_edges_analysis,'UniformOutput',false);     
    l_n = cell2mat(l_n');
%     return;
    
    tmp = l_n;
    [values, order] = sort(tmp(:,1));
    tmp = tmp(order,:);
    
    split_cell = cellfun(@(x) x{edg_ind + 12}, four_edges_analysis, 'UniformOutput',false);
    split_cell = split_cell';
    
    a = cell(6,3);
    for l = 0 : 6
        for n = 2 : 3
            ind = find(l_n(:,1) == l & l_n(:,2) == n);
            len = length(ind);
            if len < min_len
                a{l + 1,n} = ones(1,n);                
            else
                tmp = 0;
                data = split_cell(ind,:);
%                 ind
                data = cellfun(@(x) [x]',data,'UniformOutput',false);
                data = cell2mat(data);
                for t = 1 : size(data,1)
                    dump = rand(1) / 1000;
                    data(t,1) = data(t,1) + dump;
                    data(t,2) = data(t,2) - dump;
                end
%                 data
                

                a{l + 1,n} = dirichlet_fit(data);
%                 return;
%                 rs = data; dirichlet_fit(data);return;
            end
        end
    end
    
    %handle n = 1
    
    freq = cell(6,3);
    sum_len = size(l_n,1);
    
    for n = 1 : 3
        for l = 0 : 6
            if n == 1
                freq{l+1,n} = dirichlet_logProb([1,1],[0.4,0.6]);
            end
            ind = find(l_n(:,1) == l & l_n(:,2) == n);
            freq{l+1,n} = length(ind) / sum_len;
        end
    end
    
    rs = [freq, a];
end

