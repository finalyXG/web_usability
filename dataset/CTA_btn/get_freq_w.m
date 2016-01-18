function [ freq_w, acc_freq_w ] = get_freq_w( freq_sysmetric_analysis, acc_btn_train_margin_boxes, acc_mbox2btn_wh, acc_mbox2btn_xy )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    n2 = freq_sysmetric_analysis(:,2);
    n4 = freq_sysmetric_analysis(:,4);
    acc_freq_w = [];

    pool = cell(4,4);
    for i = 1 : size(freq_sysmetric_analysis,1)
        t2 = freq_sysmetric_analysis(i,2);
        t4 = freq_sysmetric_analysis(i,4);
        w2 = freq_sysmetric_analysis(i,6);
        w4 = freq_sysmetric_analysis(i,8);
        btnw = acc_mbox2btn_wh(i,1);
        btnh = acc_mbox2btn_wh(i,2);
        btnx = acc_mbox2btn_xy(i,1);
        mboxx = acc_btn_train_margin_boxes(i,1);
        mboxh = freq_sysmetric_analysis(i,10);
        mboxw = freq_sysmetric_analysis(i,9);
%         one = get_freq_one(w2,w4,mboxw,mboxh
        one = [min(w2,w4),w2, mboxw, mboxh, btnw/btnh, abs(mboxx - btnx)/mboxw];
        pool{t2,t4} = [pool{t2,t4} ; {one}];
        acc_freq_w = [acc_freq_w ; one];
%         pool{t2,t4} = [pool{t2,t4} ; {[min(w2,w4), mboxh,mboxw, btnw, abs(mboxx - btnx)]}];
    end
    
    freq_w = pool;

end

