function [] = plot_elements( element,check_file,i,color,width,label)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
   element_files = {element.imageFilename};
%    check_file
%    element_files{i}
    
    for j = 1 : size(element(i).objectBoundingBoxes,1)
        if ~isequaln(check_file, element_files{i})
            continue;
        end
        tmp_box = element(i).objectBoundingBoxes(j,:);
        rectangle('Position',tmp_box,'LineWidth',width,'EdgeColor',color);
        text(tmp_box(1),tmp_box(2),num2str(j));
    end

end

