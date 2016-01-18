function [ freq_v, acc_freq_v ] = get_freq_v( freq_sysmetric_analysis, acc_btn_train_margin_boxes, acc_mbox2btn_wh, acc_mbox2btn_xy )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    n1 = freq_sysmetric_analysis(:,1);
    n3 = freq_sysmetric_analysis(:,3);
    acc_freq_v = [];
    pool = cell(4,4);
    for i = 1 : size(freq_sysmetric_analysis,1)
        t1 = freq_sysmetric_analysis(i,1);
        t3 = freq_sysmetric_analysis(i,3);
        w1 = freq_sysmetric_analysis(i,5);
        w3 = freq_sysmetric_analysis(i,7);
        btnh = acc_mbox2btn_wh(i,2);
        btny = acc_mbox2btn_xy(i,2);
        mboxy = acc_btn_train_margin_boxes(i,2);
        mboxh = freq_sysmetric_analysis(i,10);
        mboxw = freq_sysmetric_analysis(i,9);
%         pool{t1,t3} = [pool{t1,t3} ; {[min(w1,w3), mboxh, mboxw, btnh, abs(mboxy - btny)]}];
        one = [min(w1,w3),w3, mboxw, mboxh, btnh/mboxh, abs(mboxy - btny)/mboxh];
        acc_freq_v = [acc_freq_v; one];
        pool{t1,t3} = [pool{t1,t3} ; {one}];
        
    end
    
    freq_v = pool;


end

