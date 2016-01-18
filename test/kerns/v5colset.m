%V5COLSET  Default color setup consistent with MATLAB version 5:

set(0,'DefaultFigureColor',[0.8,0.8,0.8]); % Set figure background to gray
set(0,'DefaultAxesColor','white');   % Set axes background to white
set(0,'DefaultAxesXColor','black');  % Set X-axis color to black
set(0,'DefaultAxesYColor','black');  % Set Y-axis color to black
set(0,'DefaultAxesZColor','black');  % Set Z-axis color to black
set(0,'DefaultTextColor','black');   % Set text color to black
set(0,'DefaultLineColor','black');   % Set line color to black
v5colorder=[ 0         0         1.0000
             0         0.5000         0
             1.0000         0         0
             0         0.7500    0.7500
             0.7500         0    0.7500
             0.7500    0.7500         0
             0.2500    0.2500    0.2500];
set(0,'DefaultAxesColorOrder',v5colorder);
clear v5colorder;
