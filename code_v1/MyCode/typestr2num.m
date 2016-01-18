
tmp_rs = zeros(length(tmp), 1);
for j = 1 : length(tmp)
    n = 0;
    switch (cell2mat(tmp(j)))
        case 'img'
            n = 1;
        case 'input'
            n = 2;
        case 'text'
            n = 3;
        case 'bgi'
            n = 4;
        case 'border'
            n = 5;
        case 'button'
            n = 6;
        case 'icon'
            n = 7;          
    end
    tmp_rs(j) = n;
end