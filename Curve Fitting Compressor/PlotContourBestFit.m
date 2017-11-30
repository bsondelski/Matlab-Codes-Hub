ns=0:0.1:30;
ds=0:0.1:20;

logds=log10(ds);
logns=log10(ns);

%make ends exponential
for i=1:length(logns)
    if logns(i)>1.3
        eff_max(i)=1.979*0.3773^logns(i);
    elseif logns(i)<-0.8
        eff_max(i)=1.462*3.516^logns(i);
    else
        eff_max(i)=0.868229+0.0215138*logns(i)-0.286446*logns(i)^2+0.385698*logns(i)^3-0.15606*logns(i)^4-0.268875*logns(i)^5+0.153681*logns(i)^6;
    end
end

%less drastic change for rhs n=0.5
% for i=1:length(logns)
%     if logns(i)>1.3
%         x1=1.3;
%         slope=0.0215138-2*0.286446*x1+3*0.385698*x1^2-4*0.15606*x1^3-5*0.268875*x1^4+6*0.153681*x1^5;
%         y1=0.868229+0.0215138*x1-0.286446*x1^2+0.385698*x1^3-0.15606*x1^4-0.268875*x1^5+0.153681*x1^6;
%         eff_max(i)=slope*(logns(i)-x1)+y1;
%     elseif logns(i)<-0.8
%         x1=-0.8;
%         slope=0.0215138-2*0.286446*x1+3*0.385698*x1^2-4*0.15606*x1^3-5*0.268875*x1^4+6*0.153681*x1^5;
%         y1=0.868229+0.0215138*x1-0.286446*x1^2+0.385698*x1^3-0.15606*x1^4-0.268875*x1^5+0.153681*x1^6;
%         eff_max(i)=slope*(logns(i)-x1)+y1;
%     else
%         eff_max(i)=0.868229+0.0215138*logns(i)-0.286446*logns(i)^2+0.385698*logns(i)^3-0.15606*logns(i)^4-0.268875*logns(i)^5+0.153681*logns(i)^6;
%     end
% end

%change a couple of data points
% for i=1:length(logns);
%     if logns(i)>1.3
%         x1=1.3;
%         slope=0.0203729-2*0.282933*x1+3*0.392736*x1^2-4*0.166823*x1^3-5*0.276637*x1^4+6*0.162495*x1^5;
%         y1=0.86803+0.0203729*x1-0.282933*x1^2+0.392736*x1^3-0.166823*x1^4-0.276637*x1^5+0.162495*x1^6;
%         eff_max(i)=slope*(logns(i)-x1)+y1;
%     elseif logns(i)<-0.8
%         x1=-0.8;
%         slope=0.0203729-2*0.282933*x1+3*0.392736*x1^2-4*0.166823*x1^3-5*0.276637*x1^4+6*0.162495*x1^5;
%         y1=0.86803+0.0203729*x1-0.282933*x1^2+0.392736*x1^3-0.166823*x1^4-0.276637*x1^5+0.162495*x1^6;
%         eff_max(i)=slope*(logns(i)-x1)+y1;
%     else
%         eff_max(i)=0.86803+0.0203729*logns(i)-0.282933*logns(i)^2+0.392736*logns(i)^3-0.166823*logns(i)^4-0.276637*logns(i)^5+0.162495*logns(i)^6;
%     end
% end

%original polynomial
% for i=1:length(logns);
%     if logns(i)>1.3
%         x1=1.3;
%         slope=0.0158396-2*0.259682*x1+3*0.427754*x1^2-4*0.229594*x1^3-5*0.320418*x1^4+6*0.205*x1^5;
%         y1=0.866727+0.0158396*x1-0.259682*x1^2+0.427754*x1^3-0.229594*x1^4-0.320418*x1^5+0.205*x1^6;
%         eff_max(i)=slope*(logns(i)-x1)+y1;
%     elseif logns(i)<-0.8
%         x1=-0.8;
%         slope=0.0158396-2*0.259682*x1+3*0.427754*x1^2-4*0.229594*x1^3-5*0.320418*x1^4+6*0.205*x1^5;
%         y1=0.866727+0.0158396*x1-0.259682*x1^2+0.427754*x1^3-0.229594*x1^4-0.320418*x1^5+0.205*x1^6;
%         eff_max(i)=slope*(logns(i)-x1)+y1;
%     else
%         eff_max(i)=0.866727+0.0158396*logns(i)-0.259682*logns(i)^2+0.427754*logns(i)^3-0.229594*logns(i)^4-0.320418*logns(i)^5+0.205*logns(i)^6;
%     end
% end

%gaussian
% eff_max=0.8868*exp(-(logns-0.2312).^2/1.554^2);

%polynomial
%eff_max=0.8646+0.1369*logns-0.3001*logns.^2;

%attempt to adjust axes to get added data points to be more accurate
for i=1:length(logns)
    if logns(i)>1.35
        middle(i)=0.0997;
%         x1=1.3;
%         slope=-0.408128+2*0.472169*x1-3*0.574357*x1^2-4*0.0481688*x1^3+5*0.451904*x1^4-6*0.19625*x1^5;
%         y1=0.524877-0.408128*x1+0.472169*x1^2-0.574357*x1^3-0.0481688*x1^4+0.451904*x1^5-0.19625*x1^6;
%         middle(i)=slope*(logns(i)-x1)+y1;
    elseif logns(i)<-0.8
middle(i)=-0.8563715456*logns(i)+0.54328550432;

%         x1=-0.8;
%         slope=-0.408128+2*0.472169*x1-3*0.574357*x1^2-4*0.0481688*x1^3+5*0.451904*x1^4-6*0.19625*x1^5;
%         y1=0.524877-0.408128*x1+0.472169*x1^2-0.574357*x1^3-0.0481688*x1^4+0.451904*x1^5-0.19625*x1^6;
%         middle(i)=slope*(logns(i)-x1)+y1;
    else
        middle(i)=0.524877-0.408128*logns(i)+0.472169*logns(i)^2-0.574357*logns(i)^3-0.0481688*logns(i)^4+0.451904*logns(i)^5-0.19625*logns(i)^6;
    end
end

% with correct added data points
% for i=1:length(logns);
%     if logns(i)>1.3
%         x1=1.3;
%         slope=-0.356504+2*0.343326*x1-3*0.527476*x1^2+4*0.0686514*x1^3+5*0.343959*x1^4-6*0.171734*x1^5;
%         y1=0.521941-0.356504*x1+0.343326*x1^2-0.527476*x1^3+0.0686514*x1^4+0.343959*x1^5-0.171734*x1^6;
%         middle(i)=slope*(logns(i)-x1)+y1;
%     elseif logns(i)<-0.8
%         x1=-0.8;
%         slope=-0.356504+2*0.343326*x1-3*0.527476*x1^2+4*0.0686514*x1^3+5*0.343959*x1^4-6*0.171734*x1^5;
%         y1=0.521941-0.356504*x1+0.343326*x1^2-0.527476*x1^3+0.0686514*x1^4+0.343959*x1^5-0.171734*x1^6;
%         middle(i)=slope*(logns(i)-x1)+y1;
%     else
%         middle(i)=0.521941-0.356504*logns(i)+0.343326*logns(i)^2-0.527476*logns(i)^3+0.0686514*logns(i)^4+0.343959*logns(i)^5-0.171734*logns(i)^6;
%     end
% end


% for i=1:length(logns);
%     if logns(i)>1.5
%         middle(i)=0.5508-0.5392*1.5+0.1907*1.5^2;
%     elseif logns(i)<-1
%         middle(i)=-0.9206*logns(i)+0.5508;
%     else
%         middle(i)=0.5508-0.5392*logns(i)+0.1907*logns(i)^2;
%     end
% end

for i=1:length(logns)
    if logns(i)>1
        stdeviation(i)=0.2592+0.2495*1-0.1288*1^2;
    elseif logns(i)<-0.09
        stdeviation(i)=0.2592+0.2495*-0.09-0.1288*(-0.09)^2;
    else
        stdeviation(i)=0.2592+0.2495*logns(i)-0.1288*logns(i)^2;
    end
end

lns=length(ns);
lds=length(ds);


% efficiency=eff_max.*exp(-(logds(50)-middle).^2./stdeviation.^2)

efficiency=zeros(lds,lns);
for j=1:lds
    efficiency(j,:)=eff_max.*exp(-(logds(j)-middle).^2./stdeviation.^2);
end

v=[0.5, 0.6, 0.7, 0.75, 0.8, 0.85];
contour(ns,ds,efficiency,v)
xlabel('n_s')
ylabel('d_s')
colorbar
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')

%%%%%% plot centerline %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hold on
% ns=0.05:0.05:100;
% logns=log10(ns);
% 
% for i=1:length(logns);
%     if logns(i)>1.3
%         x1=1.3;
%         slope=-0.408128+2*0.472169*x1-3*0.574357*x1^2-4*0.0481688*x1^3+5*0.451904*x1^4-6*0.19625*x1^5;
%         y1=0.524877-0.408128*x1+0.472169*x1^2-0.574357*x1^3-0.0481688*x1^4+0.451904*x1^5-0.19625*x1^6;
%         middle(i)=slope*(logns(i)-x1)+y1;
%     elseif logns(i)<-0.8
%         x1=-0.8;
%         slope=-0.408128+2*0.472169*x1-3*0.574357*x1^2-4*0.0481688*x1^3+5*0.451904*x1^4-6*0.19625*x1^5;
%         y1=0.524877-0.408128*x1+0.472169*x1^2-0.574357*x1^3-0.0481688*x1^4+0.451904*x1^5-0.19625*x1^6;
%         middle(i)=slope*(logns(i)-x1)+y1;
%     else
%         middle(i)=0.524877-0.408128*logns(i)+0.472169*logns(i)^2-0.574357*logns(i)^3-0.0481688*logns(i)^4+0.451904*logns(i)^5-0.19625*logns(i)^6;
%     end
% end
% 
% 
% actualMiddle=10.^middle;
% plot(ns,actualMiddle,'LineWidth',2)
% xlabel('n_s')
% ylabel('curve center')