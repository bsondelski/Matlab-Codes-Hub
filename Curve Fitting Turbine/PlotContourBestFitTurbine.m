ns=0.1:0.01:2;
ds=1:0.1:15;

logds=log10(ds);
logns=log10(ns);

%6th order poly with added points dropping end point
for i=1:length(logns)
    if logns(i)>-0.003632
        eff_max(i)=0.6958*0.118^logns(i);
    elseif logns(i)<-0.7762
        eff_max(i)=1.225*1.881^logns(i);
    else
        eff_max(i)=0.697927-0.903584*logns(i)+5.74512*logns(i)^2+42.9914*logns(i)^3+96.669*logns(i)^4+93.4382*logns(i)^5+33.0635*logns(i)^6;
    end
end

%6th order poly with added points
% for i=1:length(logns)
%     if logns(i)>-0.003632
%         eff_max(i)=0.6984*0.02822^logns(i);
%     elseif logns(i)<-0.8854
%         eff_max(i)=0.708*1.013^logns(i);
%     else
%         eff_max(i)=0.698521-0.837962*logns(i)+6.83874*logns(i)^2+49.5182*logns(i)^3+113.896*logns(i)^4+114.047*logns(i)^5+42.1976*logns(i)^6;
%     end
% end

% 5th order poly with added points
% for i=1:length(logns)
%     if logns(i)>-0.003632
%         eff_max(i)=0.6913*0.1224^logns(i);
%     elseif logns(i)<-0.8854
%         eff_max(i)=1.938*3.118^logns(i);
%     else
%         eff_max(i)=0.691265-1.4795*logns(i)-2.06276*logns(i)^2+3.85173*logns(i)^3+9.39721*logns(i)^4+5.10454*logns(i)^5;
%     end
% end

% original
% for i=1:length(logns)
%     if logns(i)>-0.003632
%         eff_max(i)=0.6908*0.09514^logns(i);
%     elseif logns(i)<-0.8854
%         eff_max(i)=1.484*2.336^logns(i);
%     else
%         eff_max(i)=0.690686-1.67187*logns(i)-4.24904*logns(i)^2-4.01919*logns(i)^3-1.51243*logns(i)^4;
%     end
% end

%polynomial
for i=1:length(logns)
    if logns<-0.6874
        middle(i)=0.405229-0.707182*logns(i);
    else
        middle(i)=0.360595-0.908768*logns(i)-2.02901*logns(i)^2-4.62322*logns(i)^3-2.85335*logns(i)^4;
    end
end

% for i=1:length(logns)
%     middle(i)=0.34786-0.770853*logns(i);
% end

for i=1:length(logns)
    if logns>-.8
        stdeviation(i)=0.2;
    else
        stdeviation(i)=0.15;
    end
end

lns=length(ns);
lds=length(ds);


% efficiency=eff_max.*exp(-(logds(50)-middle).^2./stdeviation.^2)

efficiency=zeros(lds,lns);
for j=1:lds
    efficiency(j,:)=eff_max.*exp(-(logds(j)-middle).^2./stdeviation.^2);
end

v=[0.7, 0.8, 0.9];
contour(ns,ds,efficiency,v,'LineWidth',1)
xlabel('n_s')
ylabel('d_s')
colorbar
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')

%%%%%% plot centerline %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
ns2=0.1:0.05:1.5;
logns2=log10(ns2);

for i=1:length(logns2)
    if logns2<-0.6874
        middle2(i)=0.405229-0.707182*logns2(i);
    else
        middle2(i)=0.360595-0.908768*logns2(i)-2.02901*logns2(i)^2-4.62322*logns2(i)^3-2.85335*logns2(i)^4;
    end
end


actualMiddle=10.^middle2;
plot(ns2,actualMiddle,'LineWidth',2)
xlabel('n_s')
ylabel('curve center')