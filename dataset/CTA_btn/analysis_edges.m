function [ rs ] = analysis_edges(boxes, mask)

%     boxes = [1,1,8,6]; 
%     mask = [...
%             0 2 2 2 0 0 1 1;...
%             0 1 0 0 0 0 0 3;...
%             0 1 0 0 0 0 0 3;...
%             0 0 0 0 0 0 0 2;...
%             0 0 0 0 0 0 0 2;...
%             0 3 0 0 0 0 0 2;...
%             ]
    min_len = 6;
    boxes_edges_info = [];   
    img_size = size(mask);
%     img_size = img_size(1:2);
    for i = 1 : size(boxes,1)
%         i = 64
        box = boxes(i,:); 
        box(3) = box(3) + 1;
        box(4) = box(4) + 1;
        left_edge = [box(2), box(1), box(2)+ box(4) - 1, box(1)];
        top_edge = [box(2) + box(4) - 1, box(1), box(2)+box(4) - 1,  box(1)+box(3)-1];
        right_edge = [box(2), box(1)+box(3)-1, box(2) + box(4)-1, box(1)+box(3)-1];
        bottom_edge = [box(2),box(1), box(2), box(1) + box(3)-1];
        edges = [left_edge; top_edge; right_edge; bottom_edge;];
        box_edges_info = [];
        
        for j = 1 : size(edges,1)
%             j
            edge = edges(j,:);
            pt1 = edge(1:2);
            pt2 = edge(3:4);
            leni = pt2(1) - pt1(1);
            lenj = pt2(2) - pt1(2);
            len = max([leni,lenj]);
            di = leni > 0;
            dj = lenj > 0;
            major_len = 0;
            major_mark = 0;
            
            start_pt = pt1 + [di dj] ;
            start_mark = mask(start_pt(1),start_pt(2));

            edge_split_stack = [];
            acc = 1;
%             img_size
%             start_pt
%             len
            while acc < len
                tmp_len = 0;
                while (acc < len ) ...
                            && (mask(start_pt(1),start_pt(2)) == start_mark)   
%                         && (start_pt(1) <= img_size(2)) && (start_pt(2) <= img_size(1))...
                    start_pt = start_pt + [di dj];
                    tmp_len = tmp_len + 1 ;
                    acc = acc + 1;
                end              
                if tmp_len > min_len
                    if start_mark > 0 && tmp_len > major_len
                        major_len = tmp_len;
                        major_mark = start_mark;
                    end
                    edge_split_stack = [edge_split_stack; [ tmp_len, start_mark]];
                end
                if acc < len
                    start_mark = mask(start_pt(1),start_pt(2));
                end
%                 start_pt
%                 if (start_pt(1) > img_size(2)) || (start_pt(2) > img_size(1))
%                     break;
%                 end
            end
            
            edge_split_stack = handle_multiple_blank_split(edge_split_stack);
            box_edges_info{j} = edge_split_stack;
            box_edges_info{j + 4} = major_mark;
            box_edges_info{j + 8} = size(edge_split_stack,1);
            box_edges_info{j + 12} = get_len_ratio(edge_split_stack(:,1));
        end
        boxes_edges_info{i} =  box_edges_info;
        
    end
    rs = boxes_edges_info;

end

