
%read data
filename='C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Balje Data\NsDs_LookupTable.xlsm';
effs=xlsread(filename,'Sheet1');

%remove values that are 1%
inds=find(effs==0.01);
effs(inds)=NaN;

%create vectors for x and y values
x=effs(1,2:end);
y=effs(2:end,1);

%remove x and y values from z data matrix
effs=effs(2:end,2:end);

%values for contour lines
v=[0.4,0.5,0.6,0.7,0.75,0.8,0.85];

%%%%%%%%%%if want to write to see data
% filename='C:\Users\sondelski\Documents\MATLAB\exceldoc';
% A=[effs];
% xlswrite(filename,A)

figure
%plot contour lines
contour(x,y,effs,v)
xlabel('n_s')
ylabel('d_s')
colorbar
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')

figure
mesh(x,y,effs)
xlabel('n_s')
ylabel('d_s')
zlabel('efficiency')
colorbar
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')