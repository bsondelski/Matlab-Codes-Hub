function [ result ] = propertiesInterp( out,in,val,p,mode )
% read data from tables of refprop data ---only certain combinations of
% input and output properties are valid

% Inputs:
% Out: requested property, options are:
%   d: density [kg/m^3]
%   h: enthalpy [J/kg]
%   T: temperature [K]
%   s: entropy [J/kg-K]
%   a: speed of sound [m/s]
% In: input property, options are: 
%   T: temperature [K]
%   s: entropy [J/kg-K]
%   h: enthalpy [J/kg]
% val: value of input property
% p: pressure of state [kPa]
% mode: data tables

% Outputs:
% result: desired output property - see above for options and units


% check if high or low pressure properties should be used
if p == mode(1,89)          % p_low
    props = mode(:,1:44);
elseif p == mode(1,90)      % p_high
    props = mode(:,45:88);
else
    fprintf(2, 'propertiesInterp: pressure is not available in property tables \n check pressure drops are turned off \n \n');
end

% get property arrays for desired input and output
if in == 'T'
    x = props(:,1);
    if out == 'd'
        y = props(:,2:6);
    elseif out == 'h'
        y = props(:,7:11);
    elseif out == 's'
        y = props(:,12:16);
    end
elseif in == 's'
    x = props(:,17);
    if out == 'h'
        y = props(:,18:22);
    elseif out == 'T'
        y = props(:,23:27);
    end
elseif in == 'h'
    if out == 'a'
        x = props(:,28);
        y = props(:,29:33);
    elseif out == 'd'
        x = props(:,34);
        y = props(:,35:39);
    elseif out == 'T'
        x = props(:,34);
        y = props(:,40:44);
    end
end

% state result if exact value is available
result = y(x == val,1);

% if exact value is not available, get spline coefficients and calculate
% approximate output result
if isempty(result)   
    
    a = zeros(length(val),1);
    b = zeros(length(val),1);
    c = zeros(length(val),1);
    d = zeros(length(val),1);
    xval = zeros(length(val),1);
    for i =1:length(val)
        xvec = x(x<val(i));
        xval(i) = xvec(end);
        a(i) = y(x == xval(i),2);
        b(i) = y(x == xval(i),3);
        c(i) = y(x == xval(i),4);
        d(i) = y(x == xval(i),5);
    end
    
    diff = val' - xval;
    result = (a.*diff.^3 + b.*diff.^2 + c.*diff + d)';
    
    
end


end

