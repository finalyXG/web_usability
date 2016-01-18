function [ input_label, text_label, img_label, bgi_label, border_label ] = multiple_access_data_test( input_label, text_label, img_label, bgi_label,border_label,files )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    input_label = access_data(input_label, files); 
    text_label = access_data(text_label, files); 
    img_label = access_data(img_label, files);
    bgi_label = access_data(bgi_label, files);
    border_label = access_data(border_label, files);


end

