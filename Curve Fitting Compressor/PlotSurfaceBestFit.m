ns=0.1:0.01:20;
ds=1:0.01:20;

logds=log10(ds);
logns=log10(ns);

for i=1:length(logns)
    if logns(i)>1.3
        eff_max(i)=1.979*0.3773^logns(i);
    elseif logns(i)<-0.8
        eff_max(i)=1.462*3.516^logns(i);
    else
        eff_max(i)=0.868229+0.0215138*logns(i)-0.286446*logns(i)^2+0.385698*logns(i)^3-0.15606*logns(i)^4-0.268875*logns(i)^5+0.153681*logns(i)^6;
    end
end

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


for i=1:length(logns)
    if logns(i)>1
        stdeviation(i)=0.2592+0.2495*1-0.1288*1^2;
    elseif logns(i)<-0.09
        stdeviation(i)=0.2592+0.2495*-0.09-0.1288*(-0.09)^2;
    else
        stdeviation(i)=0.2592+0.2495*logns(i)-0.1288*logns(i)^2;
    end
end
% for i=1:length(logns)
%     if logns(i)>1.3
%         eff_max(i)=1.979*0.3773^logns(i);
%     elseif logns(i)<-0.8
%         eff_max(i)=1.462*3.516^logns(i);
%     else
%         eff_max(i)=0.868229+0.0215138*logns(i)-0.286446*logns(i)^2+0.385698*logns(i)^3-0.15606*logns(i)^4-0.268875*logns(i)^5+0.153681*logns(i)^6;
%     end
% end
% 
% for i=1:length(logns)
%     if logns(i)>1.35
%         middle(i)=0.0997;
%     elseif logns(i)<-0.8
%         middle(i)=-0.8563715456*logns(i)+0.54328550432;
% %         x1=-0.8;
% %         slope=-0.408128+2*0.472169*x1-3*0.574357*x1^2-4*0.0481688*x1^3+5*0.451904*x1^4-6*0.19625*x1^5;
% %         y1=0.524877-0.408128*x1+0.472169*x1^2-0.574357*x1^3-0.0481688*x1^4+0.451904*x1^5-0.19625*x1^6;
% %         middle(i)=slope*(logns(i)-x1)+y1;
%     else
%         middle(i)=0.524877-0.408128*logns(i)+0.472169*logns(i)^2-0.574357*logns(i)^3-0.0481688*logns(i)^4+0.451904*logns(i)^5-0.19625*logns(i)^6;
%     end
% end
% 
% for i=1:length(logns)
%     if logns(i)>1
%         stdeviation(i)=0.2592+0.2495*1-0.1288*1^2;
%     elseif logns(i)<-0.09
%         stdeviation(i)=0.2592+0.2495*-0.09-0.1288*(-0.09)^2;
%     else
%         stdeviation(i)=0.2592+0.2495*logns(i)-0.1288*logns(i)^2;
%     end
% end

lns=length(ns);
lds=length(ds);

efficiency=zeros(lds,lns);
for j=1:lds
    efficiency(j,:)=eff_max.*exp(-(logds(j)-middle).^2./stdeviation.^2);
end
figure

mesh(ns,ds,efficiency)
xlabel('n_s')
ylabel('d_s')
zlabel('efficiency')
colorbar
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
