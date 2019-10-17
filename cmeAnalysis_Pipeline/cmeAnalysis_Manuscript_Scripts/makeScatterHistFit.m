find_outliers

figure
sh1 = scatterhist(lifetime_associated(~TF_gfp_rfp,1),lifetime_associated(~TF_gfp_rfp,2), ...
    'MarkerSize',10, 'LineWidth', 5);
[l, gof_l] = fit(lifetime_associated(~TF_gfp_rfp,1), lifetime_associated(~TF_gfp_rfp,2),'poly1');
hold on
hl = plot(l);
hl.LineWidth = 4;
ax1 = sh1(1);
ax2 = sh1(2);
ax3 = sh1(3);

ax1.LineWidth = 4;
ax1.FontSize = 32;
ax1.Children(2).MarkerFaceColor = ax1.Children(2).Color;
ax2.Children.LineWidth = 4;
ax3.Children.LineWidth = 4;

lg = legend;
lg.String = sprintf('R^2 = %0.2f', gof_l.rsquare);

%{
figure
sh2 = scatterhist(lifetime_associated(~TF_gfp_rfp,1),maxRFP(~TF_gfp_rfp));
[f, gof_f] = fit(lifetime_associated(~TF_gfp_rfp,1), maxGFP(~TF_gfp_rfp)','poly1');

hold on
hf = plot(f);
hf.LineWidth = 4;
ax4 = sh2(1);
ax5 = sh2(2);
ax6 = sh2(3);

ax4.LineWidth = 4;
ax4.FontSize = 32;
ax4.Children(2).MarkerFaceColor = ax4.Children(2).Color;
ax5.Children.LineWidth = 4;
ax6.Children.LineWidth = 4;
%}