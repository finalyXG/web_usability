% fd_dy_train_proc


% fd_alignment_train = importdata('fd_alignment_train.mat'); 
% return; 
page_nb_top_textline_alignment_x_type_test;

acc_top_exist_test = [];
fd_alignment_test = [];
page_fd_alignment_test = [];

for i = 1 : length(page_btn_test_margin_boxes)
    mboxes = page_btn_test_margin_boxes{i};
    BTNs = [mboxes(:,1) mboxes(:,2) page_BTN_test_w{i} page_BTN_test_h{i}];
    nb_elements = page_nb_elements_test{i};
    top_textline_types = page_nb_top_textline_alignment_x_type_test{i};
    page_width = size(page_imgs_test{i},2);
    page_nb_elements_types = page_nb_elements_type_test{i};
    
    page_fd_alignment_test{i} = [];
    acc_rs = [];
%     img = page_imgs_test{i};
%     figure(1),
%     imshow(img),hold on,
% %     plot_multi_boxes([BTNs]);
%     plot_multi_boxes([mboxes]);
%     hold off;
%     return;

    for j = 1 : size(mboxes,1)
        mark = 0;
        for k = 1 : size(BTNs,1)
            BTN = BTNs(k,:);
            if BTN(3) > mboxes(k,3)
                BTN(3) = mboxes(k,3);
            end
            if rectint(BTN, mboxes(j,:)) ==  BTN(3) * BTN(4)  
                mark = 1;
                break;
            end
        end         
        if mark == 0
            a = 'bugs!!!!'
            i
            j
            return;
        end
        
        mbox = mboxes(j,:);
        nb_4element = nb_elements(j,:);
%         if nb_4element(3) == 0
%             nb_4element([1,2]) = 0;
%         end
%         if nb_4element(7) == 0
%             nb_4element([5,6]) = 0;
%         end
%         if nb_4element(11) == 0
%             nb_4element([9,10]) = 0;
%         end
%         if nb_4element(15) == 0
%             nb_4element([13,14]) = 0;
%         end
        
        etypes = page_nb_elements_types(j,:);
        
        top_text_type_encode = zeros(1,3);
        top_text_type_encode( top_textline_types(j) + 1) = 1;
        top_text_type_encode = [top_text_type_encode(:,1) + top_text_type_encode(:,2), top_text_type_encode(:,3)];
        
        p1 = page_width;
        b1 = BTN(1) / page_width;
        b2 = BTN(3) / mbox(3);
        d0 = [BTN(3:4), BTN(3)*BTN(4) / mbox(3)*mbox(4)];
        d1 = [mbox(3:4), mbox(3)*mbox(4)];
        
        d3 = abs([abs(nb_4element(2) - mbox(2)) - abs(nb_4element(2)+nb_4element(4) - mbox(2)-mbox(4))]);
        d3 = [abs(nb_4element(2)+nb_4element(2)*0.5 - mbox(2)+mbox(4)*0.5), d3];
%         d3 = [d3, var(d3)];
        d4 = [nb_4element(3:4), nb_4element(3)*nb_4element(4)];
%         d5 = nb_4element(5:6) - mbox(1:2);
        d5 = abs([abs(nb_4element(5) - mbox(1)) - abs(nb_4element(5)+nb_4element(7) - mbox(1)-mbox(3))]);        
        d5 = [abs(nb_4element(5)+nb_4element(7)*0.5 - mbox(1)+mbox(3)*0.5), d5];
%         d5 = [d5, var(d5)];
        d6 = [nb_4element(7:8), nb_4element(7)*nb_4element(8)];  
        
        d7 = abs([ abs(nb_4element(10) - mbox(2)) - abs(nb_4element(10)+nb_4element(12) - mbox(2)-mbox(4))]);        
        d7 = [abs(nb_4element(10)+nb_4element(12)*0.5 - mbox(2)+mbox(4)*0.5), d7];
%         d7 = [d7, var(d7)];
        % d7 = nb_4element(9:10) - mbox(1:2);        
        d8 = [nb_4element(11:12), nb_4element(11)*nb_4element(12)]; 
        
        
%         d9 = nb_4element(13:14) - mbox(1:2);
        d9 = abs([ abs(nb_4element(13) - mbox(1)) - abs(nb_4element(13)+nb_4element(15) - mbox(1)-mbox(3))]); 
        d9 = [abs(nb_4element(13)+nb_4element(15)*0.5 - mbox(1)+mbox(3)*0.5), d9];

        
        d10 = [nb_4element(15:16), nb_4element(15)*nb_4element(16)]; 
        d11 = nb_4element(13) + 0.5 * nb_4element(15) - (mbox(1) + 0.5 * mbox(3));
        d12 = nb_4element(13) + nb_4element(15) - mbox(1) - mbox(3);
        d13 = (mbox(3) - BTN(3)) / mbox(3);        
        d14 = (mbox(3) - BTN(3)) * 0.5; 
        c1 = (nb_4element(5) + nb_4element(7) * 0.5);
        c2 = (nb_4element(13) + nb_4element(15) * 0.5);
        c3 = (mbox(1) + 0.5*mbox(3));
        c4 = var([c1,c3]);
        c5 = var([c1,c2]);
        c6 = var([c2,c3]);
        c7 = (nb_4element(5) + nb_4element(7) * 0.5) / page_width;
        c8 = (mbox(1) + mbox(3) * 0.5) / page_width;
        c9 = var([c7 c8]);
        z1 = [nb_4element(13)+nb_4element(15)*0.5 - BTN(3)-mbox(1) > 0,...
                nb_4element(5)+nb_4element(7)*0.5 - BTN(3)-mbox(1) > 0];

        
        top_bottom_exist = zeros(1,2);
        if nb_4element(7) > 0
            top_bottom_exist(1) = 1;
        end
        acc_top_exist_test = [acc_top_exist_test; top_bottom_exist(1)];
        
        if nb_4element(15) > 0
            top_bottom_exist(2) = 1;
        end  
        left_right_exist = zeros(1,2);
        if nb_4element(3) > 0
            left_right_exist(1) = 1;
        end
        if nb_4element(11) > 0
            left_right_exist(2) = 1;
        end 

%         if nb_4element(3) == 0
%             d3 = ones(size(d3)) * Inf;
%         end
%         if nb_4element(7) == 0
%             d5 = ones(size(d5)) * Inf;
%         end
%         if nb_4element(11) == 0
%             d7 = ones(size(d7)) * Inf;
%         end
%         if nb_4element(15) == 0
%             d9 = ones(size(d9)) * Inf;
%         end
        
        tmp = [etypes top_text_type_encode top_bottom_exist left_right_exist c4 c5 c6 c7 d0 d1 d3 d4 d5 d6 d7 d8 d9 d10 d13 d14  ];
        
%         if etypes(2) == 2
%             tmp = zeros(size(tmp));
%             tmp(1:4) = etypes(1:4);
%             tmp(1 + 4) = 1; % skip the first 4 element, further usage
%         end
%         if c7 > 0.45 && c7 < 0.55
%             tmp = zeros(size(tmp));
%             tmp(1:4) = etypes(1:4);            
%             tmp(1 + 4) = 1;
%         end
%         if top_text_type_encode(2) == 1
%             tmp = zeros(size(tmp));
%             tmp(1:4) = etypes(1:4);            
%             tmp(1 + 4) = 1; 
%         end
%         if etypes(2) == 1 && abs(mbox(1) + 0.5*mbox(3) - nb_4element(5) - nb_4element(7) * 0.5) < 20            
%             tmp = zeros(size(tmp));
%             tmp(1:4) = etypes(1:4);            
%             tmp(1 + 4) = 1;
%         end        
        fd_alignment_test = [fd_alignment_test ; tmp];
        acc_rs = [acc_rs; tmp];
    end
    page_fd_alignment_test{i} = acc_rs;
end


save('fd_alignment_test.mat','fd_alignment_test');




