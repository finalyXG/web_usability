function [ freq_v ] = get_freq_v_test( freq_sysmetric_analysis, sorted_margin_boxes_test )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    n1 = freq_sysmetric_analysis(:,1);
    n3 = freq_sysmetric_analysis(:,3);
    pool = cell(4,4);
    for i = 1 : size(freq_sysmetric_analysis,1)
        t1 = freq_sysmetric_analysis(i,1);
        t3 = freq_sysmetric_analysis(i,3);
        w1 = freq_sysmetric_analysis(i,5);
        w3 = freq_sysmetric_analysis(i,7);
        mboxh = freq_sysmetric_analysis(i,10);
        mboxw = freq_sysmetric_analysis(i,9);
%         pool{t1,t3} = [pool{t1,t3} ; {[min(w1,w3), mboxh,mboxw, freq_sysmetric_analysis(i,11)]}];
        pool{t1,t3} = [pool{t1,t3} ; {[min(w1,w3),w3, mboxw, mboxh, freq_sysmetric_analysis(i,11)]}];
    end
    
    freq_v = pool;


end