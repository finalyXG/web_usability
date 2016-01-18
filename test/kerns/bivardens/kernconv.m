function[p,X]=kernconv(ny,k,mi,L,autor,C)
% KERNCONV Convolution of kernels
%
% p=kernconv(ny,k,mi,L,author);
%
% ny,k,mi ... order of kernel ([0,2,1] = Epanechnik)
% L ......... order of convolution (L=2 => p=K*K, L=3 => p=K*K*K ...)
% author ..... 'jirka' or 'honza' (specify the author)
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

K=jadro(ny,k,mi);

if nargin<4
    L=2;
end

switch autor
    case 'honza'
        
        if L==2
            P=K;
            XX=[-1,1];
            PP=[K,K;K,K];
        end
        
        if L>2
            [P,XX]=kernconv(ny,k,mi,L-1,'honza');
            PP=[[P(1,:);P],[P(1,:);P(2:end,:);P(end,:)]];
        end
        
        m=length(K)-1; %stupen polynomu
        s=mi-1;        %hladkost polynomu
        pocet=L*(m+1); %stupen vysledneho+1
        
        pom=(-L:2:L)';
        mez=(-L+1:2:L-1);
        X=[pom(1:end-1),pom(2:end)]; % hranice podintervalu
        p=zeros(L,L*(m+1));
        
        for i=1:L
            a=X(i,1);b=X(i,2);
            knots=linspace(a,b,pocet);
            for j=1:length(knots)
                meze1=[min([mez(i),knots(j)-1]),max([mez(i),knots(j)-1])];meze1(abs(meze1)>abs(L-1))=mez(i);
                meze2=[min([mez(i),knots(j)+1]),max([mez(i),knots(j)+1])];meze2(abs(meze2)>abs(L-1))=mez(i);
                f(i,j)=coninpoint(PP(i,1:end/2),K,meze1(1),meze1(2),knots(j))+coninpoint(PP(i,end/2+1:end),K,meze2(1),meze2(2),knots(j));
            end
            p(i,:)=newtonip(knots,f(i,:));
        end
        
        
    case 'jirka'
        %    cd jadra;
        K=K_def('opt',ny,k,mi-1);
        Kcon=Kconv_coef(K,L);
        pom=(-L:2:L)';
        mez=(-L+1:2:L-1);
        X=[pom(1:end-1),pom(2:end)];
        p=Kcon.coef;
        %    cd ..
    otherwise
        disp('Wrong author!');
end

if nargin==6
    figure(C);hold on;
    for i=1:L
        x=linspace(X(i,1),X(i,2));
        plot(x,polyval(p(i,:),x));
    end
end
