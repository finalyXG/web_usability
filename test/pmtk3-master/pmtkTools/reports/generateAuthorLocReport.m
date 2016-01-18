function generateAuthorLocReport()
%% Generate the html contributing author LOC report
% Create a table of authors and the total lines of code contributed
% PMTKneedsMatlab 

% This file is from pmtk3.googlecode.com

dest = fullfile(pmtk3Root(), 'docs', 'authors');
pmtkRed = getConfigValue('PMTKred');
R    = pmtkTagReport(); % everything you ever wanted to know about tags
fname = fullfile(dest, 'authorsLOC.html');
header = formatHtmlText({
    '<font align="left" style="color:%s"><h2>Contributing Authors</h2></font>'
    ''
    'Revision Date: %s'
    ''
    'Auto-generated by %s.m'
    ''
    }, pmtkRed, date, mfilename); 

loc   = cellfuncell(@num2str, mat2cellRows(R.contribution));
ndx   = find(R.bincontrib);
for i=1:numel(ndx)
    loc{ndx(i)} = [loc{ndx(i)}, '+'];
end
colNames = {'AUTHOR'  , 'LINES OF CODE'};
htmlTable('data'      , [R.authorlist, loc]                     , ...
    'colNames'        , colNames                                , ...
    'colNameColors'   , {pmtkRed, pmtkRed}                      , ...
    'dataAlign'       , 'left'                                  , ...
    'header'          , header                                  , ...
    'caption'         , '<br>'                                  , ...
    'captionLoc'      , 'top'                                   , ...
    'captionFontSize' , 3                                       , ...
    'dosave'          , true                                    , ...
    'filename'        , fname                                   , ...
    'doshow'          , false);
end

