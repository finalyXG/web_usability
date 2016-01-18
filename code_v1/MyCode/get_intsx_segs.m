function [ rs ] = get_intsx_segs( line,lines )
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here

    rs = [];
    for i = 1 : size(lines,1)
        tmp_line = lines(i,:);
        if tmp_line(1) >  line(3) + 10 || line(1) > tmp_line(3) + 10
            continue;
        end
        rs = [rs; tmp_line]; 
    end

end

