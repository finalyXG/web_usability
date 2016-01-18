function [ rs ] = filter_overlap_mboxes( mboxes )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    rs = [];
    for i = size(mboxes,1) : -1 : 1
        for j = 1 : size(mboxes,1)  
            tmp = rectint(mboxes(i,:),mboxes(j,:));
            if i ~= j && tmp >= mboxes(j,3) * mboxes(j,4) * 1 && tmp <= mboxes(j,3) * mboxes(j,4)
                mboxes(i,:) = [];
                break;
            end
        end
        
    end
    
    rs = mboxes;

end

