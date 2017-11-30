function [T_out,p_out] = Reactor(T_in,p_in)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

T12=175;
p12=300; 

T_out=T_in+T12;
p_out=p_in-p12;

end

