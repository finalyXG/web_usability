

nfd = [];
for i = 1 : size(fd_test,1)
    tmp1 = [0 0];
    tmp2 = [0 0];
    tmp3 = [0 0];
    tmp4 = [0 0];
    
    if acc_nb_elements(i,3) > 0 && acc_nb_elements(i,4) > 0
        tmp1 = plbtn0(i,1:2) - acc_nb_elements(i,[1:2]);       
    end
    if acc_nb_elements(i,7) > 0 && acc_nb_elements(i,8) > 0
        tmp2 = plbtn0(i,1:2) - acc_nb_elements(i,[5:6]);      
    end
    if acc_nb_elements(i,11) > 0 && acc_nb_elements(i,12) > 0
        tmp3 = plbtn0(i,1:2) - acc_nb_elements(i,[9:10]);      
    end    
    if acc_nb_elements(i,15) > 0 && acc_nb_elements(i,16) > 0
        tmp4 = plbtn0(i,1:2) - acc_nb_elements(i,[13:14]);      
    end 
    nfd = [nfd; [fd_test(i,:), plbtn0(i,3:4)] ];
%     nfd = [nfd; fd_test(i,:), plbtn0(i,1:2) - plbox0(i,1:2),...
%         plbtn0(i,3:4) - plbox0(i,3:4),...
%         tmp1,...
%         tmp2,...
%         tmp3,...
%         tmp4...
% %  ...
% %  plbtn0(i,2) + plbtn0(i,4) - acc_nb_elements(i,[2]) - acc_nb_elements(i,[4]),...
% %  plbtn0(i,1) + plbtn0(i,3) - acc_nb_elements(i,[5]) - acc_nb_elements(i,[7]),...
% %  plbtn0(i,2) + plbtn0(i,4) - acc_nb_elements(i,[10]) - acc_nb_elements(i,[12]),...
% %  plbtn0(i,1) + plbtn0(i,3) - acc_nb_elements(i,[13]) - acc_nb_elements(i,[15])...
%  ];


end
fd_test = nfd;
nfd = [];
save('fd_test.mat','fd_test');