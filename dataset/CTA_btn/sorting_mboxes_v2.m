
tic
test_page_ind = test_page_ind;
[sorted_margin_boxes_test,sorted_four_edges_analysis_test, scores] = get_score_sorted_boxes(...
    page_elements_masks,page_btn_test_margin_boxes, four_edges_analysis_test,...
    param,freq_4_edge,density,freq_v,freq_w, test_page_ind);

page_btn_test_margin_boxes{test_page_ind} = sorted_margin_boxes_test;
toc