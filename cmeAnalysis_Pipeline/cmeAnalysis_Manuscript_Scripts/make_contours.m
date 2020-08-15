% Paul Marchando
% Drubin Lab
% 04-26-20

% This script loads the data for a protein of interest, filters the tracks,
% and then plots contour lines containing 50%, 75%, and 90% of the data on
% the original scatterplots.

protein_name = input('Protein name: ', 's');

load(['goodTrackData_' protein_name '.mat'])

window = 1;
spf = 1;

goodTrackData = calculateTwoColorStatsSmoothed(goodTrackData, window, spf);
[TF_ref_cor, goodTrackData] = filter_tracks(goodTrackData);
goodTracks = goodTrackData(~TF_ref_cor);

makeScatterFit_FvsL_1
[n,c,indices] = contour_percent(gfpLifetime, maxGFP);
[m,x] = contour(c{1},c{2},n',indices);
x.LineWidth = 3;
delete(h)
delete(hl)

makeScatterFit_FvsL
[n,c,indices] = contour_percent(gfpLifetime, maxRFP);
[m,x] = contour(c{1},c{2},n',indices);
x.LineWidth = 3;
delete(h)
delete(hl)

makeScatterFit_LvsL
[n,c,indices] = contour_percent(gfpLifetime, rfpLifetime);
[m,x] = contour(c{1},c{2},n',indices);
x.LineWidth = 3;
delete(h)
delete(hl)
