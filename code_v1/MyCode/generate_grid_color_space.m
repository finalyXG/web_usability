
interval = 48;
r = [0:interval:256] ./ 256;
g = [0:interval:256] ./ 256;
b = [0:interval:256] ./ 256;


[rr,gg,bb] = meshgrid(r,g,b);
grid_color = [rr(:) gg(:) bb(:)];

% for i = 1 : size(grid_color,1);
%     a = grid_color(i,:);
%     figure(1),imagesc([1,1],[1,1],[1:1]);
%     colormap(a);
%     input('d');
% end

save('grid_color.mat','grid_color');
% imagesc([1 4],[1 1],[1:4])
% colormap(grid_color(1:4,:));