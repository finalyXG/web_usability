function d = point_to_line(pt, v1, v2)
    if size(pt,2) == 2
        pt = [pt 0];
        v1 = [v1 0];
        v2 = [v2 0];
    end
    a = v1 - v2;
    b = pt - v2;
    d = norm(cross(a,b)) / norm(a);
end