clc;
clear all;
%% Constants
eta_overall = [0.75, 0.8, 0.9]; %Overall aircraft efficiency
E = [1:2500]*3600; %[Wh/kg] battery pack specific energy
f = [0.2,0.4,0.6]; %Battery mass fraction
LD_ratio = 10; %Lift-drag ratio (supposed constant)
g = 9.81;

%% Range computation
for i=1:3 %f
    for k=1:3 %eta
        for j=1:2500 %E
             R(i,j,k) = (eta_overall(k)*E(j)*f(i)*LD_ratio*(1/g))/1000;
        end
        
        figure(1)
        xlabel('Specific Energy [Wh/kg]','fontweight','bold')
        ylabel('Range [km]','fontweight','bold')
        
        if i==1
            if k==1
                plot(R(i,:,k),'b-')
                hold on
            end
            if k==2
                plot(R(i,:,k),'b--')
                hold on
            end
            if k==3
                plot(R(i,:,k),'b-.')
                hold on
%                 text(2000,600,'f = 0,2','Color','blue')
            end
        end
        
        if i==2
            if k==1
                plot(R(i,:,k),'r-')
                hold on
            end
            if k==2
                plot(R(i,:,k),'r--')
                hold on
            end
            if k==3
                plot(R(i,:,k),'r-.')
                hold on
%                 text(2000,1600,'f = 0,4','Color','red')
            end
        end
        
        if i==3
            if k==1
                plot(R(i,:,k),'g-')
                hold on
            end
            if k==2
                plot(R(i,:,k),'g--')
                hold on
            end
            if k==3
                plot(R(i,:,k),'g-.')
                hold on
%                 text(2000,3800,'f = 0,6','Color','green')
            end
        end
    end 
end

xline(265,'k--','Label','Li-ion')
xline(450,'k--','Label','Li-S')
xline(1700,'k--','Label','Li-air')
yline(1500,'r-')
grid on

legend('$\eta = 0,7$','$\eta = 0,8$','$\eta = 0,9$','Interpreter','latex')