function scroll_wheel
% Illustrates how to use WindowScrollWheelFcn property
%
   f = figure('WindowScrollWheelFcn',@figScroll,'Name','Scroll Wheel Demo');
   x = [0:.1:40];
   y = 4.*cos(x)./(x+2);
   a = axes; 
   h = plot(x,y);
   title('Rotate the scroll wheel')
   function figScroll(src,callbackdata)
      if callbackdata.VerticalScrollCount > 0 
         xd = h.XData;
         % This code uses dot notation to set properties
         % Dot notation runs in R2014b and later.
         % For R2014a and earlier: xd = get(h,'XData');
         inc = xd(end)/20;
         x = [0:.1:xd(end)+inc];
         re_eval(x)
      elseif callbackdata.VerticalScrollCount < 0 
         xd = h.XData;
         % For R2014a and earlier: xd = get(h,'XData');
         inc = xd(end)/20;
         x = [0:.1:xd(end)-inc+.1]; % Don't let xd = 0;
         re_eval(x)
      end
   end

   function re_eval(x)
      y = 4.*cos(x)./(x+2);
      h.YData = y;
      h.XData = x;
      a.XLim = [0 x(end)];
      % For R2014a and earlier: 
      % set(h,'YData',y);
      % set(h,'XData',x);
      % set(a,'XLim',[0 x(end)]);
      drawnow
   end
end