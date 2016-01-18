function plot_multi_boxes( rectangles, type, face_color)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    mark_face_color = 1;
    if nargin ~= 3
        mark_face_color = 0;
    end
    
    my_color = ['y'; 'm'; 'c'; 'r'; 'g'; 'b'; 'k'];
    my_color_size = size(my_color,1);
    for i = 1 : size(rectangles,1)
        
        if exist('type','var') &&  ~isempty(type) 
            if mark_face_color == 1
                face_color(i,:)
                rectangle('Position',rectangles(i,:),'Curvature',0.2,'EdgeColor', ...
                 'none','LineWidth',2,'FaceColor',face_color(i,:));   
                text(rectangles(i,1) + round(0.5*rectangles(i,3) - 40),rectangles(i,2)+round(rectangles(i,4)*0.5-8 ),'Button','Color',[1,1,1]);
            else
                rectangle('Position',rectangles(i,:),'Curvature',0.2,'EdgeColor', ...
                 type,'LineWidth',2);
            end
        else
            rectangle('Position',rectangles(i,:),'Curvature',0.2,'EdgeColor', ...
                my_color(mod(i,my_color_size) + 1));
        end

        text(rectangles(i,1),rectangles(i,2), num2str(i),'Color','r','FontSize',20);
    end
end

