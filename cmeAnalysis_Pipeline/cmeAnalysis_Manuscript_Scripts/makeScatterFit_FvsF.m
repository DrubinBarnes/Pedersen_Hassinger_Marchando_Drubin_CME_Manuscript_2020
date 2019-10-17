%% Makes RFP fluorescence vs. GFP fluorescence scatter fit plot
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
h = scatter_kde(maxGFP',maxRFP', 'MarkerSize',100,'filled');
[l, gof_l] = fit(maxGFP', maxRFP','poly1');
hold on

ax = gca;
xlim([0 max(max(maxGFP)+(100-mod(max(maxGFP),100)),100)])
ylim([0 max(max(maxRFP)+(100-mod(max(maxRFP),100)),100)])
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

ax.XLabel.String = 'GFP Intensity (a.u.)';
ax.YLabel.String = 'RFP Intensity (a.u.)';