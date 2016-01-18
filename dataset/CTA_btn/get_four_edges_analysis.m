function [ four_edges_analysis, page_four_edges_analysis ] = get_four_edges_analysis( page_btn_train_margin_boxes, page_elements_masks )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    acc_len = 0;
    four_edges_analysis = [];
    page_four_edges_analysis = [];
    for i = 1 : length(page_elements_masks)
        
        page_mask = page_elements_masks{i};
        page_btn_boxes = page_btn_train_margin_boxes{i};
        edge_desp = analysis_edges( page_btn_boxes, page_mask);
        tmp = [];
        for j = 1 : length(edge_desp)
            acc_len = acc_len + 1;
            four_edges_analysis{acc_len} = edge_desp{j};
            tmp = [tmp ;edge_desp{j}];
        end
        page_four_edges_analysis{i} = tmp;
    end

end

