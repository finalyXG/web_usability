

acci = 0;
for i = 1 : length(page_btn_train_margin_boxes)
    mboxes = page_btn_train_margin_boxes{i};
    nb_elements = page_nb_elements{i};
    img = page_imgs{i};
    alignment_x_types = page_alignment_x_type{i};
    i
    for j = 1 : size(mboxes,1)
        j
        alignment_x_type = alignment_x_types(j);
        mbox = mboxes(j,:);
        figure(1),clf,
        imshow(img);
        plot_multi_boxes([mbox;nb_elements(j,1:4); nb_elements(j,5:8); nb_elements(j,9:12); nb_elements(j,13:16)]);
        px = 0;
        py = 0;
        if alignment_x_type == 1
            px = nb_elements(j,5);
            py = nb_elements(j,6) + floor(nb_elements(j,8)/2);
        end
        if alignment_x_type == 2
            px = nb_elements(j,5) + floor(nb_elements(j,7) / 2);
            py = nb_elements(j,6) + floor(nb_elements(j,8)/2);
        end
        if alignment_x_type == 3
            px = nb_elements(j,5) + nb_elements(j,7);
            py = nb_elements(j,6) + floor(nb_elements(j,8)/2);
        end
        if alignment_x_type == 4
            px = nb_elements(j,13);
            py = nb_elements(j,14) + floor(nb_elements(j,16)/2);
        end
        if alignment_x_type == 5
            px = nb_elements(j,13) + floor(nb_elements(j,15) / 2);
            py = nb_elements(j,14) + floor(nb_elements(j,16)/2);
        end
        if alignment_x_type == 6
            px = nb_elements(j,13) + nb_elements(j,15);
            py = nb_elements(j,14) + floor(nb_elements(j,16)/2);
        end
        if alignment_x_type == 7
            px = mbox(1);
            py = mbox(2) + floor(mbox(4) / 2);
        end
        if alignment_x_type == 8
            px = mbox(1) + floor(mbox(3) / 2);
            py = mbox(2) + floor(mbox(4) / 2);
        end        
        if alignment_x_type == 9
            px = mbox(1) + mbox(3);
            py = mbox(2) + floor(mbox(4) / 2);
        end       
        acci = acci + 1
        alignment_x_type
        figure(1),clf,
        imshow(img),hold on,
        plot_multi_boxes([mbox;nb_elements(j,1:4); nb_elements(j,5:8); nb_elements(j,9:12); nb_elements(j,13:16)]);
        plot(px,py,'-k*','MarkerSize',18);        
        hold off;
        
        input('dump');
    end
end