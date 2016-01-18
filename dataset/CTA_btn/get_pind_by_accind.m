
tmp = 0;
for i = 1 : length(page_BTNs)
    BTNs = page_BTNs{i};
    for j = 1 : size(BTNs,1)
        tmp = tmp + 1;
        if tmp == acc_ind 
            Bid = j
            break;
        end
    end
    if tmp == acc_ind 
        pid = i
        break;
    end
end