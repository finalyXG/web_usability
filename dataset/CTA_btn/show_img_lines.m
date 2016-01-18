function [  ] = show_img_lines( img,lines )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
    figure(3),
    imshow(img),hold on,
%     for i = 1 : size(lines,1)
%         pt1 = lines(i,1:2);
%         pt2 = lines(i,3:4);
%         plot(pt1,pt2);
%     end
    x = [lines(:,1) lines(:,3)]';
    y = [lines(:,2) lines(:,4)]';
    line(x,y,'color','b','LineWidth',5);
    hold off;
end

