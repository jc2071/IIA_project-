clear
close all

n = 101; % Number of panels

for duedx = [-0.1, 0, 0.1]
    ue = linspace(1, 1+duedx, n);
    disp(['Velocity gradient: ', num2str(duedx)])
    for ReL = [5e6, 1e7, 2e7]
        disp(['ReL = ', num2str(ReL)])
        % Reset arrays
        x = linspace(0, 1, n);
        integral = zeros(1,n);
        theta = zeros(1,n);
        
        % Loop parameters
        laminar = true;
        i = 1;

        while laminar && i < n
            i = i + 1; % Effectively start loop at i = 2

            % Calculate momentum thickness
            integral(i) = integral(i-1) + ueintbit(x(i-1), ue(i-1), x(i), ue(i));
            theta(i) = sqrt( 0.45/ReL * integral(i)/ue(i)^6 );

            % Check for transition
            Rethet = ReL * ue(i) * theta(i);
            m = -ReL * theta(i)^2 * (ue(i)-ue(i-1)) / (x(i)-x(i-1));
            He = laminar_He( thwaites_lookup(m) );
            if log(Rethet) >= 18.4*He - 21.74
               laminar = false;
               disp([x(i) Rethet/1000])
            end
            if i == n
               disp('No transition occured') 
            end


        end
    end
end