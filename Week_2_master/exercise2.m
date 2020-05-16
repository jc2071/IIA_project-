clear; close all; clc;

np = 101; % Defines number of panels

for ReL = [5e6, 1e7, 2e7] 
    disp(['ReL: ', num2str(ReL)])
    for duedx = [-0.1, 0, 0.1]
        ue = linspace(1, 1+duedx, np);
        disp(['Velocity gradient = ', num2str(duedx)])
        % Reset arrays
        x = linspace(0, 1, np);
        integral = zeros(1,np);
        theta = zeros(1,np);
      
        % Loop parameters
        laminar = true;
        i = 1;

        while laminar && i < np
            i = i + 1;

            % Calculate momentum thickness
            integral(i) = integral(i-1) + ueintbit(x(i-1), ue(i-1), x(i), ue(i));
            theta(i) = sqrt( 0.45/ReL * integral(i)/ue(i)^6 );

            % Check for natural transition
            Rethet = ReL * ue(i) * theta(i);
            m = -ReL * theta(i)^2 * (ue(i)-ue(i-1)) / (x(i)-x(i-1));
            He = laminar_He( thwaites_lookup(m) );
            if log(Rethet) >= 18.4*He - 21.74
               laminar = false; % Stop loop if natural transition
               disp([x(i) Rethet/1000])
            end
            if i == np
               disp('No transition occured') 
            end
        end
    end
end