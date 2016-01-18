function [ rs2 ] = my_gaussian_process_w( freq_w_test,freq_w,acc_freq_w )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    rs2 = [];
    for i = 1 : size(freq_w,1)
        for j = 1 : size(freq_w,2)
    %         i = 4;
    %         j = 2;
            tmp_test_freq_w = cell2mat(freq_w_test{i,j});
            tmp_test_freq_w0 = tmp_test_freq_w;
            tmp_freq = cell2mat(freq_w{i,j}); 
            
            if size(tmp_test_freq_w,1) == 0 
                continue;
            end
            
            if size(tmp_freq,1) <= 1
                absx_test = zeros(size(tmp_test_freq_w,1),1);
                wtest = zeros(size(tmp_test_freq_w,1),1);
                wtest = 2.5 * ones(size(tmp_test_freq_w,1),1);
%                 wtest = 2;
                order = tmp_test_freq_w(:,5);
                rs2 = [rs2; [order wtest]];
            else
            
                tmp_freq0 = tmp_freq;
                tmp_freq = normc([tmp_freq(:,:)]);
                scale_factor = tmp_freq0(1,:) ./ tmp_freq(1,:)
                
                for jj = 1 : 4
                    tmp_test_freq_w(:,jj) = tmp_test_freq_w(:,jj) ./ scale_factor(jj);
                end
                wtest = my_gpml_reg(tmp_freq(:,[1,3,4]), tmp_freq(:,5), tmp_test_freq_w(:,[1,3,4]), [1; 1; 1; 1],  [0 0 0 1]');   %[15; 15; 20; 0.1]  
                wtest = wtest .* scale_factor(5) ;
%                 wtest = my_gpml_reg(tmp_freq(:,[1,2,3]), tmp_freq(:,5), tmp_test_freq_w(:,[1,2,3]) , [15; 15; 20; 0.1], [0 0 0 1]');
                % [15; 15; 10; 0.5]
%                 absx_test = my_gpml_reg(tmp_freq(:,[1,2,3]), tmp_freq(:,6), tmp_test_freq_w(:,[1,2,3]) , [15; 15; 20; 0.1], [0 0 0 1]');
                % [15; 15; 10; 0.5]
%                 rs2
                wtest(find(wtest > 5.5 | wtest < 3)) = 3.2; 
                order = tmp_test_freq_w(:,5);
%                 wtest
                rs2 = [rs2; [order wtest]];
    %             htest = my_gpml_reg(tmp_freq(:,1:3), tmp_freq(:,4));
            end
    %         return;

        end
    end

end

