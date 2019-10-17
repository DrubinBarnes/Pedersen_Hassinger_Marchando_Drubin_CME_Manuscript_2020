function [trackStart, trackEnd, gfpInt, rfpInt] = plotRG(goodTrackData, ii)
trackStart = goodTrackData(ii).tp_prev_all;
trackEnd = goodTrackData(ii).tp_post_all;
[gfpInt] = goodTrackData(ii).ref_intensity_bg_corrected;
[rfpInt] = goodTrackData(ii).cor_intensity_bg_corrected;
figure
hold on
%plot(trackStart:trackEnd,gfpInt/max(gfpInt),'g','LineWidth',4)
%plot(trackStart:trackEnd,rfpInt/max(rfpInt),'r','LineWidth',4)
plot(trackStart:trackEnd,gfpInt,'g','LineWidth',4)
plot(trackStart:trackEnd,rfpInt,'m','LineWidth',4)
plot(trackStart:trackEnd,smooth(gfpInt,5),'b','LineWidth',4)
plot(trackStart:trackEnd,smooth(rfpInt,5),'r','LineWidth',4)
ax = gca;
ax.XLabel.String = 'Time (sec)';
ax.YLabel.String = 'Intensity (a.u.)';
ax.LineWidth = 2;
ax.Box = 'on';
ax.FontSize = 24;

SP=goodTrackData(ii).ref_tp_first; %your point goes here 
line([SP SP],get(ax,'YLim'),'Color','b')

end