function [ xbar_H,ybar_H,T_H,xbar_C,ybar_C,T_C ] = Recuperator( M )
%
% Input:
% M = number of heat exchanger volumes (N=M)[-]
%
% Outputs
% xbar_H,ybar_H = matricies with dimensionless positions of hod-fluid
% nodes[-]
% T_H = matrix with hot fluid temperatures
% xbar_C,ybar_C = matrices with dimensionless positions of cold-fluid
% nodes[-]
% T_C = matrix with cold-fluid temperatures

%all these values will need to change!!!!!!!!!!
m_dot_H=1.0; %hot side mass flow rate [kg/s]
m_dot_C=0.5; %cold side mass flow rate [kg/s]
T_H_in=350; %hot side inlet temperature [K]
T_C_in=150; %cold side inlet temperature [K]
UA=5000; %conductance [W/K]
N=M; %M divisions in the x direction and N divisions in the y direction

%grid locations for hot-side temperatures using correlations from textbook
%page 921
for i=1:M
    for j=1:(N+1)
        xbar_H(i,j)=(i-1/2)/M;
        ybar_H(i,j)=(j-1)/N;
    end
end
%grid locations for cold-side temperatures using correlations from textbook
%page 921
for i=1:(M+1)
    for j=1:N
        xbar_C(i,j)=(i-1)/M;
        ybar_C(i,j)=(j-1/2)/N;
    end
end

%initialize matrices
A=spalloc(2*M*N+M+N,
        






D_out=0.0102; %Tube OD [m]
th=0.0009; %Tube wall thickness [m]

%HEX Performance
V_dot_C=0.06 %


end

