ns=xlsread('C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Balje Data\Plotting Efficiencies.xlsx','Sheet1','A6:A64');
ds=xlsread('C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Balje Data\Plotting Efficiencies.xlsx','Sheet1','B6:B64');

FunctionEfficiency=zeros(1,length(ns));
for i=1%:length(ns)
    FunctionEfficiency(i)=compressorEfficiencyOld(ns(i),ds(i));
end
xlswrite('C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Balje Data\Plotting Efficiencies.xlsx',FunctionEfficiency,'Sheet1','F2')


% filename='C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Balje Data\NsDs_LookupTable.xlsm';
% A=[ns;ds];
% xlswrite(filename,A,'Optimizer','K29')

