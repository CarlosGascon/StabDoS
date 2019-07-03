function [] = generatemassplotsep(avect, mvect, MatStabP, MatStabH, MatStabG, Target)


a1 = Target.a;
m1 = Target.pmass;
load('cm.mat');

figure()

imagesc(log10([avect(1) avect(end)]), log10([mvect(1) mvect(end)]), MatStabH)
colormap(cm)
pbaspect([1.20, 1, 1])
cbar = colorbar();
t = title([Target.system, ' - Hill AMD Criterion'], 'Interpreter' , 'latex');
t.Position(2) = t.Position(2) + 3.5;
set(gca,'YDir', 'normal');

set(gca, 'XTick', [-1, 0, 0.30103, 0.69897, 1, 1.30103], 'XTickLabel', {'$0.1$', '$1$', '$2$' '$5$', '$10$', '$20$'})
set(gca, 'YTick', [-3, -2, -1,  0, 1, 2], 'YTickLabel', {'$0.001$', '$0.01$', '$0.1$' , '$1$', '$10$', '$100$'})
set(gca, 'TickLabelInterpreter','latex', 'Fontsize', 14);
set(cbar,'TickLabelInterpreter','latex',  'Fontsize', 12);
xlabel('$a \left(\textrm{AU}\right)$','Interpreter','latex', 'Fontsize', 14);
ylabel('$m \; \left(M_{\textrm{J}}\right)$','Interpreter','latex', 'Fontsize', 14);
set(cbar, 'YTick', [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.995], 'YTickLabel', {0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1})

y = ylabel(cbar, 'Probability of Stability','Interpreter','latex', 'Rotation', 270, 'Fontsize', 14);
y.Position(1) = y.Position(1) + 1.2;
hold on

%plot3([log10(2.5) log10(2.5)], log10([mvect(1) mvect(end)]), [0 0], '--w', 'Linewidth', 1.2);
plot3([log10(a1) log10(a1)], log10([m1 m1]), [0 0], '+w', 'MarkerSize', 35, 'Linewidth', 1)
plot3([log10(a1) log10(a1)], log10([m1 m1]), [0 0], 'sw', 'MarkerSize', 10, 'Linewidth', 1.75)
contour3(log10(avect), log10(mvect), MatStabH, [0.95 0.95],'--', 'Color', [162    82    45] / 255,  'Linewidth', 2)
print(['Figures/', Target.system, '_massHanalytic'], '-depsc')

figure()

imagesc(log10([avect(1) avect(end)]), log10([mvect(1) mvect(end)]), MatStabP)
colormap(cm)
pbaspect([1.20, 1, 1])
cbar = colorbar();
t = title([Target.system, ' - Petrovich''s Criterion'], 'Interpreter' , 'latex');
t.Position(2) = t.Position(2) + 3.5;
set(gca,'YDir', 'normal');

set(gca, 'XTick', [-1, 0, 0.30103, 0.69897, 1, 1.30103], 'XTickLabel', {'$0.1$', '$1$', '$2$' '$5$', '$10$', '$20$'})
set(gca, 'YTick', [-3, -2, -1,  0, 1, 2], 'YTickLabel', {'$0.001$', '$0.01$', '$0.1$' , '$1$', '$10$', '$100$'})
set(gca, 'TickLabelInterpreter','latex', 'Fontsize', 14);
set(cbar,'TickLabelInterpreter','latex',  'Fontsize', 12);
xlabel('$a \left(\textrm{AU}\right)$','Interpreter','latex', 'Fontsize', 14);
ylabel('$m \; \left(M_{\textrm{J}}\right)$','Interpreter','latex', 'Fontsize', 14);
set(cbar, 'YTick', [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.995], 'YTickLabel', {0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1})

y = ylabel(cbar, 'Probability of Stability','Interpreter','latex', 'Rotation', 270, 'Fontsize', 14);
y.Position(1) = y.Position(1) + 1.2;
hold on

%plot3([log10(2.5) log10(2.5)], log10([mvect(1) mvect(end)]), [0 0], '--w', 'Linewidth', 1.2);
plot3([log10(a1) log10(a1)], log10([m1 m1]), [0 0], '+w', 'MarkerSize', 35, 'Linewidth', 1)
plot3([log10(a1) log10(a1)], log10([m1 m1]), [0 0], 'sw', 'MarkerSize', 10, 'Linewidth', 1.75)
contour3(log10(avect), log10(mvect), MatStabP, [0.95 0.95],'--', 'Color', [162    82    45] / 255,  'Linewidth', 2)

print(['Figures/', Target.system, '_massPanalytic'], '-depsc')
figure()

imagesc(log10([avect(1) avect(end)]), log10([mvect(1) mvect(end)]), MatStabG)
colormap(cm)
pbaspect([1.20, 1, 1])
cbar = colorbar();
t = title([Target.system, ' - Giuppone''s Mod. Criterion'], 'Interpreter' , 'latex');
t.Position(2) = t.Position(2) + 3.5;
set(gca,'YDir', 'normal');

set(gca, 'XTick', [-1, 0, 0.30103, 0.69897, 1, 1.30103], 'XTickLabel', {'$0.1$', '$1$', '$2$' '$5$', '$10$', '$20$'})
set(gca, 'YTick', [-3, -2, -1,  0, 1, 2], 'YTickLabel', {'$0.001$', '$0.01$', '$0.1$' , '$1$', '$10$', '$100$'})
set(gca, 'TickLabelInterpreter','latex', 'Fontsize', 14);
set(cbar,'TickLabelInterpreter','latex',  'Fontsize', 12);
xlabel('$a \left(\textrm{AU}\right)$','Interpreter','latex', 'Fontsize', 14);
ylabel('$m \; \left(M_{\textrm{J}}\right)$','Interpreter','latex', 'Fontsize', 14);
set(cbar, 'YTick', [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.995], 'YTickLabel', {0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1})

y = ylabel(cbar, 'Probability of Stability','Interpreter','latex', 'Rotation', 270, 'Fontsize', 14);
y.Position(1) = y.Position(1) + 1.2;
hold on

%plot3([log10(2.5) log10(2.5)], log10([mvect(1) mvect(end)]), [0 0], '--w', 'Linewidth', 1.2);
plot3([log10(a1) log10(a1)], log10([m1 m1]), [0 0], '+w', 'MarkerSize', 35, 'Linewidth', 1)
plot3([log10(a1) log10(a1)], log10([m1 m1]), [0 0], 'sw', 'MarkerSize', 10, 'Linewidth', 1.75)
contour3(log10(avect), log10(mvect), MatStabG, [0.95 0.95],'--', 'Color', [162    82    45] / 255,  'Linewidth', 2)
print(['Figures/', Target.system, '_massGanalytic'], '-depsc')

end

