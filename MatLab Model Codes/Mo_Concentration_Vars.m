clear all; %close all
%% Fluctuation of Molybdenum Concentration through Time, based on changing area of oxic, suboxic, and euxinic water column.
% modified by K Wilson & S. Sahoo
% for questions regarding code contact info: Kathleen.wilson@utexas.edu
% for questions regarding model formulation contact info: swas@equinor.com


% must have 4 complementary files within a single folder: 
% Mo_Concentration_Vars.m 
% fn_areaP_atT.m
% tracecon_basic.m
% polyfit_kew.m


%% reference values 

% c0 = .105;% initial concentration ... nm/cm^3
% Jr = 1.92*10^(17);% input from Riverine Flux .. nmoles/year
% V0 = 1.3*10^(24); % volume of ocean  input .. cm^3
% Oxic Burial Rate = 0.021; nmol/cm2/yr   calculated via Mo concentration * scaling factors 
% Suboxic Burial Rate = 2.61; nmol/cm2/yr
% Euxinic Burial Rate = 12.5; nmol/cm2/yr



%% define variables 
c0 = .105; % nm/cm^3; approx. devonian initial concentrations of moly . 
Jr = 1.92*10^(17);% input the value of Jr .. nmoles/year
V0 = 1.3*10^(24); % volume of ocean  input the value of V0.. cm^3
TA = 3.61*10^18;% total area of the ocean --- 


% time span and when the change in the environment areas changes and burial
% rate changes 
T0 = 0; % start of change of environmental condition (i.e. area change)
T2 = 5*10^5; % end of simulation  
Be =12.51; %describe burial factor for euxinic % default is 12.51. % if changed, the change will be applied between T0 and T2
%% scenario 1 - static 

m(1,:) = [0.9895, 0.9895]; % oxic area start and "final"
m(2,:) = [0.01, 0.01]; % suboxic area start and "final"
m(3,:) = [0.0005, 0.0005]; % euxinic area start and "final"  not usually above 10%

B(1,:) = [0.02, 0.02]; % oxic area start and "final"
B(2,:) = [2.6, 2.6]; % suboxic area start and "final"
B(3,:) = [12.51 12.51]; % euxinic area start and "final"  not usually above 10%

[Cs,T]= run_model(c0,m, T0, T2, Jr,V0,B);

figure; 
plot(T, Cs, 'Color', 'k', 'Linewidth', 2);  xlabel('Time (years)'); ylabel ('Concentration (nmols/ cm yr)'); set(gca,'ylim', [c0-0.1*c0 c0+0.1*c0], 'xlim', [0,T2]); 

%
%% scenario 2 - increase euxinic to .5% 

m(1,:) = [0.9895, 0.985]; % oxic area start and "final"
m(2,:) = [0.01, 0.01]; % suboxic area start and "final"
m(3,:) = [0.0005, 0.005]; % euxinic area start and "final"  not usually above 10%

%Constant burial factor for each enviornment 
B(1,:) = [0.02, 0.02]; % oxic area start and "final"
B(2,:) = [2.6, 2.6]; % suboxic area start and "final"
B(3,:) = [12.51 12.51]; % euxinic area start and "final" 

[C05,T]= run_model(c0,m, T0, T2, Jr,V0,B);

figure; 
plot(T, C05, 'Color', 'k', 'Linewidth', 2);  xlabel('Time (years)'); ylabel ('Concentration (nmols/ cm yr)'); set(gca,'ylim', [0 c0+0.2*c0], 'xlim', [0,T2]); 

%% scenario 3 - increase euxinic to 1% 

m(1,:) = [0.9895, 0.98]; % oxic area start and "final"
m(2,:) = [0.01, 0.01]; % suboxic area start and "final"
m(3,:) = [0.0005, 0.01]; % euxinic area start and "final"  not usually above 10%


B(1,:) = [0.02]; % oxic area start and "final"
B(2,:) = [2.6]; % suboxic area start and "final"
B(3,:) = [12.51]; % euxinic area start and "final"  not usually above 10%

[C1,T]= run_model(c0,m, T0, T2, Jr,V0,B);

figure; 
plot(T, C1, 'Color', 'k', 'Linewidth', 2);  xlabel('Time (years)'); ylabel ('Concentration (nmols/ cm yr)'); set(gca,'ylim', [0 c0+0.2*c0], 'xlim', [0,T2]); 


%% scenario 4 - increase euxinic to 2% 

m(1,:) = [0.9895, 0.97]; % oxic area start and "final"
m(2,:) = [0.01, 0.01]; % suboxic area start and "final"
m(3,:) = [0.0005, 0.02]; % euxinic area start and "final"  not usually above 10%


B(1,:) = [0.02, 0.02]; % oxic area start and "final"
B(2,:) = [2.6, 2.6]; % suboxic area start and "final"
B(3,:) = [12.51 12.51]; % euxinic area start and "final"  not usually above 10%

[C2,T]= run_model(c0,m, T0, T2, Jr,V0,B);

figure; 
plot(T, C2, 'Color', 'k', 'Linewidth', 2);  xlabel('Time (years)'); ylabel ('Concentration (nmols/ cm yr)'); set(gca,'ylim', [0 c0+0.2*c0], 'xlim', [0,T2]); 



%% Comparison Plotting
figure;

plot(T,Cs, '-', 'Color', 'b', 'Linewidth', 2);  hold on; 
plot(T,C05, '-', 'Color', [0 .9 .3], 'Linewidth', 2); 
plot(T,C1, '-', 'Linewidth', 2, 'Color', [0.5 0 0.9]);
plot(T,C2, '-', 'Linewidth', 2, 'Color', 'r');
legend ('static', 'euxinic 0.5%', 'euxinic 1%', 'euxinic 2%')
grid on; 
ylim([0 0.2]); xlim([0 T2]); xlabel('Time (years)'); ylabel ('Concentration (nmols/ cm yr)')

