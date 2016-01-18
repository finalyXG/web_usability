function [ rs, acc_mbox2btn_wh,acc_mbox2btn_xy, acc_mbox2btn_oxoy,acc_mbox2btn_exey ] = get_mbox2btn_wh( page_four_edges_analysis, page_btn_train_margin_boxes, page_btns )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    rs = [];
    acc_mbox2btn_wh = [];
    acc_mbox2btn_xy = [];
    acc_mbox2btn_oxoy = [];
    acc_mbox2btn_exey = [];
    for i = 1 : length(page_four_edges_analysis)
        four_edges = page_four_edges_analysis{i};
        mboxes = page_btn_train_margin_boxes{i};
        btns = page_btns{i};
        page_rs = [];
       
        for k = 1 : size(mboxes,1)
             for j = 1 : size(btns,1)
                if rectint(mboxes(k,:),btns(j,:)) > btns(j,3) * btns(j,4) * 0.95 &&...
                    mboxes(k,1) - 2 < btns(j,1) && btns(j,1) + btns(j,3) < mboxes(k,1) + mboxes(k,3) + 2 &&...
                        mboxes(k,2) - 2 < btns(j,2) && btns(j,2) + btns(j,4) < mboxes(k,2) + mboxes(k,4) + 2
                    
                    
                    four_edge = {four_edges{k,:}};
                    four_edge = [four_edge , {btns(j,3)}, {btns(j,4)}];
                    page_rs = [page_rs ; four_edge];
                    acc_mbox2btn_wh = [acc_mbox2btn_wh; [btns(j,3) btns(j,4)]];
%                     acc_mbox2btn_xy = [acc_mbox2btn_xy; [round(btns(j,1) + 0.5 * btns(j,3) -  mboxes(k,1) - 0.5 * mboxes(k,3) ), round(btns(j,2) -  mboxes(k,2)) ]];
                    acc_mbox2btn_xy = [acc_mbox2btn_xy; [round(btns(j,1) - mboxes(k,1) ), round(btns(j,2) -  mboxes(k,2)) ]];
                    acc_mbox2btn_oxoy = [acc_mbox2btn_oxoy; btns(j,1:2) ];
                    acc_mbox2btn_exey = [acc_mbox2btn_exey; mboxes(k,1:2)+ mboxes(k,3:4) - btns(j,1:2) - btns(j,3:4)];
%                     acc_mbox2btn_xy = [acc_mbox2btn_xy; [round(btns(j,1) -  mboxes(k,1) ), round(btns(j,2) -  mboxes(k,2) ) ] ];
                end
            end
        end
        
        rs{i} = page_rs;
        
    end

end

