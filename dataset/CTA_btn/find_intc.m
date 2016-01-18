function [ rs,rstype ] = find_intc( mbox,elements,etypes,dump )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    if nargin == 4
        rs = dump;
    else
        rs = zeros(1,4);
    end
    
    rstype = 0;
    for i = 1 : size(elements,1)
        area = rectint(mbox,elements(i,:));
        if area > 0 && (area <= mbox(4) || area <= mbox(3) || area <= elements(i,3) || area <= elements(i,4))
            
            if (etypes(i,:) == 1 || etypes(i,:) == 4) &&...% image or background image
                    elements(i,3) * elements(i,4) > 800 * 600
                continue
            end
            
            if etypes(i,:) == 5 && (elements(i,3) * elements(i,4) > 600 * 300 || elements(i,3) > 500)
                continue;
            end
            
            rs = elements(i,:);
            rstype = etypes(i,:);
            return;
        end
    end
    
end

