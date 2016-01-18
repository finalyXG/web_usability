
for i = test_page_ind : file_len
%     i = 1
    file_name = cell2mat(file_names(i));
    img = imread(file_name);
    plot_elements(input_label,file_name,i,'k',2);
    
    plot_elements(img_label,file_name,i,'y',2);

    plot_elements(text_label,file_name,i,'g',2);
    
    plot_elements(button_label,file_name,i,'r',2);
    
    plot_elements(border_label,file_name,i,'m',2);
    
    plot_elements(bgi_label,file_name,i,'b',2);
    
    break;
    
end

