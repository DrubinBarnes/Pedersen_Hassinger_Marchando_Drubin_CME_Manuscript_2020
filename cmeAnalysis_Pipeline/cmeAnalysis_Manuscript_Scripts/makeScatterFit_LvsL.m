%% Makes RFP lifetime vs. GFP lifetime scatter fit plot
%
%   Julian Hassinger
%   Biophysics Graduate Group
%   David Drubin Lab
%   University of California, Berkeley
%
%   Copyright 2019
%
%   Last Edited: 8/5/2019
%
%% Requirements
% scatter_kde.m for plotting
% data structure is named goodTracks (recommended after using
% filter_tracks.m)


maxRFP = [goodTracks.max_cor];
maxGFP = [goodTracks.max_ref];
gfpLifetime = [goodTracks.ref_lifetime];
rfpLifetime = [goodTracks.cor_lifetime];

figure
h = scatter_kde(gfpLifetime',rfpLifetime', 'MarkerSize',100,'filled');
[l, gof_l] = fit(gfpLifetime', rfpLifetime','poly1');
hold on

ax = gca;
xlim([0 max(max(gfpLifetime)+(10-mod(max(gfpLifetime),10)), 25)])
ylim([0 max(max(rfpLifetime)+(10-mod(max(rfpLifetime),10)),25)])
ax.LineWidth = 4;
ax.FontSize = 52;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
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
ax.YLabel.String = 'RFP Lifetime (sec)';