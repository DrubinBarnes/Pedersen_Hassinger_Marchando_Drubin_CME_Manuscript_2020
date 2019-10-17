function [trackStart, trackEnd, gfpInt, rfpInt] = plotRGnorm(goodTrackData, ii)
trackStart = goodTrackData(ii).tp_prev_all;
trackEnd = goodTrackData(ii).tp_post_all;
[gfpInt] = goodTrackData(ii).ref_intensity_bg_corrected;
[rfpInt] = goodTrackData(ii).cor_intensity_bg_corrected;
figure
hold on
plot(trackStart:trackEnd,gfpInt/max(gfpInt),'g','LineWidth',4)
plot(trackStart:trackEnd,rfpInt/max(rfpInt),'r','LineWidth',4)
plot(trackStart:trackEnd,smooth(gfpInt/max(gfpInt),3),'b','LineWidth',4)
plot(trackStart:trackEnd,smooth(rfpInt/max(rfpInt),3),'m','LineWidth',4)
%plot(trackStart:trackEnd,gfpInt,'g','LineWidth',4)
%plot(trackStart:trackEnd,rfpInt,'r','LineWidth',4)
%plot(trackStart:trackEnd,smooth(gfpInt),'b','LineWidth',4)
%plot(trackStart:trackEnd,smooth(rfpInt),'m','LineWidth',4)
ax = gca;
ax.XLabel.String = 'Time (sec)';
ax.YLabel.String = 'Intensity (a.u.)';
ax.LineWidth = 2;
ax.Box = 'on';
ax.FontSize = 24;

end