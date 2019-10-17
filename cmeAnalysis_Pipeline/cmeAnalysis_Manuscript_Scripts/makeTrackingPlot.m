%% Makes a plot of the tracking output for systematicImaging panel B
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
%%

spf = 1;
window = 1;
goodTrackData = calculateTwoColorStatsSmoothed(goodTrackData, window, spf);
goodTracks = goodTrackData(~TF_ref_cor);
Las17 = [goodTracks(15).ref_coord]-[goodTracks(15).ref_coord(1,:)];
Abp1 = [goodTracks(15).cor_coord]-[goodTracks(15).ref_coord(1,:)];

figure
hold on
plot(Las17(:,1),Las17(:,2),'g','Linewidth',4)
scatter(Las17(1,1),Las17(1,2),500,'k','filled');
scatter(Las17(end,1),Las17(end,2),1000,'k','x','Linewidth',4);

plot(Abp1(:,1),Abp1(:,2),'m','Linewidth',4)
scatter(Abp1(1,1),Abp1(1,2),500,'k','filled');
scatter(Abp1(end,1),Abp1(end,2),1000,'k','x','Linewidth',4);
daspect([1,1,1])

line([100,150],[-40,-40],'LineWidth',10,'Color','k');

ax = gca;
ax.Visible = 'off';