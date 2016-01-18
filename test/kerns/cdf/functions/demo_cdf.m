K=K_def('epan')
X=normrnd(0,1,100,1);
MinX=min(X);
MaxX=max(X);
DX=MaxX-MinX;
x=linspace(MinX-0.1*DX,MaxX+0.1*DX,201);
disp('Iteracni metoda:');
h=h_F(X,K)
y=K_cdfest(X,K,x,h);
plot(x,y,'r');
pause
disp('Plug-in metoda:');
h=h_Altman(X,K)
y=K_cdfest(X,K,x,h);
hold on
plot(x,y,'g');
pause
disp('Max. smoothing:');
h=h_Fms(X,K)
y=K_cdfest(X,K,x,h);
plot(x,y,'b');
hold off
