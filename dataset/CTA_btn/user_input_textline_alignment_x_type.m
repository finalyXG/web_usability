

%%
acc_top_textline_alignment_x_type = [];
page_top_textline_alignment_x_type = [];
% acc_top_textline_alignment_x_type = importdata('acc_top_textline_alignment_x_type.mat');
% page_top_textline_alignment_x_type = importdata('page_top_textline_alignment_x_type.mat');
% return;

% 1 - 3 : top; 4 - 6 : bottom : 7 - 9 : mbox; 0 : unchanged

acci = 0;
for i = 1 : length(page_btn_train_margin_boxes)
    i
    mboxes = page_btn_train_margin_boxes{i};
    nb_elements = page_nb_elements{i};          
    img = page_imgs{i};               
    page_nb_type = page_nb_elements_type{i};
    acc_rs = [];    
    atbs = {D(i).annotation.object.attributes};
    tmp = 0;
    for j = 1 : size(mboxes,1) 
        j
        acci = acci + 1        
        if page_nb_type(j,2) ~= 3
            acc_rs = [acc_rs; tmp];
            continue;
        end
        mbox = mboxes(j,:);
        tmp = 0;
        if ismember('center', cell2mat(atbs(j)))
            tmp = 1;
        end

        acc_rs = [acc_rs; tmp];

    end
    page_top_textline_alignment_x_type{i} = acc_rs;
    acc_top_textline_alignment_x_type = [acc_top_textline_alignment_x_type; acc_rs];

end
%%
% return;
save('acc_top_textline_alignment_x_type.mat','acc_top_textline_alignment_x_type');
save('page_top_textline_alignment_x_type.mat','page_top_textline_alignment_x_type');