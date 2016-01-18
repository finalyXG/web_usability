% match BTNs to btns in right order
acc_BTNs = [];
for i = 1 : length(page_btn_train_margin_boxes)
    mboxes = page_btn_train_margin_boxes{i};
    BTNs = page_BTNs{i};
    BTNs_rord = [];
    BTNs_objects = [];
    for j = 1 : size(mboxes,1)  
        tmp_D = LMquery(D(i),'object.attributes','learn_btn');
        tmp_BTN = LMobjectboundingbox(tmp_D.annotation);     
        tmp_BTN = [tmp_BTN(:,1) tmp_BTN(:,2) tmp_BTN(:,3)-tmp_BTN(:,1) tmp_BTN(:,4)-tmp_BTN(:,2)];
        for k = 1 : size(tmp_BTN,1)            
            if rectint(mboxes(j,:),tmp_BTN(k,:)) > 0
                BTNs_rord = [BTNs_rord; tmp_BTN(k,:)];
                BTNs_objects = [BTNs_objects; tmp_D.annotation.object(k)];
                break;
            end
        end        
        
    end
    D(i).annotation.object = BTNs_objects;
    page_BTNs{i} = BTNs_rord;
    acc_BTNs = [acc_BTNs; BTNs_rord];
end

save('page_BTNs.mat','page_BTNs');
save('acc_BTNs.mat','acc_BTNs');