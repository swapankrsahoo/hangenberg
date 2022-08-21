%% Fluctuation of Molybdenum Concentration through Time, based on changing area of oxic, suboxic, and euxinic water column.
% modified by K Wilson & S. Sahoo
% for questions regarding code contact info: Kathleen.wilson@utexas.edu
% for questions regarding model formulation contact info: swas@equinor.com


% must have 4 complementary files within a single folder: 
% Mo_Concentration_Vars.m 
% fn_areaP_atT.m
% tracecon_basic.m
% polyfit_kew.m


%iterates the model run through time. 

function [C, T]=run_model(c0,m, T0, T2, Jr,V0,B)
i=1;
    for  t = 0:2000:T2; %set at 2000 years for mixing time of ocean 
    C_t(i)= tracecon_basic(t,c0,m, T0, T2, Jr,V0 , B);
    i=i+1;
    end 
    T=0:2000:T2;
    C=C_t;
end 