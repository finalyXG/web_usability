clc
tic
acc_btn_train_margin_boxes = get_acc_btn_train_boxes(page_btn_train_margin_boxes);
[four_edges_analysis, page_four_edges_analysis] = ...
    get_four_edges_analysis(page_btn_train_margin_boxes, page_elements_masks_train);

margin_boxes_nsplit = get_four_edge_total_num(four_edges_analysis);
margin_boxes_mlen = get_four_edge_mlen(four_edges_analysis);
page_btns_dump = get_page_btns(button_label);

[page_four_edges_analysis, acc_mbox2btn_wh, acc_mbox2btn_xy, acc_mbox2btn_oxoy, acc_mbox2btn_exey] = ...
    get_mbox2btn_wh(page_four_edges_analysis, page_btn_train_margin_boxes, page_btns_dump);

% freq_sysmetric_analysis = [margin_boxes_nsplit margin_boxes_mlen acc_btn_train_margin_boxes(:,3:4)];
% [freq_v, acc_freq_v] = get_freq_v(freq_sysmetric_analysis,acc_btn_train_margin_boxes, acc_mbox2btn_wh, acc_mbox2btn_xy);
% [freq_w, acc_freq_w] = get_freq_w(freq_sysmetric_analysis,acc_btn_train_margin_boxes, acc_mbox2btn_wh, acc_mbox2btn_xy);

% freq_4_edge = get_4_edge_freq(four_edges_analysis);
% param = get_params(four_edges_analysis);

toc

save('acc_mbox2btn_wh.mat','acc_mbox2btn_wh');
save('acc_mbox2btn_xy.mat','acc_mbox2btn_xy');
save('acc_mbox2btn_oxoy.mat','acc_mbox2btn_oxoy');
% save('acc_freq_v.mat','acc_freq_v');
% save('acc_freq_w.mat','acc_freq_w');
save('acc_btn_train_margin_boxes.mat','acc_btn_train_margin_boxes');
% save('freq_v.mat','freq_v');
% save('freq_w.mat','freq_w');









