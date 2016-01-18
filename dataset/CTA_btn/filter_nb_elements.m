% for i = 1 : length(page_nb_elements)
%     nb_elements = page_nb_elements{i};
%     nb_types = page_nb_elements_type{i};
%     mboxes = page_btn_train_margin_boxes{i};
%     
%     for j = 1 : size(mboxes,1)
%         
%         dleft = nb_elements(1:4);
%         dbottom = nb_elements(5:8);
%         dright = nb_elements(9:12);
%         dtop = nb_elements(13:16);
%         if nb_types(1) == 5 && dleft(3) * dleft(4) > 200 * 10
%             nb_types(1) = 0;
% 
%         end
%         
%     end
% end
