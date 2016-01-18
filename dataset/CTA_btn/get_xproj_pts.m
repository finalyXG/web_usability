function [ rs ] = get_xproj_pts( line, lines )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    rs = [];
    pt = [line(1) line(2)];
    for i = 1 : size(lines,1)
        tmp = projPointOnLine(pt,[lines(i,1) lines(i,2) 1 0]);
        rs = [rs; tmp];
    end

end