
page_BTN_test_y = [];
for i = 1 : length(page_btn_alignment_y_test)
    mboxes = page_btn_test_candidata_mbox{i};    
    BTN_test = [mboxes(:,1) , mboxes(:,2) , page_BTN_test_w{i}, page_BTN_test_h{i}]; 
    x_alignment_types = page_btn_alignment_y_test{i};
    nb_elements = page_nb_elements_test{i};
    tmp_rs = [];
    btn_dys = page_btn_dy{i};
%     btn_dys = zeros(size(page_btn_dy{i}));
    for j = 1 : size(mboxes,1)
        tmp = [];
        switch(x_alignment_types(j))
            case 1
                tmp = nb_elements(j,2);
            case 2
                tmp = round(nb_elements(j,2) + 0.5 * nb_elements(j,4) - 0.5 * BTN_test(j,4));
            case 3
                tmp = nb_elements(j,2) + nb_elements(j,4) - BTN_test(j,4) ;
            case 4
                tmp = nb_elements(j,10);
            case 5
                tmp = round(nb_elements(j,10) + 0.5 * nb_elements(j,12) - 0.5 * BTN_test(j,4));
            case 6
                tmp = nb_elements(j,10) + nb_elements(j,12) - BTN_test(j,4);
            case 7
                tmp = mboxes(j,2) + btn_dys(j);
            case 8
                tmp = round(mboxes(j,2) + 0.5 * mboxes(j,4) - 0.5 * BTN_test(j,4));
            case 9
                tmp = mboxes(j,2) + mboxes(j,4) - BTN_test(j,4) - btn_dys(j);
            otherwise
                input('bugs!!!!!');
                return;
        end
        tmp_rs = [tmp_rs; tmp];
    end
    page_BTN_test_y{i} = tmp_rs;
end

