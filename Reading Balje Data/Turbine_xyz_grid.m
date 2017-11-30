%read data
filename='C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Balje Data\curve fitting turbine\fully digitizing\Turbine xyz.csv.xlsx';
xyz=xlsread(filename,'Turbine xyz');

%separate columns
x=xyz(:,1);
y=xyz(:,2);
v=xyz(:,3);

intervals=100;
xmin=min(x);
xmax=max(x);
ymin=min(y);
ymax=max(y);

% xq=xmin:((xmax-xmin)/intervals):xmax;
% yq=ymin:((ymax-ymin)/intervals):ymax;
[xq,yq]=meshgrid(xmin:((xmax-xmin)/intervals):xmax, ymin:((ymax-ymin)/intervals):ymax);

vq=griddata(x,y,v,xq,yq);


x=xq(1,:);
y=yq(:,1);

xlswrite('C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Balje Data\curve fitting turbine\fully digitizing\Turbine xyz.csv.xlsx',vq,'gric')
xlswrite('C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Balje Data\curve fitting turbine\fully digitizing\Turbine xyz.csv.xlsx',x,'grid')
xlswrite('C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Balje Data\curve fitting turbine\fully digitizing\Turbine xyz.csv.xlsx',y,'grid','A2')
v=[0.6, 0.7, 0.8, 0.9];
contour(x,y,vq,v)
xlabel('n_s')
ylabel('d_s')
colorbar
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')

figure

for i=2:length(x)
    plot(y,vq(:,i))
    hold on
end
title('n_s contours')
xlabel('d_s')
ylabel('efficiency')
set(gca, 'XScale', 'log')

figure 

for i=2:length(y)
    plot(x,vq(i,:))
    hold on
end
title('d_s contours')
xlabel('n_s')
ylabel('efficiency')
set(gca, 'XScale', 'log')