%{

Polinomial coefficients are returned starting from the greatest degree.
For example, Cl_coeffs(1) is Cl_alpha and Cl_coeffs(2)  is Cl_0.

Cl(alpha) = Cl_alpha*alpha + Cl_0

%}
function [Cl_coeffs, Cd_coeffs, avg_cm] = getAirfoilData (file_name, min_ang, max_ang)

file_data = load(file_name);

file_data = file_data(file_data(:,1) >= min_ang, :);
file_data = file_data(file_data(:,1) <= max_ang, :);

Cl_coeffs = polyfit(file_data(:,1), file_data(:,2), 1);

Cd_coeffs = polyfit(file_data(:,2), file_data(:,3), 2);

avg_cm = mean(file_data(:,5));

subplot(1,2,1);
hold on;
plot(file_data(:,1), file_data(:,2));
fplot(@(x) Cl_coeffs(1)*x + Cl_coeffs(2), [min_ang, max_ang]);
title('CL');

subplot(1,2,2);
hold on;
plot(file_data(:,2), file_data(:,3));
fplot(@(x) Cd_coeffs(1)*x^2 + Cd_coeffs(2)*x + Cd_coeffs(3), [min(file_data(:,1)), max(file_data(:,1))]);
title('CD');

end