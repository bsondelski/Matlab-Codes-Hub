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

for i=2:length(x)
    plot(y,effs(:,i))
    hold on
end
title('n_s contours')
xlabel('d_s')
ylabel('efficiency')
% set(gca, 'XScale', 'log')

figure 

for i=2:length(y)
    plot(x,effs(i,:))
    hold on
end
title('d_s contours')
xlabel('n_s')
ylabel('efficiency')
% set(gca, 'XScale', 'log')