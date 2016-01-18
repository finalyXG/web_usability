function fhs = plot_components(components)
biasdis = 0;
fhs = [];
for i = 1:length(components)
    h = plot_single_component(components{i}, biasdis, 'r', 2);
    fhs = [fhs; h];
    hold on;
end
end
