%% Fluctuation of Molybdenum Concentration through Time, based on changing area of oxic, suboxic, and euxinic water column.
% modified by K Wilson & S. Sahoo
% for questions regarding code contact info: Kathleen.wilson@utexas.edu
% for questions regarding model formulation contact info: swas@equinor.com


% must have 4 complementary files within a single folder: 
% Mo_Concentration_Vars.m 
% fn_areaP_atT.m
% tracecon_basic.m
% polyfit_kew.m


%calculates trace mental concentration based on time step and area of each
%environmental condition as a function of time. 
function C_t = tracecon_basic(t,c0,m, T0, T2, Jr,V0,B)


     [A1, A2, A3] = fn_areaP_atT(m,t, T0, T2);

    % [fBo, fBs, fBe]=fn_BurialFlux_atT(t, T0,T2, B);
     fBo = B(1);
     fBs = B(2);
     fBe = B(3);
     

    a = fBo/c0; % will be the same once fBo et al are coded 
    b = fBs/c0;
    c = fBe/c0;

    %dc = (Jr - A1*fBo - A2*fBs - A3*fBe)%/V0;
    lambda=Jr/V0; % moly source 
    gamma=(A1*a + A2*b + A3*c)/V0; %moly sink 
    X= c0 - lambda./gamma; % change in concentration 
    
    C_t=(lambda/gamma)+X*exp(-gamma*t); % time series of concentration 
 

end


