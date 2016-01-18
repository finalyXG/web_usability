function [ freq_w ] = get_freq_w_test( freq_sysmetric_analysis, sorted_margin_boxes_test )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    n2 = freq_sysmetric_analysis(:,2);
    n4 = freq_sysmetric_analysis(:,4);
    pool = cell(4,4);
    for i = size(freq_sysmetric_analysis,1):-1:1
        t2 = freq_sysmetric_analysis(i,2);
        t4 = freq_sysmetric_analysis(i,4);
        w2 = freq_sysmetric_analysis(i,6);
        w4 = freq_sysmetric_analysis(i,8);
        mboxh = freq_sysmetric_analysis(i,10);
        mboxw = freq_sysmetric_analysis(i,9);

        if t2 < 5 && t4 < 5
            pool{t2,t4} = [pool{t2,t4} ; {[min(w2,w4),w2, mboxw, mboxh, freq_sysmetric_analysis(i,11)]}];
%             pool{t2,t4} = [pool{t2,t4} ; {[min(w2,w4), mboxh,mboxw, freq_sysmetric_analysis(i,11)]}];
%         else
%             freq_sysmetric_analysis(i,:) = [];
%             sorted_margin_boxes_test(i,:) = [];
        end
    end
    
    freq_w = pool;

end

