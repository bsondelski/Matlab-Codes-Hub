function [TotalMinMass,UA,UA_min,A_panel,mass_reactor,mass_recuperator,mass_radiator] = OuterFcnCHTC(inputfile)
% outer file for running in CHTC
% main purpose is to unpack txt files and then run the txt file

% net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
%     q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,...
%     p5,T6,p6,A_panel,Vratio

inputfile

% fluid = load(fluidfile);
in = load(inputfile)


[ TotalMinMass,UA,UA_min,A_panel,mass_reactor,mass_recuperator,mass_radiator ] = minimizeTotalMass(in.desiredPower,in.p1,in.T4,in.PR_c,in.T_amb,in.fluid,in.mode )

end

