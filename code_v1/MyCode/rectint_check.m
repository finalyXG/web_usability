function [ rs ] = rectint_check( rect, boxes )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    rs = false;       
%     if rect(3) < rect(4)
%         rs = true;
%         return;
%     end
%     if rect(3) * rect(4) < 100 * 50
%         rs = true;
%         return;
%     end
    for i = 1 : size(boxes,1)
        tmp_area = rectint(rect, boxes(i,:));
        if tmp_area > 0 && tmp_area ~= rect(3) * rect(4)
            rs = true;
            return;
        end
    end

end

