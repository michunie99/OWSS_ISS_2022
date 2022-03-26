function ani_fig = animate_pendelum(x,dT)
% Animate pendelum
%   Creates animation for the generated values of pengelum
O = [0 0];
L = 0.5; % Lenght of pendelum
T = dT;
width = 500;
height = 500;

ani_fig = figure(Position=[100 100 width height]);

ax1 = axes();

axis(ax1,'equal');
axis([-0.7 0.7 -0.7 0.7]) 
grid on

% Loop for animation
for i = 1:length(x)
    % Make a point
    P = L*[sin(x(i,1)) -cos(x(i,1))];

    % Circle in the origin
    O_circle = viscircles(ax1,O,0.01);

    % Pendelum
    pend = line(ax1,[O(1) P(1)],[O(2) P(2)]);

    % Rotor
    rot = viscircles(ax1,P,0.05);
    
    % Add title
    title(ax1,["Speed of the rotor is: " + num2str(x(i,3)) "Time of simulation: " + num2str(T) + "sec"]);

    T = T + dT;
    pause(dT);
    if i<length(x)
        delete(pend);
        delete(rot);
        delete(O_circle);
    end
end

end