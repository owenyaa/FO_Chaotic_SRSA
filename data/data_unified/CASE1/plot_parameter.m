figure;
load case10(20_0.005_0.05noise)(0.1,0.1).mat;
plot(1:1:iii,a1,'k*-','LineWidth',1.5);
hold on;
plot(1:1:iii,a2,'k*:','LineWidth',1.5);
hold on;

load case6(20_0.005_0.05noise).mat
plot(1:1:iii,a1,'rx-','LineWidth',1.5);
hold on;
plot(1:1:iii,a2,'rx:','LineWidth',1.5);
hold on;

load case11(20_0.005_0.05noise)(1,1).mat;
plot(1:1:iii,a1,'go-','LineWidth',1.5);
hold on;
plot(1:1:iii,a2,'go:','LineWidth',1.5);



% set(gca,'LineWidth',1.5);set(gca,'FontSize',15);
% h1=legend('$$a$$','$$q$$');
% set(h1,'Interpreter','latex','FontSize',15);
% set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1.5);