function wasgplot(x_foil,cp_foil,filein,alpha,Re,alphaswp,cl,cd,theta,iss)
    ipstag = iss(1);
    speeddir = 'High_speed';
    sd = 'HS';
    if Re == 5e5
        speeddir = 'Low_speed';
        sd = 'LS';
    end
    % Make a nice string of the Reynolds number pw444 code
    ReLongStr = num2str(Re);
    last_index = length(ReLongStr);
    for r = length(ReLongStr):-1:1
        if ReLongStr(r) ~= '0'
            last_index = r;
            break
        end
    end
    expon = num2str(floor(log10(Re)));
    if last_index == 1
        ReStr = [ReLongStr(1), 'e', expon];
    else
        ReStr = [ReLongStr(1), '.', ReLongStr(2:last_index), 'e', expon];
    end
    
    [~,indexcl] = max(cl)
    %% iunt, iuls, iutr, iuts, ilnt, ills, iltr, ilts --> (2,.....,9)
    %%
    f2 = figure(2);
    a2 = axes('Parent', f2);
    delete(a2)
    cla
    movegui(figure(2),'southwest');
    hold on
    plot(x_foil(1:ipstag+1 ),-cp_foil(1:ipstag+1),'color',...
        [0.6350 0.0780 0.1840],'linewidth',1.2)
    plot(x_foil(ipstag+1:end),-cp_foil(ipstag+1:end),'--','color',...
        [0.6350 0.0780 0.1840],'linewidth',1.2)
    legend('Upper surface','Lower surface')
    plt = yline(0,'k');
    markers = repmat(["ko","kx","ks","kd"],1,2);
    names = repmat(["natural transition","laminar separation",...
        "turbulent reattachment","turbulent separation"],1,2);
    for i = 2:9
        if iss(i) ~= 0 
            plot(x_foil(iss(i)),-cp_foil(iss(i)), markers(i-1),...
                'DisplayName' , names(i-1),'linewidth',1.2)
        end
    end
    legend(legendUnq)
    plt.Annotation.LegendInformation.IconDisplayStyle = 'off';
    hold off
    xlabel('x/c');
    ylabel('-cp');
    set(gca, 'FontName','Times', 'FontSize', 14);
    c1 = uicontrol;
    c1.String = 'Print to eps';
    c1.Callback = @plotButtonPushed1;
    %%
    %%
    f3 = figure(3);
    a3 = axes('Parent', f3);
    delete(a3)
    cla
    movegui(figure(3),'northeast');
    hold on
    plot(alphaswp,cl./cd, 'color' , [0.6350 0.0780 0.1840], 'linewidth' ,1.2)
    scatter(alphaswp(indexcl), cl(indexcl)/cd(indexcl),'x','k')
    yline(0,'k')
    hold off
    xlabel('\alpha')
    ylabel('L/D')
    set(gca, 'FontName','Times', 'FontSize', 14);
    c2 = uicontrol;
    c2.String = 'Print to eps';
    c2.Callback = @plotButtonPushed2;
    %%
    %%
    f4 = figure(4);
    a4 = axes('Parent', f4);
    delete(a4)
    cla
    subplot(2,1,1);
    cla % clear output
    xu = x_foil(1:ipstag+1);
    thetau = theta(1:ipstag+1);
    plot(xu,thetau,'color',...
        [0.6350 0.0780 0.1840],'linewidth',1.2)
    xlabel('x/c')
    ylabel('\theta/c')
    title('Upper momentum thickness')
    set(gca, 'FontName','Times', 'FontSize', 14,'FontWeight','normal');

    subplot(2,1,2);
    cla % clear output
    xl = x_foil(ipstag:end);
    thetal = theta(ipstag:end);
    plot(xl,thetal,'color',...
        [0.6350 0.0780 0.1840],'linewidth',1.2)
    xlabel('x/c')
    ylabel('\theta/c')
    title('Lower momentum thickness')
    set(gca, 'FontName','Times', 'FontSize', 14,'FontWeight','normal');
    
    c3 = uicontrol;
    c3.String = 'Print to eps';
    c3.Callback = @plotButtonPushed3;
    %%
    %%
    f5 = figure(5);
    a5 = axes('Parent', f5);
    delete(a5)
    cla
    hold on
    plot(alphaswp,cl, 'color' , [0.6350 0.0780 0.1840], 'linewidth' ,1.2)
    scatter(alphaswp(indexcl),cl(indexcl),'x','k')
    yline(0,'k')
    hold off
    xlabel('\alpha')
    ylabel('C_l')
    set(gca, 'FontName','Times', 'FontSize', 14);
    c4 = uicontrol;
    c4.String = 'Print to eps';
    c4.Callback = @plotButtonPushed4;
    %%
    f6 = figure(6);
    a6 = axes('Parent', f6);
    delete(a6)
    cla
    hold on
    plot(alphaswp,cd, 'color' , [0.6350 0.0780 0.1840], 'linewidth' ,1.2)
    yline(0,'k')
    hold off
    xlabel('\alpha')
    ylabel('C_d')
    set(gca, 'FontName','Times', 'FontSize', 14);
    c5 = uicontrol;
    c5.String = 'Print to eps';
    c5.Callback = @plotButtonPushed5;
    %%
    %%
    f7 = figure(7);
    a7 = axes('Parent', f7);
    delete(a7)
    cla
    hold on
    plot(cl,cd, 'color' , [0.6350 0.0780 0.1840], 'linewidth' ,1.2)
    yline(0,'k')
    hold off
    xlabel('C_l')
    ylabel('C_d')
    set(gca, 'FontName','Times', 'FontSize', 14);
    c6 = uicontrol;
    c6.String = 'Print to eps';
    c6.Callback = @plotButtonPushed6;
    %%
    %%
    function plotButtonPushed1(src,event)
        set(c1,'visible','off') % Avoid plotting "print to eps"
        print (gcf, ['LaTeX/Graphs/' speeddir '/' extractBefore(filein,".surf") ...
            '_' sd '_cp_' ReStr '_' num2str(alpha)], '-depsc')
        set(c1,'visible','on')
    end

    function plotButtonPushed2(src,event)
        set(c2,'visible','off') % Avoid plotting "print to eps"
        print (gcf, ['LaTeX/Graphs/' speeddir '/' extractBefore(filein,".surf") ...
             '_' sd '_LD_' ReStr ], '-depsc')
        set(c2,'visible','on')
    end

    function plotButtonPushed3(src,event)
        set(c3,'visible','off') % Avoid plotting "print to eps"
        print (gcf, ['LaTeX/Graphs/' speeddir '/' extractBefore(filein,".surf") ...
             '_' sd '_theta_' ReStr '_' num2str(alpha)], '-depsc')
        set(c3,'visible','on')
    end

    function plotButtonPushed4(src,event)
            set(c4,'visible','off') % Avoid plotting "print to eps"
            print (gcf, ['LaTeX/Graphs/' speeddir '/' extractBefore(filein,".surf") ...
                 '_' sd '_' 'cl_' ReStr '_' num2str(alpha)], '-depsc')
            set(c4,'visible','on')
    end

    function plotButtonPushed5(src,event)
            set(c5,'visible','off') % Avoid plotting "print to eps"
            print (gcf, ['LaTeX/Graphs/' speeddir '/' extractBefore(filein,".surf") ...
                 '_' sd '_cd_' ReStr '_' num2str(alpha)], '-depsc')
            set(c5,'visible','on')
    end

    function plotButtonPushed6(src,event)
            set(c6,'visible','off') % Avoid plotting "print to eps"
            print (gcf, ['LaTeX/Graphs/' speeddir '/' extractBefore(filein,".surf") ...
                 '_' sd '_clcd_' ReStr '_' num2str(alpha)], '-depsc')
            set(c6,'visible','on')
    end
    %%
end






