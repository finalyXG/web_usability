function [ rs ] = get_4_edge_param( four_edges_analysis )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    rs = [];
    mark_cell = cell(6,6,6,6);
    label_mat = [];
    cluster_by_label = [];
    ind = 0;
    for i = 1 : length(four_edges_analysis)
        tmp = four_edges_analysis{i};
        label = [tmp{5:8}] + 1;
%         tmp_len = length(mark_cell(label(1),label(2),label(3),label(4)));
        
%         mark_cell(label(1),label(2),label(3),label(4))
        dump = cell2mat(mark_cell(label(1),label(2),label(3),label(4)));
        if length(dump) == 0
            label_mat = [label_mat;label];
            ind = size(label_mat,1);
            mark_cell(label(1),label(2),label(3),label(4)) = {ind};
            cluster_by_label{ind} =  tmp;
        else
            ind = dump;
            cluster_by_label{ind} = [cluster_by_label{ind} ; tmp];
        end
        
        
    end
    

    
    mark_cell_LN = cell(6,3,6,3,6,3,6,3);
%     tmp_cell = cell(4,3);
    for i = 21 : size(label_mat,1)
        label = label_mat(i,:);
        tmp_ind = cell2mat(mark_cell(label(1),label(2),label(3),label(4)));
        tmp_cell = cell(4,3);
        for k = 1 : 4 
            tmp_cell{k,1} = 0;
            tmp_cell{k,2} = [1,1];
            tmp_cell{k,3} = [1,1,1];
        end
        
%         return; dirichlet_moment_match
        a = cluster_by_label{tmp_ind};
        for e = 1 : 4
            for k = 1 : 3

            end
        end
        rs = a;
        return;
        l = size(a,1);        
        tmp_c = cell(ind);
        for k = 1 : ind
            tmp_c{k} = {a{k,:}};
        end
        tmp_c
        
%         mark_cell_LN(label(1),label(2),label(3),label(4),1) = 
    end
    
    rs0 = label_mat;
    rs1 = cluster_by_label';
end

