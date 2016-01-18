
page_BTN_test_x = [];
for i = 1 : length(page_btn_alignment_test)
    mboxes = page_btn_test_candidata_mbox{i};    
    BTN_test = [mboxes(:,1) , mboxes(:,2) , page_BTN_test_w{i}, page_BTN_test_h{i}]; 
    x_alignment_types = page_btn_alignment_test{i};
    nb_elements = page_nb_elements_test{i};
    tmp_rs = [];
    btn_dxes = page_btn_dx{i};
%     btn_dxes = zeros(size(page_btn_dx{i}));
    for j = 1 : size(mboxes,1)
        tmp = [];
        switch(x_alignment_types(j))
            case 1
                tmp = nb_elements(j,5);
            case 2
                tmp = round(nb_elements(j,5) + 0.5 * nb_elements(j,7) - 0.5 * BTN_test(j,3));
            case 3
                tmp = nb_elements(j,5) + nb_elements(j,7) - BTN_test(j,3) ;
            case 4
                tmp = nb_elements(j,13);
            case 5
                tmp = round(nb_elements(j,13) + 0.5 * nb_elements(j,15) - 0.5 * BTN_test(j,3));
            case 6
                tmp = nb_elements(j,13) + nb_elements(j,15) - BTN_test(j,3);
            case 7
                tmp = mboxes(j,1) + btn_dxes(j);
            case 8
                tmp = round(mboxes(j,1) + 0.5 * mboxes(j,3) - 0.5 * BTN_test(j,3));
            case 9
                tmp = mboxes(j,1) + mboxes(j,3) - BTN_test(j,3) - btn_dxes(j);
            otherwise
                input('bugs!!!!!');
                return;
        end
        tmp_rs = [tmp_rs; tmp];
    end
    page_BTN_test_x{i} = tmp_rs;
end


%%
return;
grade = 'B';
   switch(grade)
   case 'A' 
      fprintf('Excellent!\n' );
   case 'B' 
      fprintf('Well done\n' );
   case 'C' 
      fprintf('Well done\n' );
   case 'D'
      fprintf('You passed\n' );
   
   case 'F' 
      fprintf('Better try again\n' );
     
   otherwise
      fprintf('Invalid grade\n' );
   end