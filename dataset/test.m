
data_dir = 'data/';
page_names = dir([data_dir '*.mat'])

for i = 1:length(page_names)
    page = importdata([data_dir '/' page_names(i).name]);
    
    figure(1);
    imshow(page.I);
    
%     plot_components(page.components);
    hold on;
%     plot_component_tag(page.components);
    d = input('dump');
end

