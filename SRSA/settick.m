%% Author : TAO ZHANG  * zt1996nic@gmail.com *
% Created Time : 2022-10-01 08:58
% Last Revised : TAO ZHANG ,2023-03-19
% Remark : settick
% Model ref: Parameter Estimation of Fractional-Order Chaotic Systems 
% Based on Stepwise Integration and Response Sensitivity Analysis

function settick(axis,ticks)
n=length(ticks);
tkx=get(gca,'XTick');tky=get(gca,'YTick');
switch axis
    case 'x'
        w=linspace(tkx(1),tkx(end),n);
        set(gca, 'XTick', w, 'XTickLabel', []);
        yh=(14*w(1)-w(end))/13;

        for i=1:n
            text('Interpreter','latex','String',ticks(i),'Position',[w(i),-0.1],'horizontalAlignment', 'center','FontName','Times New Roman','FontSize',15);
        end
    case 'y'
        w=linspace(tky(1),tky(end),n);
        set(gca, 'YTick', w, 'YTickLabel', []);
        xh=(11*w(1)-w(end))/10;
        for i=1:n
            text('Interpreter','latex','String',ticks(i),'Position',[-0.1,w(i)],'horizontalAlignment', 'center','FontName','Times New Roman','FontSize',15);
        end
end