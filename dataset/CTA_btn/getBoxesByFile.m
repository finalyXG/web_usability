function [ boxes, pboxes, types ] = getBoxesByFile( element, file_name, element_type )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
%     clc
    tmp_files = {element.imageFilename};
    pboxes = [];
    boxes = [];    
    types = [];
    for i = 1 : length(tmp_files)
%         tmp_files(i)
        if isequal(cell2mat(tmp_files(i)), file_name)
             boxes.location = element(i).objectBoundingBoxes;
             boxes.type = element_type;
             pboxes = [pboxes; element(i).objectBoundingBoxes];
             types = [types; repmat(element_type,size(element(i).objectBoundingBoxes,1),1)];
        end
    end
    
   

end

