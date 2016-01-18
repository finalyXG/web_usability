function [ rs ] = get_valueOfdens( density,X,Y,qx_m,qy_m )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    rs = [];
    x_range = X(1,:);
    y_range = Y(:,1);
    
    for i = 1 : length(qx_m)
        qx = qx_m(i);
        qy = qy_m(i);
        
        xind = 0;
        yind = 0;

        value = 0;
        for i = 1 : length(x_range)
            if qx <= x_range(i)
                xind = i;
                break;
            end
        end

        for i = 1 : length(y_range)
            if qy <= y_range(i)
                yind = i;
                break;
            end
        end

%         xind
%         yind
        value = density(yind,xind);
        rs = [rs; value];
    end
end


