clear;clc; close all;
for k = 1: 5
T{k} = xlsread('BESS_DQ_Admittance_Measurements.xls', k, 'A3:I53'); % 3/25/3030 data
end
case1 ='Black: P=0,Q=200 kW'; 
case2 ='Cyan: P=0,Q=0'; 
case3 ='Green: P=500 kW,Q=0';
case4 ='Blue: P=0,Q=500 kW';
case5 ='Red: P=1000 kW,Q=0'; 

style ={'k','c','g', 'b', 'r'}; 
for k=1:5
[f{k}, Y_dq0{k}, Y_dq{k},Y_dq1{k}, Y_dq2{k}, Y_pn0{k}, Y_pn{k}] = function_Ypu_data(T{k}, 1000, style{k});
fun_BodePlot_FreqResp(Y_dq0{k}, f{k}, 1001, style{k}); % original
%fun_BodePlot_FreqResp(Y_dq{k}, f{k},  2001, style{k});  % take out RC filter
%fun_BodePlot_FreqResp(Y_pn0{k}, f{k}, 3001, style{k});
%fun_BodePlot_FreqResp(Y_pn{k}, f{k},  4001, style{k});
%fun_BodePlot_FreqResp(Y_dq1{k}, f{k},  5001, style{k});
%fun_BodePlot_FreqResp(Y_dq2{k}, f{k},  6001, style{k});

end

%for i=1:5
%figure(i*1000+1); legend(case1, case2, case3, case4, case5);
%end; 

%gtext(case1);
%gtext(case2);
%gtext(case3);
%gtext(case4);
%gtext(case5);