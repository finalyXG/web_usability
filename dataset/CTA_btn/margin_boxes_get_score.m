function [ rs ] = margin_boxes_get_score( four_edges_analysis_test, param, edg_ind )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    rs = [];
    min_e = 0.0001;
    l_n = cellfun(@(x) [x{edg_ind + 4} x{edg_ind + 8}], four_edges_analysis_test,'UniformOutput',false); 
    l_n = cell2mat(l_n');
    
    split_cell = cellfun(@(x) x{edg_ind + 12}, four_edges_analysis_test, 'UniformOutput',false);
    split_cell = split_cell';
    
    for i = 1 : size(l_n,1)
        one_l_n = l_n(i,:);
        if one_l_n(2) == 1 || one_l_n(2) > 3
%             score = log (param{one_l_n(1) + 1 , 1} + min_e);
            score = log ( min(param{one_l_n(1) + 1 , 1}, min_e) );
        else
%             i
%             one_l_n
%             split_cell{i}'
            score = dirichlet_logProb(param{one_l_n(1) + 1 , one_l_n(2) + 1 + 2}, split_cell{i}');
        end
        rs = [rs; score];
    end
    
    
    return;

end

