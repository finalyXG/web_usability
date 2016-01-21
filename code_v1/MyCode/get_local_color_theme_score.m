

%% global 4-color theme from whole region of image

local_score = cell(length(page_imgs_test),1);
fit = importdata('color_fit.mat');
rgb_color = [];
generate_grid_color_space


for i = 12 : length(page_imgs_test)
    img_size = size(page_imgs_test{i});
    img_w = img_size(2);
    img_h = img_size(1);
    img_test = page_imgs_test{i};
    c_rgb = [];
    c_rgb_v = [];
    tic
    for j = 1 : size(page_BTN_test{i},1)
        tic
        check_region_w = 400;
        check_region_h = 300;
        BTN = page_BTN_test{i}(j,:);

        x = BTN(1) + 0.5 * BTN(3) - check_region_w * 0.5;        
        
        if BTN(1) + 0.5 * BTN(3) - check_region_w * 0.5 <= 0 
            x = 1;
        end
        
        if BTN(1) + 0.5 * BTN(3) + check_region_w * 0.5 >= img_w
            x = img_w - check_region_w;
        end
        
        y = BTN(2) + 0.5 * BTN(4) - check_region_h * 0.5;
        
        if BTN(2) + 0.5 * BTN(4) - check_region_h * 0.5 <= 0 
            y = 1;
        end
        
        if BTN(2) + 0.5 * BTN(4) + check_region_h * 0.5 >= img_h
            y = img_h - check_region_h;        
        end        
        
        check_region = [x y check_region_w check_region_h];
        
        check_region_content = img_test(y:y+check_region_h,x:x+check_region_w,:);
%         figure(1),imshow(img_test);
%         hold on,
%         rectangle('Position', check_region,'EdgeColor','m');
%         hold off;
%         input('d');
%         continue;

        img_rs_local = imresize(check_region_content, [100 NaN],'bicubic');
        img_msseg = rgb2lab(msseg(img_rs_local) );
%         img_msseg = rgb2lab(check_region_content);                

        l = img_msseg(:,:,1);
        a = img_msseg(:,:,2);
        b = img_msseg(:,:,3);
        lab = [l(:) a(:) b(:)];

        [idx,C] = kmeans(lab,4);
        C_rgb = lab2rgb(C);    
    
%         figure(1),imshow(lab2rgb(img_msseg));
%         figure(2),
%         imagesc([1 4],[1 1],[1:4])
%         colormap(C_rgb)
%         return;
        


        c1 = rgb_color;
        c4 = C_rgb;
        c4_r = c4(:,1);
        c4_g = c4(:,2);
        c4_b = c4(:,3);
        c5 = zeros(size(c1,1),5,3);

        ind = 0;
        for l = 1 : size(c1,1)
            ind = ind + 1; 
            c5(ind,1,:) = c1(l,:);
            c5(ind,2,:) = c4(1,:);
            c5(ind,3,:) = c4(2,:);
            c5(ind,4,:) = c4(3,:);
            c5(ind,5,:) = c4(4,:);
        end


        test_num = size(c5,1);
        names = cell(test_num,1);
        [allFeatures featureNames numThemes rgbs labs]= createFeaturesFromData(c5,test_num);


        %set the output structure 
        datapoints=[];
        datapoints.allFeatureNames=featureNames;
        datapoints.allFeatures=allFeatures;
        [datapoints.features datapoints.featureNames]=createFeatureMatrix(datapoints,{'*'},0);


        testingPredictions = glmnetPredict(fit, 'response', datapoints.features(:,:));
        local_score{i} = [testingPredictions];

        
        ls = testingPredictions;
        gs = global_score{i};
        a = 0.8;
        b = 0.2;

        fs = a * gs + b * ls;
        [mv mi] = max(fs);
        
        c_rgb = [c_rgb; c1(mi,1) c1(mi,2) c1(mi,3)];   
        c_rgb_v = [c_rgb_v; mv];
%         return;
%         break;
        toc
    end
    i
    c_rgb_v
    figure(2),
    hold on,clf,
    imshow(img_test);
    plot_multi_boxes(page_BTN_test{i},1,c_rgb);
    hold off;
    input('d');
    toc
    
%     return;
end

%%
c_rgb = [c5(mi,:,1)' c5(mi,:,2)' c5(mi,:,3)'];

figure(2),
imagesc([1 5],[1 1],[1:5])
colormap(c_rgb)

% %%
% w = size(img_test,2);
% h = size(img_test,1);
% S.fh = figure('units','pixels',...
%               'position',[500 500 w h],...
%               'menubar','none',...
%               'numbertitle','off',...
%               'name','GUI_23',...
%               'MenuBar','figure',...
%               'WindowScrollWheelFcn',{@scroll_wheel},...
%               'resize','off');
          
% S.hPan = uipanel('Parent',S.fh, ...
%     'Units','pixels', 'Position',[0 0 w-20 h]);
% 
% S.IMG = img_test;
% 
% S.IH = image(S.IMG);  % Display the image.
%           
% imshow(img_test);

% S.ed = uicontrol('style','edit',...
%                  'units','pixels',...
%                  'position',[10 10 220 30],...
%                  'fontsize',14,...
%                  'string','Enter Title');

% S.ed = uicontrol('style','edit',...
%                  'units','pixels',...
%                  'position',[10 10 220 30],...
%                  'fontsize',14,...
%                  'string','Enter Title');

% S.pb = uicontrol('style','push',...
%                  'units','pixels',...
%                  'position',BTN,...
%                  'fonts',14,...
%                  'BackgroundColor','yellow',...
%                  'str','Insert Title'...
%                  );
                       

