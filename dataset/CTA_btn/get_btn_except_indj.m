function [ rs_boxes ] = get_btn_except_indj(btn_boxes, indj )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
%     btn_boxes(indj,:) = [];
    btn_boxes.location(indj,:) = [];
    rs_boxes = btn_boxes;
end

