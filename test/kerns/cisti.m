% vycisti vsechny promenne typu Figure z workspace
ss = whos;
for k = 1:length(ss)
    if strcmp(ss(k).class,'matlab.ui.Figure')
        clear(ss(k).name)
    end
    if strcmp(ss(k).class,'matlab.ui.control.Component')
        clear(ss(k).name)
    end
end