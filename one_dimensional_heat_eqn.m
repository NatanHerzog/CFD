clear all
close all
clc

length = 1;
total_time = 2;
num_nodes = 101;
thermal_diffusivity = 0.1;

delta_x = length / (num_nodes - 1);

delta_time = 0.5 * delta_x^2 / thermal_diffusivity; %? this is the stability condition, but where does it come from?
num_time_iterations = ceil(total_time / delta_time);  %! round up to obey stability
delta_time = total_time / num_time_iterations;  %! redefine time step

solution = zeros(num_time_iterations + 1 , num_nodes);
solution(1 , 2:end-1 ) = sin( 0 + delta_x : delta_x : length - delta_x );


for time_step = 2 : num_time_iterations

  solution( time_step , 2:end-1 ) = solution( time_step-1 , 2:end-1 ) + (delta_time*thermal_diffusivity/delta_x^2) * ( solution( time_step-1 , 3:end ) - 2*solution( time_step-1 , 2:end-1 ) + solution( time_step-1 , 1:end-2 ) );

end

[ time , position ] = meshgrid( 0 : delta_time : total_time , 0 : delta_x : length );

figure(1)
surf( time , position , solution' , "EdgeColor", "none")
xlabel('$t$ [s]', 'Interpreter', 'latex')
ylabel('$x$ [m]', 'Interpreter', 'latex')
zlabel('$T$ [K]', 'Interpreter', 'latex')