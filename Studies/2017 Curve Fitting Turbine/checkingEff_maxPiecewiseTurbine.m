logns=-5:0.1:5;

for i=1:length(logns)
    if logns(i)>-0.003632
        eff_max(i)=0.6908*0.09514^logns(i);
    elseif logns(i)<-0.8854
        eff_max(i)=1.484*2.336^logns(i);
    else
        eff_max(i)=0.690686-1.67187*logns(i)-4.24904*logns(i)^2-4.01919*logns(i)^3-1.51243*logns(i)^4;
    end
end

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


plot(logns,eff_max)
xlabel('log n_s')
ylabel('Maximum Efficiency')