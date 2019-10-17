function plotTwoColorStats(data, XVar, YVar)

X = extractfield(data,XVar);
Y = extractfield(data,YVar);

figure

%h = scatter_kde(X',Y', 'MarkerSize',100,'filled');
h = scatter(X',Y','filled');

ax = gca;
xlim([0 max(X)*1.1])
ylim([0 max(Y)*1.1])
ax.LineWidth = 4;
ax.FontSize = 32;
h.SizeData = 200;
ax.Box = 'on';

ax.XLabel.String = XVar;
ax.YLabel.String = YVar;


end