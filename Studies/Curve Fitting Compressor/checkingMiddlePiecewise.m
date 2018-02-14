ns=0.05:0.05:100;
logns=log10(ns);

%attempted axis shift - good results
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

% after fixing data points from first attempt at high order
%polynomial
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

%using max values for middle values - not accurate
% for i=1:length(logns);
%     if logns(i)>1.3
%         x1=1.3;
%         slope=-0.348753+2*0.330175*x1-3*0.531013*x1^2+4*0.0857553*x1^3+5*0.336879*x1^4-6*0.172086*x1^5;
%         y1=0.521179-0.348753*x1+0.330175*x1^2-0.531013*x1^3+0.0857553*x1^4+0.336879*x1^5-0.172086*x1^6;
%         middle(i)=slope*(logns(i)-x1)+y1;
%     elseif logns(i)<-0.8
%         x1=-0.8;
%         slope=-0.348753+2*0.330175*x1-3*0.531013*x1^2+4*0.0857553*x1^3+5*0.336879*x1^4-6*0.172086*x1^5;
%         y1=0.521179-0.348753*x1+0.330175*x1^2-0.531013*x1^3+0.0857553*x1^4+0.336879*x1^5-0.172086*x1^6;
%         middle(i)=slope*(logns(i)-x1)+y1;
%     else
%         middle(i)=0.521179-0.348753*logns(i)+0.330175*logns(i)^2-0.531013*logns(i)^3+0.0857553*logns(i)^4+0.336879*logns(i)^5-0.172086*logns(i)^6;
%     end
% end


%before polynomials%%%%%%%%%%%%%%%%%%%%
% for i=1:length(logns);
%     if logns(i)>1.5
%         middle(i)=0.5508-0.5392*1.5+0.1907*1.5^2;
%     elseif logns(i)<-1
%         middle(i)=-0.9206*logns(i)+0.5508;
%     else
%         middle(i)=0.5508-0.5392*logns(i)+0.1907*logns(i)^2;
%     end
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% for i=1:length(logns)
%     if logns(i)>1.5
%         middle(i)=0.5508-0.5392*1.5+0.1907*1.5^2;
%     elseif logns(i)<-1
%         middle(i)=-0.9206*logns(i)+0.5508;
%     else
%         middle(i)=0.5508-0.5392*logns(i)+0.1907*logns(i)^2;
%     end
% end

actualMiddle=10.^middle;
% plot(ns,actualMiddle,'red')%'LineWidth',2)
% xlabel('log n_s')
% ylabel('Curve Center')
% 
% set(gca, 'XScale', 'log')
% set(gca, 'YScale', 'log')
% figure
plot(logns,middle)
xlabel('log n_s')
ylabel('Curve Center')