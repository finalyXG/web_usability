
file_len = length(text_label);      
file_names = text_label_file_names;
file_name = cell2mat(file_names(1));
img = imread(file_name);
% return;
% file_len = 18;
% test_page_ind = 6;
for i = test_page_ind : file_len
    file_name = cell2mat(file_names(i));
    img = imread(file_name);
    clf
    figure(1), 
    imshow(img);
    axis('ij');
    hold on,
    plot_elements(img_label,file_name,i,'y',2);

    plot_elements(input_label,file_name,i,'k',2);
    
    plot_elements(text_label,file_name,i,'g',2);
    
%     plot_elements(button_label,file_name,i,'r',2);
    
    
    plot_elements(border_label,file_name,i,'m',2);
    
    plot_elements(bgi_label,file_name,i,'b',2);
    
    if exist('BTN_label','var')
        plot_elements(BTN_label, file_name, i,'r',2);
    end
    hold off;
    return;
    d = input('dump');
    
end