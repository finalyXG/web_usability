function HAZARD_autopars

k0=8;
L=[];
hh=[];
mf=findobj('Tag','HAZARD_MAIN');udata=get(mf,'UserData');X=udata.X;n=length(X);

nu=0;mu=0;
for k=2:2:k0;
  K=K_def('opt',nu,k,mu);
  beta=K.beta;var=K.var;
  TK=(abs(beta)^(2*nu+1)*var^(k-nu))^(2/(2*k+1));
  gamm=(var/beta^2)^(1/(2*k+1));
  h_m=h_ms(X,K);
  [hn,pociter,iterace]=iter_bisnewt(h_m,X,K,50,0.0001);
  hh=[hh,hn];
  Lp=TK*(2*(k+nu)+1)*gamm/(2*n*k*hn^(2*nu+1));
  L=[L,Lp];
end

[Lmin,Imin]=min(L);
h=hh(Imin);
hs=num2str(h);
k=2*Imin;
ks=num2str(k);

K=K_def('opt',nu,k,mu);
k=K.k;mu=K.mu;nu=K.nu;
kselstr='Selected kernel:';
if k==2 && nu==0
 if mu==-1, kselstr=[kselstr,' rectangular'];
 elseif mu==0, kselstr=[kselstr,' Epanechnikov'];
 elseif mu==1, kselstr=[kselstr,' Quartic'];
 else kselstr=[kselstr,' Optimal with nu=',num2str(nu),', k=',num2str(k),', mu=',num2str(mu),'.'];
 end
else kselstr=[kselstr,' Optimal with nu=',num2str(nu),', k=',num2str(k),', mu=',num2str(mu),'.'];
end
kinf=findobj('Tag','HAZARD_kerinfo');
set(kinf,'String',kselstr);

KOPT_k=findobj('Tag','HAZARD_KOPT_k');set(KOPT_k,'Value',k-1);
KOPT_nu=findobj('Tag','HAZARD_KOPT_nu');set(KOPT_nu,'Value',nu+1);
KOPT_mu=findobj('Tag','HAZARD_KOPT_mu');set(KOPT_mu,'Value',mu+2);
sf=findobj('Tag','HAZARD_setting');sdata=get(sf,'UserData');
sdata.K=K;
sdata.h=h;

sb=findobj('Tag','SelBand');
set(sb,'String',hs);
set(sb,'UserData',h);
mainok=findobj('Tag','HAZARD_setMainOK');
set(mainok,'Enable','on');

set(sf,'UserData',sdata);

if k>2
 HAZARD_warning('Density estimate can be negative for higher order kernels!');
end

end % function

