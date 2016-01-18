%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPAP105
% Project Title: Solving Bin Packing Problem using PSO, FA and IWO
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

Choices = {'Particle Swarm Optimization', 'Firefly Algorithm', 'Invasive Weed Optimization'};

ANSWER = questdlg('Select the algorithm to solve Bin Packing Probelm.', ...
                  'Bin Packing Problem', ...
                  Choices{1}, Choices{2}, Choices{3}, ...
                  Choices{1});

if strcmpi(ANSWER, Choices{1})
    pso;
    return;
end

if strcmpi(ANSWER, Choices{2})
    fa;
    return;
end

if strcmpi(ANSWER, Choices{3})
    iwo;
    return;
end
