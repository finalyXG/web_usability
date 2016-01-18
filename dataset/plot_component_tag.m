function plot_component_tag(components)
for i = 1:length(components)
    bbx = components{i}.polygon.x;
    bby = components{i}.polygon.y;
    bbw = max(bbx) - min(bbx);
    bbh = max(bby) - min(bby);
    x = mean(bbx);
    y = mean(bby);
%     text(x, y, components{i}.tag, 'FontSize', 20, 'Color', 'r', 'HorizontalAlignment', 'center');
%     [bbx(2)-bbx(1); bby(3)-bby(2)]
%     rectangle('Position', [min(bbx),min(bby),bbw+1,bbh+1],...
%   'EdgeColor','r','LineWidth',2 )
end
end