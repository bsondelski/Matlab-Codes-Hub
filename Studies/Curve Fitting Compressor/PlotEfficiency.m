FunctionEfficiency=xlsread('C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Balje Data\Plotting Efficiencies.xlsx','Sheet1','C6:C64');
InterpolatedEfficiency=xlsread('C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Balje Data\Plotting Efficiencies.xlsx','Sheet1','D6:D64');



ylabel('Function Efficiency')
xlabel('Interpolated Efficiency')

x=0.4:0.1:0.9;
hold on 


y1=x-0.1*x;
y2=x+0.1*x;

y3=x-0.2*x;
y4=x+0.2*x;

plot(x,x,'red')

plot(x,y1,'--red')
plot(x,y3,'--red')

plot(x,y2,'--red')
plot(x,y4,'--red')

xlim([0.4 0.9])
ylim([0.4 0.9])

scatter(InterpolatedEfficiency,FunctionEfficiency,'.')

% legend('theoretical','10% error','20% error')
box on
hold off