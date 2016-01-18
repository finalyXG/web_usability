

nfd = [];
for i = 1 : size(fd,1)
    tmp1 = [0 0];
    tmp2 = [0 0];
    tmp3 = [0 0];
    tmp4 = [0 0];
    if acc_nb_elements(i,3) > 0 && acc_nb_elements(i,4) > 0
        tmp1 = [acc_mbox2btn_oxoy(i,:) - acc_nb_elements(i,1:2)];        
    end
    if acc_nb_elements(i,7) > 0 && acc_nb_elements(i,8) > 0
        tmp2 = acc_mbox2btn_oxoy(i,:) - acc_nb_elements(i,[5:6]);       
    end
    if acc_nb_elements(i,11) > 0 && acc_nb_elements(i,12) > 0
        tmp3 = acc_mbox2btn_oxoy(i,:) - acc_nb_elements(i,[9:10]);      
    end    
    if acc_nb_elements(i,15) > 0 && acc_nb_elements(i,16) > 0
        tmp4 = acc_mbox2btn_oxoy(i,:) - acc_nb_elements(i,[13:14]);      
    end    
    nfd = [nfd; [fd(i,:), acc_mbox2btn_wh(i,:)] ];
    
%     nfd = [nfd; fd(i,:), acc_mbox2btn_oxoy(i,:) - acc_btn_train_margin_boxes(i,1:2),...
%     acc_mbox2btn_wh(i,:) - acc_btn_train_margin_boxes(i,3:4),...
%      tmp1,...
%      tmp2,...
%      tmp3,...
%      tmp4...
% %  ...
% %  acc_mbox2btn_oxoy(i,2) + acc_mbox2btn_wh(i,2) - acc_nb_elements(i,[2]) - acc_nb_elements(i,[4]),...
% %  acc_mbox2btn_oxoy(i,1) + acc_mbox2btn_wh(i,1) - acc_nb_elements(i,[5]) - acc_nb_elements(i,[7]),...
% %  acc_mbox2btn_oxoy(i,2) + acc_mbox2btn_wh(i,2) - acc_nb_elements(i,[10]) - acc_nb_elements(i,[12]),...
% %  acc_mbox2btn_oxoy(i,1) + acc_mbox2btn_wh(i,1) - acc_nb_elements(i,[13]) - acc_nb_elements(i,[15])...
%  ];

end
fd = nfd;
nfd = [];

save('fd.mat','fd');
