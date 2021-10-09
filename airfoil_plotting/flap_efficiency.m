% input_file: vector de nombres de archivo con datos
% v_range: rango de movilidad vertical del flap pp
% h_range: rango de ángulos de ataque tomados
function [tau] = efficiency(input_files,v_range,h_range)

tau = zeros(size(input_files));

DATA_inf = load(input_files(1));
DATA_sup = load(input_files(length(input_files)));

CL_inf = DATA_inf(:,2);
CL_sup = DATA_sup(:,2);

h_range = h_range - h_range(1) + 1;
tau = (CL_sup(h_range,1)-CL_inf(h_range))./v_range;
tau = mean(tau) * 180/pi;


end