%% Fluctuation of Molybdenum Concentration through Time, based on changing area of oxic, suboxic, and euxinic water column.
% modified by K Wilson & S. Sahoo
% for questions regarding code contact info: Kathleen.wilson@utexas.edu
% for questions regarding model formulation contact info: swas@equinor.com


% must have 4 complementary files within a single folder: 
% Mo_Concentration_Vars.m 
% fn_areaP_atT.m
% tracecon_basic.m
% polyfit_kew.m



%clear
%inputs:(m, t, T0, T2)
% m is a matrix containing variables for area covered for oxic, suboxic,
% and euxinic conditions; if the conditions are static the m(1) and m(2);
%m(3) and m(4), and m(5) and m(6) should be matching pairs. 
% T0 and T2 are the start and end of the change in area for oxic, suboxic,
% and /or euxinic 

% matrix must be 2 columns and 3 rows: 
    % x1, x
    % y1, y2
    % z1, z2
% m(1,:) = [0.9, 0.7]; % oxic area start and "final"
% m(2,:) = [0.01, 0.23]; % suboxic area start and "final"
% m (3,:) = [0.0005, 0.07]; % suboxic area start and "final"

%t input is for differential equation solver. 


%* initial sea floor fraction from Scott et al. "Tracing the stepwise oxygenation of the Proterozoic ocean"  Nature, 2008 



function [fx, fy, fz]=fn_areaP_atT(m,t, T0, T2)
% m is the matrix of percent area through time of 3 oxygen conditions 
x1=m(1); 
x2= m(4);


y1=m(2);
y2= m(5);

z1=m(3);
z2= m(6);

%T2 is vertex ; Tf is timing to return to pre-change condition
Tf = T2*2;


% oxic conditions 
Ax = x1*3.61*10^18; %original percent of sea floor area 
Ax2 = x2*3.61*10^18; % sea floor area at maximum / minimum 


x=[T0 T2 Tf]'; %formatting 
y=[Ax Ax2 Ax]'; %formatting 

[p1] = polyfit_kew(x,y,2); % using a slightly edited version of poly fit to surpress warning. To create own version of polyfit, open the polyfit.m file, comment out (use %) on line 75, and save as new .m file


if  t >= T0  && t <= T2 
    fx=p1(1)*t.^2+p1(2)*t+p1(3);
else 
    fx= Ax;

end 



% suboxic conditions 
Ay=y1*3.61*10^18;
Ay2=y2*3.61*10^18;

x=[T0 T2 Tf]';
y=[Ay Ay2 Ay]';
[p2] = polyfit_kew(x,y,2); % 



if  t >= T0  && t <= T2 
    fy=p2(1)*t.^2+p2(2)*t+p2(3);
else 
    fy= Ay;
end 



% euxinic conditions 
Az=z1*3.61*10^18;
Az2=z2*3.61*10^18;

x=[T0 T2 Tf]';
y=[Az Az2 Az]';


p3= polyfit_kew(x,y,2);

%
if  t >= T0  && t <= T2 
    fz=p3(1)*t.^2+p3(2)*t+p3(3);
else 
    
    fz= Az;
end 

end 
