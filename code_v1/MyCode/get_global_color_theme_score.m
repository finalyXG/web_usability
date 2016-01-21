

%% global 4-color theme from whole region of image
rgb_color = [];
generate_grid_color_space

global_score = cell(length(page_imgs_test),1);
fit = importdata('color_fit.mat');

for i = 1 : 30%length(page_imgs_test)
    tic
    img_rs = imresize(page_imgs_test{i}, [300 NaN],'bicubic');
    img_msseg = rgb2lab(msseg(img_rs) );
    
    l = img_msseg(:,:,1);
    a = img_msseg(:,:,2);
    b = img_msseg(:,:,3);
    lab = [l(:) a(:) b(:)];

    [idx,C] = kmeans(lab,4,'Replicates',6);
    C_rgb = lab2rgb(C);    
    
%     figure(1),imshow(lab2rgb(img_msseg));
%     figure(2),
%     imagesc([1 4],[1 1],[1:4])
%     colormap(C_rgb)
%     return;

    
    c1 = rgb_color;
    c4 = C_rgb;
    c4_r = c4(:,1);
    c4_g = c4(:,2);
    c4_b = c4(:,3);
    c5 = zeros(size(c1,1),5,3);
    
    ind = 0;
    for j = 1 : size(c1,1)
        ind = ind + 1; 
        c5(ind,1,:) = c1(j,:);
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
%     [mv mi] = max(testingPredictions);
    global_score{i} = [testingPredictions];
    

    
    
   toc 
end

%%


%%


