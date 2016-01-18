function [ rs ] = get_intsy_segs( line,lines )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    rs = [];
    for i = 1 : size(lines,1)
        tmp_line = lines(i,:);
        if tmp_line(2) >  line(4) + 5 || line(2) > tmp_line(4) + 5
            continue;
        end
        rs = [rs; tmp_line]; 
    end

end

