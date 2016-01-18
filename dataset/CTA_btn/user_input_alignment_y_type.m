

acc_alignment_y_type = [];
page_alignment_y_type = [];
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
        if strfind(cell2mat(atbs(j)),'yt1')
            tmp = 1;
        end
        if strfind(cell2mat(atbs(j)),'yt2')
            tmp = 2;
        end
        if strfind(cell2mat(atbs(j)),'yt3')
            tmp = 3;
        end  
        if strfind(cell2mat(atbs(j)),'yt4')
            tmp = 4;
        end
        if strfind(cell2mat(atbs(j)),'yt5')
            tmp = 5;
        end
        if strfind(cell2mat(atbs(j)),'yt6')
            tmp = 6;
        end
        if strfind(cell2mat(atbs(j)),'yt7')
            tmp = 7;
        end
        if strfind(cell2mat(atbs(j)),'yt8')
            tmp = 8;
        end
        if strfind(cell2mat(atbs(j)),'yt9')
            tmp = 9;
        end              

        acc_rs = [acc_rs; tmp];

    end

    page_alignment_y_type{i} = acc_rs; 
    acc_alignment_y_type = [acc_alignment_y_type; acc_rs];

end

save('acc_alignment_y_type.mat','acc_alignment_y_type');
save('page_alignment_y_type','page_alignment_y_type');



return;
%%


% page_alignment_y_type = [];
page_alignment_y_type = importdata('page_alignment_y_type.mat');
acc_alignment_y_type = importdata('acc_alignment_y_type.mat');
return;
% 0 - 9 : 1 - 3 : top; 4 - 6 : bottom : 7 - 9 : mbox; 0 : unchanged



%%
acci = 0;
acc_ind = 114;
for i = 1 : length(page_btn_train_margin_boxes)
    
    mboxes = page_btn_train_margin_boxes{i};
    nb_elements = page_nb_elements{i};
    img = page_imgs{i};
    acc_rs = zeros(size(mboxes,1),1);
    for j = 1 : size(mboxes,1) 
        acci = acci + 1               
        if acci < acc_ind
            continue;
        else
            acc_ind = acci;
        end
        mbox = mboxes(j,:);
        figure(1),clf,
        imshow(img);
        plot_multi_boxes([mbox;nb_elements(j,1:4); nb_elements(j,5:8); nb_elements(j,9:12); nb_elements(j,13:16)]);
        tmp = input('1 - 3 : left; 4 - 6 : right : 7 - 9 : mbox; 0 : unchanged : ');        
        acc_rs(j) = tmp;
        
    end
    if acci == acc_ind 
        page_alignment_y_type{i} = acc_rs;
        acc_alignment_y_type = [acc_alignment_y_type; acc_rs];
    end

end
%%
save('acc_alignment_y_type.mat','acc_alignment_y_type');
save('page_alignment_y_type','page_alignment_y_type');