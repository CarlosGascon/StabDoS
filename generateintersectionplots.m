function [] = generateintersectionplots(avect, Rvect, GStabP, GStabH, GStabG, GOcc, GDoS, GtotP, GtotH, GtotG, Target)

% Function for generating plots

apoints = (log10(avect(2 : end)) + log10(avect(1 : end - 1))) ./ 2; 
Rpoints = (log10(Rvect(2 : end)) + log10(Rvect(1 : end - 1))) ./ 2;

a1 = Target.a;
R1 = RfromM(Target.pmass);

[X, Y] = meshgrid(apoints, Rpoints);

load('cm.mat');


figure()
GStabH(GStabH == 0) = nan;
colormap(cm)
b = imagesc(apoints, Rpoints, GStabH);
set(b,'AlphaData',~isnan(GStabH))
set(gca, 'YDir', 'normal')
format long
ax = gca;
pbaspect([1.20, 1, 1])
t = title([Target.system, ' - Stability Grid - Hill AMD Crit.'], 'Interpreter' , 'latex');
t.Position(2) = t.Position(2) + 0.025;
cbar = colorbar();
set(gca, 'XTick', [-1, 0, 0.30103, 0.69897, 1, 1.30103], 'XTickLabel', {'$0.1$', '$1$', '$2$' '$5$', '$10$', '$20$'})
set(gca, 'YTick', [0.6990, 0.8451, 0.9452,  1.0414, 1.1461, 1.2304], 'YTickLabel', {'$5$', '$7$', '$9$' , '$11$','14', '$17$'})
set(gca, 'TickLabelInterpreter','latex', 'Fontsize', 14);
set(cbar,'TickLabelInterpreter','latex', 'Fontsize', 12);
set(cbar, 'YTick', [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.999], 'YTickLabel', {0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1})
xlabel('$a \left(\textrm{AU}\right)$','Interpreter','latex');
ylabel('$R \; (R_{\oplus})$','Interpreter','latex');
y = ylabel(cbar, 'Probability of Stability','Interpreter','latex', 'Rotation', 270, 'Fontsize', 14);
y.Position(1) = y.Position(1) + 1.3;
hold on
plot3([log10(a1) log10(a1)], log10([R1 R1]), [0 0], '+', 'Color', [0 0 0] / 255, 'MarkerSize', 35, 'Linewidth', 1)
plot3([log10(a1) log10(a1)], log10([R1 R1]), [0 0], 's', 'Color', [0 0 0] / 255, 'MarkerSize', 10, 'Linewidth', 1.75)
view(2);
%print(['Figures/', Target.system, '_stabH'], '-depsc')


figure()
GStabP(GStabP == 0) = nan;
colormap(cm)
b = imagesc(apoints, Rpoints, GStabP);
set(b,'AlphaData',~isnan(GStabP))
set(gca, 'YDir', 'normal')
pbaspect([1.20, 1, 1])
t = title([Target.system, ' - Stability Grid - Petrovich''s Crit.'], 'Interpreter' , 'latex');
t.Position(2) = t.Position(2) + 0.025;
cbar = colorbar();
set(gca, 'XTick', [-1, 0, 0.30103, 0.69897, 1, 1.30103], 'XTickLabel', {'$0.1$', '$1$', '$2$' '$5$', '$10$', '$20$'})
set(gca, 'YTick', [0.6990, 0.8451, 0.9452,  1.0414, 1.1461, 1.2304], 'YTickLabel', {'$5$', '$7$', '$9$' , '$11$','14', '$17$'})
set(gca, 'TickLabelInterpreter','latex', 'Fontsize', 14);
set(cbar,'TickLabelInterpreter','latex', 'Fontsize', 12);
%set(cbar, 'YTick', [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.999], 'YTickLabel', {0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1})
xlabel('$a \left(\textrm{AU}\right)$','Interpreter','latex');
ylabel('$R \; (R_{\oplus})$','Interpreter','latex');
y = ylabel(cbar, 'Probability of Stability','Interpreter','latex', 'Rotation', 270, 'Fontsize', 14);
y.Position(1) = y.Position(1) + 1.3;
hold on
plot3([log10(a1) log10(a1)], log10([R1 R1]), [0 0], '+', 'Color', [0 0 0] / 255, 'MarkerSize', 35, 'Linewidth', 1)
plot3([log10(a1) log10(a1)], log10([R1 R1]), [0 0], 's', 'Color', [0 0 0] / 255, 'MarkerSize', 10, 'Linewidth', 1.75)
view(2);
%print(['Figures/', Target.system, '_stabP'], '-depsc')


figure()
GStabG(GStabG == 0) = nan;
colormap(cm)
b = imagesc(apoints, Rpoints, GStabG);
set(b,'AlphaData',~isnan(GStabG))
set(gca, 'YDir', 'normal')
pbaspect([1.20, 1, 1])
t = title([Target.system, ' - Stability Grid - Giuppone''s Mod. Crit.'], 'Interpreter' , 'latex');
t.Position(2) = t.Position(2) + 0.025;
cbar = colorbar();
set(gca, 'XTick', [-1, 0, 0.30103, 0.69897, 1, 1.30103], 'XTickLabel', {'$0.1$', '$1$', '$2$' '$5$', '$10$', '$20$'})
set(gca, 'YTick', [0.6990, 0.8451, 0.9452,  1.0414, 1.1461, 1.2304], 'YTickLabel', {'$5$', '$7$', '$9$' , '$11$','14', '$17$'})
set(gca, 'TickLabelInterpreter','latex', 'Fontsize', 14);
set(cbar,'TickLabelInterpreter','latex', 'Fontsize', 12);
set(cbar, 'YTick', [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.999], 'YTickLabel', {0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1})

xlabel('$a \left(\textrm{AU}\right)$','Interpreter','latex');
ylabel('$R \; (R_{\oplus})$','Interpreter','latex');
y = ylabel(cbar, 'Probability of Stability','Interpreter','latex', 'Rotation', 270, 'Fontsize', 14);
y.Position(1) = y.Position(1) + 1.3;
hold on
plot3([log10(a1) log10(a1)], log10([R1 R1]), [0 0], '+', 'Color', [0 0 0] / 255, 'MarkerSize', 35, 'Linewidth', 1)
plot3([log10(a1) log10(a1)], log10([R1 R1]), [0 0], 's', 'Color', [0 0 0] / 255, 'MarkerSize', 10, 'Linewidth', 1.75)
view(2);
%print(['Figures/', Target.system, '_stabG'], '-depsc')


figure

colormap(cm)
GDoS(GDoS == 0) = nan;
b = imagesc(apoints, Rpoints, GDoS);
set(b,'AlphaData',~isnan(GDoS))
set(gca, 'YDir', 'normal')
pbaspect([1.20, 1, 1])
t = title([Target.system, ' - Depth-of-Search Grid'], 'Interpreter' , 'latex');
t.Position(2) = t.Position(2) + 0.025;
cbar = colorbar();
set(gca, 'XTick', [-1, 0, 0.30103, 0.69897, 1, 1.30103], 'XTickLabel', {'$0.1$', '$1$', '$2$' '$5$', '$10$', '$20$'})
set(gca, 'YTick', [0.6990, 0.8451, 0.9452,  1.0414, 1.1461, 1.2304], 'YTickLabel', {'$5$', '$7$', '$9$' , '$11$','14', '$17$'})
set(gca, 'TickLabelInterpreter','latex', 'Fontsize', 14);
set(cbar,'TickLabelInterpreter','latex', 'Fontsize', 12);
xlabel('$a \left(\textrm{AU}\right)$','Interpreter','latex');
ylabel('$R\;(R_{\oplus})$','Interpreter','latex');
y = ylabel(cbar, 'Depth-of-Search','Interpreter','latex', 'Rotation', 270, 'Fontsize', 14);
y.Position(1) = y.Position(1) + 1.3;
hold on
plot3([log10(a1) log10(a1)], log10([R1 R1]), [0 0], '+', 'Color', [0 0 0], 'MarkerSize', 35, 'Linewidth', 1)
plot3([log10(a1) log10(a1)], log10([R1 R1]), [0 0], 's', 'Color', [0 0 0], 'MarkerSize', 10, 'Linewidth', 1.75)
view(2);

%print(['Figures/', Target.system, '_dos'], '-depsc')


figure

colormap(cm)

contourf(X, Y, GOcc, 15);
set(gca, 'YScale', 'log', 'XScale', 'log');
pbaspect([1.20, 1, 1])
grid on; grid minor;
cbar = colorbar();
t = title([Target.system, ' - Occurrence Grid'], 'Interpreter' , 'latex');
t.Position(2) = t.Position(2) + 0.5;
set(gca, 'TickLabelInterpreter','latex', 'Fontsize', 14);
set(cbar,'TickLabelInterpreter','latex', 'Fontsize', 12);
xlabel('$a \left(\textrm{AU}\right)$','Interpreter','latex');
ylabel('$R \; (R_{\oplus})$','Interpreter','latex');
y = ylabel(cbar, 'Occurrence Rate','Interpreter','latex', 'Rotation', 270, 'Fontsize', 14);
y.Position(1) = y.Position(1) + 1.3;
%print(['Figures/', Target.system, '_occ'], '-depsc')


figure
GtotH(GtotH == 0) = nan;
colormap(cm)
b = imagesc(apoints, Rpoints, GtotH);
set(b,'AlphaData',~isnan(GtotH))
set(gca, 'YDir', 'normal')
pbaspect([1.20, 1, 1])
cbar = colorbar();
t = title([Target.system,' - Intersection Grid - Hill AMD Crit.'], 'Interpreter' , 'latex');
t.Position(2) = t.Position(2) + 0.025;
set(gca, 'XTick', [-1, 0, 0.30103, 0.69897, 1, 1.30103], 'XTickLabel', {'$0.1$', '$1$', '$2$' '$5$', '$10$', '$20$'})
set(gca, 'YTick', [0.6990, 0.8451, 0.9452,  1.0414, 1.1461, 1.2304], 'YTickLabel', {'$5$', '$7$', '$9$' , '$11$','14', '$17$'})
set(gca, 'TickLabelInterpreter','latex', 'Fontsize', 14);
set(cbar,'TickLabelInterpreter','latex', 'Fontsize', 12);
xlabel('$a \left(\textrm{AU}\right)$','Interpreter','latex');
ylabel('$R \; (R_{\oplus})$','Interpreter','latex');
y = ylabel(cbar, 'Dynamically Stable DoS','Interpreter','latex', 'Rotation', 270, 'Fontsize', 14);
y.Position(1) = y.Position(1) + 1.3;
hold on
plot3([log10(a1) log10(a1)], log10([R1 R1]), [0 0], '+', 'Color', [0 0 0] / 255, 'MarkerSize', 35, 'Linewidth', 1)
plot3([log10(a1) log10(a1)], log10([R1 R1]), [0 0], 's', 'Color', [0 0 0] / 255, 'MarkerSize', 10, 'Linewidth', 1.75)
view(2);
%print(['Figures/', Target.system, '_totH'], '-depsc')


figure
GtotP(GtotP == 0) = nan;
colormap(cm)
b = imagesc(apoints, Rpoints, GtotP);
set(b,'AlphaData',~isnan(GtotP))
set(gca, 'YDir', 'normal')
pbaspect([1.20, 1, 1])
cbar = colorbar();
t = title([Target.system,' - Intersection Grid - Petrovich''s Crit.'], 'Interpreter' , 'latex');
t.Position(2) = t.Position(2) + 0.025;
set(gca, 'XTick', [-1, 0, 0.30103, 0.69897, 1, 1.30103], 'XTickLabel', {'$0.1$', '$1$', '$2$' '$5$', '$10$', '$20$'})
set(gca, 'YTick', [0.6990, 0.8451, 0.9452,  1.0414, 1.1461, 1.2304], 'YTickLabel', {'$5$', '$7$', '$9$' , '$11$','14', '$17$'})
set(gca, 'TickLabelInterpreter','latex', 'Fontsize', 14);
set(cbar,'TickLabelInterpreter','latex', 'Fontsize', 12);
xlabel('$a \left(\textrm{AU}\right)$','Interpreter','latex');
ylabel('$R \; (R_{\oplus})$','Interpreter','latex');
y = ylabel(cbar, 'Dynamically Stable DoS','Interpreter','latex', 'Rotation', 270, 'Fontsize', 14);
y.Position(1) = y.Position(1) + 1.3;
hold on
plot3([log10(a1) log10(a1)], log10([R1 R1]), [0 0], '+', 'Color', [0 0 0] / 255, 'MarkerSize', 35, 'Linewidth', 1)
plot3([log10(a1) log10(a1)], log10([R1 R1]), [0 0], 's', 'Color', [0 0 0] / 255, 'MarkerSize', 10, 'Linewidth', 1.75)
view(2);
%print(['Figures/', Target.system, '_totP'], '-depsc')


figure
GtotG(GtotG == 0) = nan;
colormap(cm)
b = imagesc(apoints, Rpoints, GtotG);
set(b,'AlphaData',~isnan(GtotG))
set(gca, 'YDir', 'normal')
pbaspect([1.20, 1, 1])
cbar = colorbar();
t = title([Target.system,' - Intersection Grid - Giuppone''s Mod. Crit.'], 'Interpreter' , 'latex');
t.Position(2) = t.Position(2) + 0.025;
set(gca, 'XTick', [-1, 0, 0.30103, 0.69897, 1, 1.30103], 'XTickLabel', {'$0.1$', '$1$', '$2$' '$5$', '$10$', '$20$'})
set(gca, 'YTick', [0.6990, 0.8451, 0.9452,  1.0414, 1.1461, 1.2304], 'YTickLabel', {'$5$', '$7$', '$9$' , '$11$','14', '$17$'})
set(gca, 'TickLabelInterpreter','latex', 'Fontsize', 14);
set(cbar,'TickLabelInterpreter','latex', 'Fontsize', 12);
xlabel('$a \left(\textrm{AU}\right)$','Interpreter','latex');
ylabel('$R \; (R_{\oplus})$','Interpreter','latex');
y = ylabel(cbar, 'Dynamically Stable DoS','Interpreter','latex', 'Rotation', 270, 'Fontsize', 14);
y.Position(1) = y.Position(1) + 1.3;
hold on
plot3([log10(a1) log10(a1)], log10([R1 R1]), [0 0], '+', 'Color', [0 0 0] / 255, 'MarkerSize', 35, 'Linewidth', 1)
plot3([log10(a1) log10(a1)], log10([R1 R1]), [0 0], 's', 'Color', [0 0 0] / 255, 'MarkerSize', 10, 'Linewidth', 1.75)
view(2);
%print(['Figures/', Target.system, '_totG'], '-depsc')



end

