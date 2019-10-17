figure
h = scatter_kde(gfpLifetime(~TF_gfp_rfp)',maxGFP(~TF_gfp_rfp)', 'MarkerSize',100,'filled');
[l, gof_l] = fit(gfpLifetime(~TF_gfp_rfp)',maxGFP(~TF_gfp_rfp)','poly1');
hold on

ax = gca;
xlim([0 max(max(gfpLifetime(~TF_gfp_rfp))+(10-mod(max(gfpLifetime(~TF_gfp_rfp)),10)), 25)])
ylim([0 max(maxGFP(~TF_gfp_rfp))*1.1])
ax.LineWidth = 4;
ax.FontSize = 32;
h.SizeData = 200;
ax.Box = 'on';

hl = plot(l);
hl.LineWidth = 6;
cb = colorbar();
cb.Label.String = 'Normalized data density';
cb.LineWidth = 4;

lg = legend;
lg.String = sprintf('R^2 = %0.2f', gof_l.rsquare);
lg.Location = 'southeast';

ax.XLabel.String = 'GFP Lifetime (sec)';
ax.YLabel.String = 'GFP Intensity (a.u.)';