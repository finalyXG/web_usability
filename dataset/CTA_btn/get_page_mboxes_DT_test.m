page_elements_masks = page_elements_masks_test;
page_btn_margin_boxes = page_btn_test_margin_boxes;

page_mboxes_DT = [];
interval = 5;
interval2 = 2;

% imcontour(Dbwmask);
for i = 1 : length(page_btn_margin_boxes)
    bwmask = im2bw(page_elements_masks{i});
    Dbwmask = bwdist(bwmask,'chessboard');
    
    mboxes = page_btn_margin_boxes{i};
    mbox_DTs = [];
    for j = 1 : size(mboxes,1)
        mbox = mboxes(j,:);
        bottom_line  = [mbox(1) mbox(2); mbox(1)+mbox(3) mbox(2)];
        top_line = [mbox(1)+mbox(3) mbox(2); mbox(1)+mbox(3) mbox(2)+mbox(4)];
        dx = round(mbox(3) / interval * [0:interval]); 
        dy = round(mbox(4) / interval2 * [0:interval2]);
        candpx = mbox(1) + dx;
        candpy = mbox(2) + dy;
        
        tmp_DT_r00 = Dbwmask( candpy , mbox(1))'; 
        tmp_DT_r0 = Dbwmask( mbox(2) ,candpx);
        tmp_DT_r = Dbwmask( round(mbox(2) + mbox(4) * 0.5) ,candpx);
        tmp_DT_r1 = Dbwmask( mbox(2)+mbox(4) ,candpx);
        tmp_DT_r11 = Dbwmask( candpy , mbox(1) + mbox(3))';
        
        one_mbox_DT = [tmp_DT_r00 tmp_DT_r0  tmp_DT_r tmp_DT_r1 tmp_DT_r11];
        mbox_DTs = [mbox_DTs ; one_mbox_DT ];        
    end
    page_mboxes_DT{i} = mbox_DTs;
    
end

page_mboxes_DT;
page_mboxes_DT_test = page_mboxes_DT;

save('page_mboxes_DT_test.mat','page_mboxes_DT_test');

