
clc; clear;
warning off;
%%
text_label = load('label_10_19_text.mat');
img_label = load('label_10_20_img.mat');
input_label = load('label_10_19_input.mat');
button_label = load('label_10_20_button.mat');
bgi_label = load('label_10_19_bgi.mat');
border_label = load('label_10_21_border.mat');

tmp_field = cell2mat(fieldnames(button_label));
files = {button_label.(tmp_field).imageFilename};

[input_label, text_label, img_label, button_label, bgi_label, border_label] = ...
    multiple_access_data(input_label, text_label, img_label, button_label, bgi_label, border_label, files);


text_label_file_names = {text_label.imageFilename};
img_label_file_names = {img_label.imageFilename};
input_label_file_names = {input_label.imageFilename};
bgi_label_file_names = {bgi_label.imageFilename};
button_label_file_names = {button_label.imageFilename};
border_label_file_names = {border_label.imageFilename};

%% plot the image


file_len = length(button_label);
file_names = button_label_file_names;
for i = 1 : file_len
    file_name = cell2mat(file_names(i));
    img = imread(file_name);
    clf
    figure(1), 
    imshow(img);
    axis('ij');
    hold on,
    for j = 1 : size(button_label(i).objectBoundingBoxes,1)
        if ~isequaln(file_name, button_label_file_names{i})
            break;
        end
        tmp_box = button_label(i).objectBoundingBoxes(j,:);
        rectangle('Position',tmp_box,'LineWidth',4,'EdgeColor','r');
    end
    for j = 1 : size(text_label(i).objectBoundingBoxes,1)
        a = file_name
        b = text_label_file_names{i}
        if ~isequaln(file_name, text_label_file_names{i})
            break;
        end
        tmp_box = text_label(i).objectBoundingBoxes(j,:);
        rectangle('Position',tmp_box,'LineWidth',4,'EdgeColor','g');
    end
    for j = 1 : size(img_label(i).objectBoundingBoxes,1)
        if ~isequaln(file_name, img_label_file_names{i})
            break;
        end
        tmp_box = img_label(i).objectBoundingBoxes(j,:);
        rectangle('Position',tmp_box,'LineWidth',4,'EdgeColor','y');
    end
    
    for j = 1 : size(input_label(i).objectBoundingBoxes,1)
        if ~isequaln(file_name, input_label_file_names{i})
            break;
        end
        tmp_box = input_label(i).objectBoundingBoxes(j,:);
        rectangle('Position',tmp_box,'LineWidth',4,'EdgeColor','k');
    end        
           
    tmp_files = {border_label.imageFilename};
    for j = 1 : size(border_label(i).objectBoundingBoxes,1)
        if ~isequaln(file_name, tmp_files{i})
            break;
        end
        tmp_box = border_label(i).objectBoundingBoxes(j,:);
        rectangle('Position',tmp_box,'LineWidth',2,'EdgeColor','m');
        text(tmp_box(1),tmp_box(2),num2str(j));
    end
    
    hold off;
    return;
    d = input('dump');
    
end


%%

file_len = length(button_label);
file_names = button_label_file_names;
for i = 1 : file_len
    file_name = cell2mat(file_names(i));
    img = imread(file_name);
    
    button_boxes = getBoxesByFile(button_label, file_name, 'button');
    img_boxes = getBoxesByFile(button_label, file_name, 'img');
    input_boxes = getBoxesByFile(button_label, file_name, 'input');
    text_boxes = getBoxesByFile(button_label, file_name, 'text');
    
    return;
    
    for j = 1 : size(button_label(i).objectBoundingBoxes,1)
        if ~isequaln(file_name, button_label_file_names{i})
            break;
        end
        tmp_box = button_label(i).objectBoundingBoxes(j,:);
        rectangle('Position',tmp_box,'LineWidth',4,'EdgeColor','r');
    end
end