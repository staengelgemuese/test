x = linspace(-2,2);
y = x.^3;
x1 = -2/3;
x2= 2/3;
mean1 = mean(y(1:33));
mean2 = mean(y(34:66));
mean3 = mean(y(67:100));


figure
plot(x,y, 'black', 'LineWidth',2)
set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', []);
y1=get(gca,'ylim');
hold on
plot([x1 x1],y1, 'black')
hold on
plot([x2 x2],y1, 'black')
hold on
plot([-2, -2/3], [mean1, mean1], 'r', 'LineWidth',2);
hold on
plot([-2/3, 2/3], [mean2, mean2], 'r', 'LineWidth',2);
hold on
plot([2/3, 2], [mean3, mean3], 'r', 'LineWidth',2);
hold off

figure
plot(x,y, 'black', 'LineWidth',2)
set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', []);
hold on
plot([x1 x1],y1, 'black')
hold on
plot([x2 x2],y1, 'black')
hold on
plot([-2, -2/3], [y(1), y(33)], 'r', 'LineWidth',2);
hold on
plot([-2/3, 2/3], [y(33), y(66)], 'r', 'LineWidth',2);
hold on
plot([2/3, 2], [y(66), y(100)], 'r', 'LineWidth',2);

figure
plot(x,y, 'black', 'LineWidth',2)
set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', []);
hold on
plot([x1 x1],y1, 'black')
hold on
plot([x2 x2],y1, 'black')
hold on
yp1 = polyfit(x(1:34), y(1:34), 1)
plot(x(1:34), polyval(yp1, x(1:34)), 'r', 'LineWidth',2);
yp2 = polyfit(x(34:67), y(34:67), 1)
plot(x(34:67), polyval(yp2, x(34:67)), 'r', 'LineWidth',2);
yp3 = polyfit(x(67:100), y(67:100), 1)
plot(x(67:100), polyval(yp3, x(67:100)), 'r', 'LineWidth',2);


