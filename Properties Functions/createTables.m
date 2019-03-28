function [ DataOut ] = createTables( DataIn )
% create data tables from refprop data

p_low = DataIn(:,2)*1000;
p_high = DataIn(:,8)*1000;


% Tsat = DataIn(:,end);
Data = DataIn(1:end-1,:);

T = Data(:,1);
D = Data(:,3);
H = Data(:,4);
S = Data(:,5);
A = Data(:,6);



[~, coefsTD] = unmkpp(spline(DataIn(:,1),DataIn(:,3)));
[~, coefsTH] = unmkpp(spline(DataIn(:,1),DataIn(:,4)));
[~, coefsTS] = unmkpp(spline(DataIn(:,1),DataIn(:,5)));

[~, coefsSH] = unmkpp(spline(DataIn(:,5),DataIn(:,4)));
[~, coefsST] = unmkpp(spline(DataIn(:,5),DataIn(:,1)));

HA = DataIn(:,4);
HA(A == 0) = [];
Aspline = DataIn(:,6);
Aspline(A == 0) = [];

[~, coefsHA] = unmkpp(spline(HA(:,1),Aspline(:,1)));
[~, coefsHD] = unmkpp(spline(DataIn(:,4),DataIn(:,3)));
[~, coefsHT] = unmkpp(spline(DataIn(:,4),DataIn(:,1)));

DataIn(:,1:6) = [];
Data(:,1:6) = [];
% DataIn = DataIn(logical(DataIn(:,1)),:);
% Data = Data(logical(Data(:,1)),:);



Thigh = Data(:,1);
Dhigh = Data(:,3);
Hhigh = Data(:,4);
Shigh = Data(:,5);
Ahigh = Data(:,6);

[~, coefsTDhigh] = unmkpp(spline(DataIn(:,1),DataIn(:,3)));
[~, coefsTHhigh] = unmkpp(spline(DataIn(:,1),DataIn(:,4)));
[~, coefsTShigh] = unmkpp(spline(DataIn(:,1),DataIn(:,5)));

[~, coefsSHhigh] = unmkpp(spline(DataIn(:,5),DataIn(:,4)));
[~, coefsSThigh] = unmkpp(spline(DataIn(:,5),DataIn(:,1)));

HAhigh = DataIn(:,4);
HAhigh(Ahigh == 0) = [];
Asplinehigh = DataIn(:,6);
Asplinehigh(Ahigh == 0) = [];

[~, coefsHThigh] = unmkpp(spline(DataIn(:,4),DataIn(:,1)));
[~, coefsHAhigh] = unmkpp(spline(HAhigh(:,1),Asplinehigh(:,1)));
[~, coefsHDhigh] = unmkpp(spline(DataIn(:,4),DataIn(:,3)));

HA = HA(1:end-1,1);
Aspline = Aspline(1:end-1,1);
HAhigh = HAhigh(1:end-1,1);
Asplinehigh = Asplinehigh(1:end-1,1);

HA(length(HA)+1:length(H),1) = NaN;
Aspline(length(Aspline)+1:length(H),1) = NaN;
coefsHA(length(coefsHA)+1:length(H),1) = NaN;
HAhigh(length(HAhigh)+1:length(H),1) = NaN;
Asplinehigh(length(Asplinehigh)+1:length(H),1) = NaN;
coefsHAhigh(length(coefsHAhigh)+1:length(H),1) = NaN;

% Tsat = Tsat(1:length(T));
p_lowvec = p_low(1:length(T));
p_highvec = p_high(1:length(T));

DataOut = [T, D, coefsTD, H, coefsTH, S, coefsTS, S, H, coefsSH, T,...
    coefsST, HA, Aspline, coefsHA, H, D, coefsHD, T, coefsHT, Thigh, Dhigh,...
     coefsTDhigh,Hhigh, coefsTHhigh, Shigh, coefsTShigh, Shigh, Hhigh,...
     coefsSHhigh, Thigh,coefsSThigh, HAhigh, Asplinehigh, coefsHAhigh, Hhigh, Dhigh,...
     coefsHDhigh, Thigh, coefsHThigh, p_lowvec, p_highvec];%,Tsat];
end

