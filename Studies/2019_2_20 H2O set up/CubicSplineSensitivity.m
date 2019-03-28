% testing for sensitivity in number of points in the cubic spline data



% setup:

% set mode1 to dT=1K, mode2 to dT=2K, ... up to mode10, then increase by 5s
% until 25, ie. mode11 is dT=15, mode12 is dT=20 mode13 is dT = 25

%%%% load From fluidSearch folder >>> CubicSplineSensitivityModes as
%%%% workspace





for i = 1:24
    % set properties
    clear mode
    
    if i == 1
        mode = 2;
    elseif i == 2
        mode = 3;
    elseif i == 3
        mode = mode1;
    elseif i == 4
        mode = mode2;
    elseif i == 5
        mode = mode3;
    elseif i == 6
        mode = mode4;
    elseif i == 7
        mode = mode5;
    elseif i == 8
        mode = mode6;
    elseif i == 9
        mode = mode7;
    elseif i == 10
        mode = mode8;
    elseif i == 11
        mode = mode9;
    elseif i == 12
        mode = mode10;
    elseif i == 13
        mode = mode12;
    elseif i == 14
        mode = mode15;
    elseif i == 15
        mode = mode20;
    elseif i == 16
        mode = mode25;
    elseif i == 17
        mode = mode30;
    elseif i == 18
        mode = mode40;
    elseif i == 19
        mode = mode50;
    elseif i == 20
        mode = mode60;
    elseif i == 21
        mode = mode70;
    elseif i == 22
        mode = mode80;
    elseif i == 23
        mode = mode90;
    elseif i == 24
        mode = mode100;
    end
    
    i
    
    if i == 1 || i == 2
        fluid = 'CO2';
    else
        fluid = {'CO2','water',[1,0]};
    end

    tic
    for j = 1:10
%         [net_power(j),cyc_efficiency(j,1:2),D_T(j),D_c(j),Ma_T(j),Ma_c(j),Anozzle(j),q_reactor(j),...
%             q_rad(j),T1(j),Power_T(j),Power_c(j),HEXeffect(j),energy(j),p1(j),T2(j),p2(j),T3(j),p3(j),T4(j),p4(j),T5(j),...
%             p5(j),T6(j),p6(j),~,Vratio(j)] = BraytonCycle(0.6447,9000,1100,2,8.5362e3,...
%             39.0505,100,fluid,mode,0);

 [net_power(j),cyc_efficiency(j,1:2),D_T(j),D_c(j),Ma_T(j),Ma_c(j),Anozzle(j),q_reactor(j),...
            q_rad(j),T1(j),Power_T(j),Power_c(j),HEXeffect(j),energy(j),p1(j),T2(j),p2(j),T3(j),p3(j),T4(j),p4(j),T5(j),...
            p5(j),T6(j),p6(j),~,Vratio(j)] = BraytonCycle(0.799,9000,1100,2,9.1876e3,...
            40.7044,100,fluid,mode,0);
    end
    time(i) = toc;
    
    net_power_out(i) = mean(net_power);
    net_power_deviation(i) = std(net_power);
    cyc_efficiency_out1(i) = mean(cyc_efficiency(:,1));
    cyc_efficiency_out2(i) = mean(cyc_efficiency(:,2));
%     D_T(i) = mean(D_T)
%     D_c_out(i) = mean(D_c);
%     Ma_T_out(i) = mean(Ma_T);
%     Ma_c_out(i) = mean(Ma_c);
%     Anozzle_out(i) = mean(Anozzle);
    q_reactor_out(i) = mean(q_reactor);
    q_rad_out(i) = mean(q_rad);
    T1_out(i) = mean(T1);
    Power_T_out(i) = mean(Power_T);
    Power_c_out(i) = mean(Power_c);
    HEXeffect_out(i) = mean(HEXeffect);
%     energy_out(i) = mean(energy);
%     p1_out(i) = mean(p1);
    T2_out(i) = mean(T2);
%     p2_out(i) = mean(p2);
    T3_out(i) = mean(T3);
%     p3_out(i) = mean(p3);
    T4_out(i) = mean(T4);
%     p4_out(i) = mean(p4);
    T5_out(i) = mean(T5);
%     p5_out(i) = mean(p5);
    T6_out(i) = mean(T6);
%     p6_out(i) = mean(p6);
%     Vratio_out(i) = mean(Vratio);



end
    

xvals = [1:10, 12, 15, 20, 25, 30, 40, 50, 60, 70, 80, 90, 100];
figure(1)
y = net_power_out/1000;
plot(xvals,y(3:end),'-x',[xvals(1),xvals(end)],[y(1),y(1)],'-*',[xvals(1),xvals(end)],[y(2),y(2)],'-o');
xlabel('dT between cubic spline points [K]')
ylabel('net power output of cycle [kW]')
legend('cubic spline','FIT','REFPROP','location','northwest')


figure(2)
y = net_power_deviation;
plot(xvals,y(3:end),[xvals(1),xvals(end)],[y(1),y(1)],'-*',[xvals(1),xvals(end)],[y(2),y(2)],'-o');
xlabel('dT between cubic spline points [K]')
ylabel('standard deviation of net power output of cycle in 10 runs')
legend('cubic spline','FIT','REFPROP')


figure(3)
y = time;
plot(xvals,y(3:end),[xvals(1),xvals(end)],[y(1),y(1)],'-*',[xvals(1),xvals(end)],[y(2),y(2)],'-o');
xlabel('dT between cubic spline points [K]')
ylabel('time to call BraytonCycle 10 instances [sec]')
legend('cubic spline','FIT','REFPROP','location','east')
% ylim([0,6])

% figure
% y = cyc_efficiency_out1;
% plot(xvals,y(1:13),[xvals(1),xvals(end)],[y(14),y(14)],[xvals(1),xvals(end)],[y(15),y(15)]);
% 
% figure
% y = cyc_efficiency_out2;
% plot(xvals,y(1:13),[xvals(1),xvals(end)],[y(14),y(14)],[xvals(1),xvals(end)],[y(15),y(15)]);
% 
% figure
% y = q_reactor_out;
% plot(xvals,y(1:13),[xvals(1),xvals(end)],[y(14),y(14)],[xvals(1),xvals(end)],[y(15),y(15)]);
% 
% figure
% y = q_rad_out;
% plot(xvals,y(1:13),[xvals(1),xvals(end)],[y(14),y(14)],[xvals(1),xvals(end)],[y(15),y(15)]);


