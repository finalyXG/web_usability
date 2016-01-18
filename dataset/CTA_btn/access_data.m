function [ d ] = access_data(d, files)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    clc
    SNames = fieldnames(d); 
    SName = cell2mat( SNames(1,:) );
    d = d.(SName);  
    d_files = {d.imageFilename};
    for i = 1 : length(files)
        file = files(i);
        if ~ismember(file, d_files)
%             tmp = {d.imageFilename};
%             tmp = [tmp file];
            tmp_len = length(d) + 1;
            d(tmp_len).imageFilename = cell2mat(file);
%             d.imageFilename = [];
%             d.imageFilename = tmp;
%             [d.imageFilename] = [{d.imageFilename} {file}];
%             tmp = [];
%             tmp.imageFilename = file;
%             tmp.objectBoundingBoxes = '';
%             d = [d tmp];
        end
    end
    assignin('base','d',d);
%     d(1).imageFilename
%     return;
%     tmp = {d.imageFilename}
    % objectBoundingBoxes
    [tmp ind] = sort({d.imageFilename});
%     assignin('base','d',d);
%     assignin('base','ind',ind);
%     ind
    d = d(ind);
    
    
    
end

