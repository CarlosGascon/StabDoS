function [] = generatecomplot(Res)

Res = table2array(Res(:, [2 : end]))

SCompP = Res(:, 6);
SCompG = Res(:, 8);
SCompH = Res(:, 10);

figure


plot(Res(:, 1),SCompP(:), 'o', 'MarkerEdgeColor', [0.403894278000000,0.0855803445000000,0.433178526000000]) 
hold on
plot(Res(:, 1), SCompG(:), '*', 'MarkerEdgeColor', [0.741423185000000,0.219111589000000,0.326576275000000]) 
hold on
plot(Res(:, 1), SCompH(:), '+', 'MarkerEdgeColor', [0.985315301000000,0.608422211000000,0.0242021174000000]) 
hold on

xlim([0, 50])
ylim([1e-4, 0.41])

set(gca, 'TickLabelInterpreter','latex', 'Fontsize', 14);
xlabel('$d \left(\textrm{pc}\right)$','Interpreter','latex');
ylabel('Stable Completeness','Interpreter','latex');
lg = legend( 'Petrovich''s Crit.', 'Giuppone''s Mod. Crit.','Hill AMD Crit.');
set(lg, 'Interpreter', 'latex')

SCompP(SCompP(:) < 1e-3) = 1e-3;
SCompG(SCompG(:) < 1e-3) = 1e-3;
SCompH(SCompH(:) < 1e-3) = 1e-3;
figure

semilogy(Res(:, 1), SCompP(:), 'o', 'MarkerEdgeColor', [0.403894278000000,0.0855803445000000,0.433178526000000]) 
hold on
semilogy(Res(:, 1), SCompG(:), '*', 'MarkerEdgeColor', [0.741423185000000,0.219111589000000,0.326576275000000]) 
hold on
semilogy(Res(:, 1), SCompH(:), '+', 'MarkerEdgeColor', [0.985315301000000,0.608422211000000,0.0242021174000000]) 
hold on
xlim([0, 50])
ylim([1e-3, 0.5])

set(gca, 'TickLabelInterpreter','latex', 'Fontsize', 12);
xlabel('$d \left(\textrm{pc}\right)$','Interpreter','latex');
ylabel('Stable Completeness','Interpreter','latex');
lg = legend( 'Petrovich''s Crit.', 'Giuppone''s Mod. Crit.','Hill AMD Crit.');
set(lg, 'Interpreter', 'latex')

%print('Figures/CompPlot', '-depsc')
end

