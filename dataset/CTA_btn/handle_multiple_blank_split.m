function [ e ] = handle_multiple_blank_split( e )
%UNTITLED18 Summary of this function goes here
%   Detailed explanation goes here

    if sum(e(:,2)) == 0
        e = [sum(e(:,1)) 0];
        return;
    end
    
    %check if split len / total_len > 0.1
%     total_len = norm(e(:,1),1);
%     for i = 1 : size(e,1)
%         if e(i,1) / total_len < 0.15
%     end
    
    
    for i = 2 : size(e,1)
        if e(i,2) == 0 && e(i-1,2) ==0
            e(i,1) = e(i,1) + e(i-1,1);
            e(i-1,1) = -1;
        end
    end
    ind = find(e(:,1) > 0);
    e = e(ind,:);

end

