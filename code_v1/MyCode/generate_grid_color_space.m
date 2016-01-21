
interval = 0.1;
a = [0:(1/16):1] ;
b = [0.2:(0.8/3):1] ;
c = [0.2:(0.8/3):1] ;


[aa,bb,cc] = meshgrid(a,b,c);
grid_color = [aa(:) bb(:) cc(:)];

RGB = reshape(ones(64,1)*reshape(colorcube(64),1,64 * 3),[64*64,3]) ;
% rgb_color = unique(hsv2rgb(grid_color),'rows') ;
rgb_color = unique(RGB,'rows');
% return;

% for i = 1 : size(grid_color,1);
%     a = grid_color(i,:);
%     figure(1),imagesc([1,1],[1,1],[1:1]);
%     colormap(a);
%     input('d');
% end

% s = 1;
% e = size(rgb_color,1);
% % e = 700;
% 
% figure(1),imagesc([s e],[1 1],[s:e])
% colormap(rgb_color(s:e,:));




% save('grid_color.mat','grid_color');
