function [ rs1 ] = my_gaussian_process_v( freq_v_test,freq_v,acc_freq_v )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    rs1 = [];
    for i = 1 : size(freq_v,1)
        for j = 1 : size(freq_v,2)
    %         i = 1;
    %         j = 1;
            tmp_test_freq_v = cell2mat(freq_v_test{i,j});
            tmp_test_freq_v0 = tmp_test_freq_v;
            
            tmp_freq = cell2mat(freq_v{i,j}); 
            
            if size(tmp_test_freq_v,1) == 0 
                continue;
            end
            if size(tmp_freq,1) <= 10
                absy_test = zeros(size(tmp_test_freq_v,1),1);
                htest = 0.5 * ones(size(tmp_test_freq_v,1),1);
                htest = 0.5 * tmp_test_freq_v0(:,4);
%                 htest = 80 / tmp_test_freq_v(:,4);
                order = tmp_test_freq_v(:,5);
                rs1 = [rs1; [order htest]];
                continue;
            else
                tmp_freq0 = tmp_freq;
                tmp_freq = normc([tmp_freq(:,:)]);
                scale_factor = tmp_freq0(1,:) ./ tmp_freq(1,:)
                for jj = 1 : 4
                    tmp_test_freq_v(:,jj) = tmp_test_freq_v(:,jj) ./ scale_factor(jj);
                end
                
                htest = my_gpml_reg(tmp_freq(:,[1,3,4]), tmp_freq(:,5), tmp_test_freq_v(:,[1,3,4]), [1; 1; 1; 1],  [0 0 0 1]');     
                htest = htest .* scale_factor(5) .* tmp_test_freq_v0(:,4) ;
                htest(find(htest > 100)) = 80;
                % [15; 15; 20; 0.1]
%                 absy_test = my_gpml_reg(tmp_freq(:,[1,2,3]), tmp_freq(:,6), tmp_test_freq_v(:,[1,2,3]), [15; 15; 20; 0.1], [0 0 0 1]'  );
                % [15; 15; 20; 0.1]
                order = tmp_test_freq_v(:,5);
                rs1 = [rs1; [order htest]];

            end

        end
    end

end

