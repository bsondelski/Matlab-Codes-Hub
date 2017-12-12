p1=9000;
T4=1100;
PR_c=2;
% UA=10000;
A_panel=100;
T_amb=100;
fluid='CO2';
mode=2;
UA=4000;

%plot wdot vs mdot

m_dot2=0.15:0.25:4;
hold on
for j=1:length(UA)
    UA(j)
    for i=1:length(m_dot2)
        [net_power2(i),~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dot2(i),p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode);
    end
    plot(m_dot2,net_power2)
    
end

%plot first mdot points for quad approx
m_dot=[0.5, 2, 3.5];
% err=1;
%use quadratic approximation method to find max w_dot
% while err>0.001
for i=1:length(m_dot)
    [net_power(i),~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
end

scatter(m_dot,net_power)
xlabel('Mass Flow Rate [kg/s]')
ylabel('Power Output [W]')

%plot polynomial
figure
hold on
plot(m_dot2,net_power2)
scatter(m_dot,net_power)

xlabel('Mass Flow Rate [kg/s]')
ylabel('Power Output [W]')

p=polyfit(m_dot,net_power,2);
polypoints=p(1)*m_dot2.^2+p(2)*m_dot2+p(3);

plot(m_dot2,polypoints)

%plot peak
figure
hold on
plot(m_dot2,net_power2)
plot(m_dot2,polypoints)
d=[2*p(1), p(2)];                   %derivative of polynomial
m_middle=-d(2)/d(1);                %set derivative = 0
[net_power_middle,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_middle,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
m_dot_new=[m_dot, m_middle];                    %m_dot vector including new point
net_power_new=[net_power, net_power_middle];    %net power vector including new point
scatter(m_dot_new,net_power_new)
xlabel('Mass Flow Rate [kg/s]')
ylabel('Power Output [W]')

%plot new m_dots
figure
hold on
plot(m_dot2,net_power2)

[~,inde]=min(net_power_new);        %find location of minimum power
m_dot_new(inde)=[];                 %new m_dot vector excluding m_dot with lowest power
m_dot=m_dot_new;
err=max(m_dot)-min(m_dot);          %difference between end points
for i=1:length(m_dot)
    [net_power(i),~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
end

scatter(m_dot,net_power)
xlabel('Mass Flow Rate [kg/s]')
ylabel('Power Output [W]')


%plot second poly
%plot polynomial
figure
hold on
plot(m_dot2,net_power2)
scatter(m_dot,net_power)

xlabel('Mass Flow Rate [kg/s]')
ylabel('Power Output [W]')

p=polyfit(m_dot,net_power,2);
polypoints=p(1)*m_dot2.^2+p(2)*m_dot2+p(3);

plot(m_dot2,polypoints)
ylim([0 5e4])

% end
% 
% %exclude minimum m_dot from vector
% [~,inde_min]=min(m_dot);
% m_dot(inde_min)=[];
% %exclude maximum m_dot from vector
% [~,inde_max]=max(m_dot);
% m_dot(inde_max)=[];
% %find max net power
% [max_power,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dot,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
% 
% 
% % end