function [ rs ] = get_acc_btn_train_boxes( page_btn_train_boxes )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    acc_btn_train_boxes = [];
    for i = 1 : length(page_btn_train_boxes)
        tmp = page_btn_train_boxes{i};
        for j = 1 : size(tmp,1)
            acc_btn_train_boxes = [acc_btn_train_boxes ; tmp(j,:)];
        end
    end
    rs = acc_btn_train_boxes;

end

