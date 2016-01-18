
acc_alignment_x_type = [];
page_alignment_x_type = [];
acci = 0;
for i = 1 : length(page_btn_train_margin_boxes)
    i 
    mboxes = page_btn_train_margin_boxes{i};
    nb_elements = page_nb_elements{i};
    img = page_imgs{i};
    acc_rs = [];
    tmpD_button = LMquery(D(i),'object.attributes' ,'learn_btn');
    atbs = {tmpD_button.annotation.object.attributes};    
    tmp = 0;
    for j = 1 : size(mboxes,1) 
        acci = acci + 1;              
        mbox = mboxes(j,:);
        tmp = 0;        
        if strfind(cell2mat(atbs(j)),'xt1')
            tmp = 1;
        end
        if strfind(cell2mat(atbs(j)),'xt2')
            tmp = 2;
        end
        if strfind(cell2mat(atbs(j)),'xt3')
            tmp = 3;
        end  
        if strfind(cell2mat(atbs(j)),'xt4')
            tmp = 4;
        end
        if strfind(cell2mat(atbs(j)),'xt5')
            tmp = 5;
        end
        if strfind(cell2mat(atbs(j)),'xt6')
            tmp = 6;
        end
        if strfind(cell2mat(atbs(j)),'xt7')
            tmp = 7;
        end
        if strfind(cell2mat(atbs(j)),'xt8')
            tmp = 8;
        end
        if strfind(cell2mat(atbs(j)),'xt9')
            tmp = 9;
        end              

        acc_rs = [acc_rs; tmp];

    end
    page_alignment_x_type{i} = acc_rs;
    acc_alignment_x_type = [acc_alignment_x_type; acc_rs];

end

save('acc_alignment_x_type.mat','acc_alignment_x_type');
save('page_alignment_x_type','page_alignment_x_type');

return;








%%
return;
acc_alignment_x_type = importdata('acc_alignment_x_type.mat');
page_alignment_x_type = importdata('page_alignment_x_type.mat');
 % 1 - 3 : top; 4 - 6 : bottom : 7 - 9 : mbox; 0 : unchanged
acci = 0;
for i = 1 : length(page_btn_train_margin_boxes)
    i
    mboxes = page_btn_train_margin_boxes{i};
    nb_elements = page_nb_elements{i};
    img = page_imgs{i};
    acc_rs = page_alignment_x_type{i};
    
    for j = 1 : size(mboxes,1) 
        j
        acci = acci + 1
        mbox = mboxes(j,:);
        figure(1),clf,
        imshow(img);
        plot_multi_boxes([mbox;nb_elements(j,1:4); nb_elements(j,5:8); nb_elements(j,9:12); nb_elements(j,13:16)]);
        acc_rs(j)
        tmp = input('1 - 3 : top; 4 - 6 : bottom : 7 - 9 : mbox; 0 : unchanged : ');
        if isempty(tmp)
            continue;
        end
        acc_rs(j) = tmp;
%         acc_rs = [acc_rs; tmp];
         
    end
    page_alignment_x_type{i} = acc_rs;
    acc_alignment_x_type = [acc_alignment_x_type; acc_rs];

end
%%
save('acc_alignment_x_type.mat','acc_alignment_x_type');
save('page_alignment_x_type','page_alignment_x_type');

return;
