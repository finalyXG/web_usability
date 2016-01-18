function [ dump_margin_boxes_test,dump_four_edges_analysis_test, v ] = get_score_sorted_boxes(...
     page_elements_masks, page_btn_test_margin_boxes, four_edges_analysis_test,...
     param, freq_4_edge, density,freq_v,freq_w,file_ind )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    clc
    page_elements_masks = {page_elements_masks{file_ind}};
    margin_boxes_test = page_btn_test_margin_boxes{file_ind};    
    
    negative_score = -100;
    margin_boxes_score = [];
    for i = 1 : 4
        tmp = margin_boxes_get_score(four_edges_analysis_test, param{i}, i);
        margin_boxes_score = [margin_boxes_score, tmp];
    end
    
    
    freq = []; 
    for i = 1 : length(four_edges_analysis_test) 
        tmp = four_edges_analysis_test{i}; 
        tmp_lable = [tmp{5:8}] + 1; 
        freq = [freq; ... 
            freq_4_edge(tmp_lable(1),tmp_lable(2),tmp_lable(3),tmp_lable(4))]; 
        % if freq == 0 
    end
    
    
    % 
    sum_margin_boxes_score = sum(margin_boxes_score,2);
    for i = 1 : length(four_edges_analysis_test)
        if freq(i) == 0
            sum_margin_boxes_score(i) = negative_score;
        else
            sum_margin_boxes_score(i) = sum_margin_boxes_score(i) - log(freq(i));
%             sum_margin_boxes_score(i) = sum_margin_boxes_score(i) ;
        end
    end
            
    
    % return;
    [v order] = sort(sum_margin_boxes_score, 'descend');
    dump_margin_boxes_test = margin_boxes_test(order,:);
    dump_four_edges_analysis_test = [];

    
    
    for i = 1 : length(v)
        if v(i) <= negative_score   
            dump_margin_boxes_test(i:end,:) = [];   
            sum_margin_boxes_score = v(1:i-1,:);
            break;  
        else
            ind = order(i);
%             {four_edges_analysis_test{ind}}
            if ~isempty(dump_four_edges_analysis_test)
                dump_four_edges_analysis_test = [dump_four_edges_analysis_test; {four_edges_analysis_test{ind}}];
            else
                dump_four_edges_analysis_test = {four_edges_analysis_test{ind}};
            end
            
        end  
    end  
    
    
    
    %cut -------------------------------------------------
    for i = length(dump_four_edges_analysis_test):-1:1
        tmp = dump_four_edges_analysis_test{i};
        if tmp{9} > 4 || tmp{10} > 4 || tmp{11} > 4 || tmp{12} > 4
            dump_four_edges_analysis_test(i,:) = [];
            dump_margin_boxes_test(i,:) = [];
            sum_margin_boxes_score(i,:) = [];
        end
    end
    
%     size(dump_four_edges_analysis_test)
%     return;
    
    
    %cut -------------------------------------------------
    

    x_y_w_h_test = get_x_y_w_h(page_elements_masks, {dump_margin_boxes_test}); 
%     x_y_w_h_test = x_y_w_h_test(:,2:4);
    xy = x_y_w_h_test(:,1:2);
    wh = x_y_w_h_test(:,3:4);
    
%     pca_data = x_y_w_h_test * pca_coeff(:,1:2);
%     density_p1 = get_valueOfdens(density.density_1,density.X1,density.Y1,...
%         xy(:,1),xy(:,2));
    
    density_p2 = get_valueOfdens(density.density_2,density.X2,density.Y2,...
        wh(:,1),wh(:,2));
%     size(dump_margin_boxes_test)
%     size(scores)
%     density_score1 = log(density_p1);
%     density_score1 = 0;
    density_score2 = log(density_p2);
%     density_score = density_score1 + density_score2;
    sum_margin_boxes_score =  density_score2; % + sum_margin_boxes_score
%     sum_margin_boxes_score = sum_margin_boxes_score + density_score2;
%     sum_margin_boxes_score = density_score2;
        
%     plot the data and the density estimate
%     figure,contour3(density.X2, density.Y2,density.density_2,50), hold on
%     plot(wh(:,1),wh(:,2),'r.','MarkerSize',5)
    

% cut ---------------------------------------------------------------------
% freq_v, dump_margin_boxes_test
    

% cut ---------------------------------------------------------------------
% freq_w


% cut ---------------------------------------------------------------------

    [v order] = sort(sum_margin_boxes_score , 'descend');
    dump_margin_boxes_test = dump_margin_boxes_test(order,:);

end

