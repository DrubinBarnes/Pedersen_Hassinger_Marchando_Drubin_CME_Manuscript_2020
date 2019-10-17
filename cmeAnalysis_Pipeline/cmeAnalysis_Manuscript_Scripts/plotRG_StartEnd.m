function [trackStart, trackEnd, gfpInt, rfpInt] = plotRG_StartEnd(goodTrackData, ii)
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
plot(trackStart:trackEnd,smooth(gfpInt,3),'--b','LineWidth',4)
plot(trackStart:trackEnd,smooth(rfpInt,3),'--r','LineWidth',4)
ax = gca;
ax.XLabel.String = 'Time (sec)';
ax.YLabel.String = 'Intensity (a.u.)';
ax.LineWidth = 2;
ax.Box = 'on';
ax.FontSize = 24;

%{
line(goodTrackData(ii).ref_tp_first*[1 1],get(ax,'YLim'),'Color','g','LineWidth',2)
line(goodTrackData(ii).ref_tp_last*[1 1],get(ax,'YLim'),'Color','g','LineWidth',2)
line(goodTrackData(ii).cor_tp_first*[1 1],get(ax,'YLim'),'Color','m','LineWidth',2)
line(goodTrackData(ii).cor_tp_last*[1 1],get(ax,'YLim'),'Color','m','LineWidth',2)
%}


%line(goodTrackData(ii).ref_peak*[1 1],get(ax,'YLim'),'Color','b','LineWidth',2)
%line(goodTrackData(ii).cor_peak*[1 1],get(ax,'YLim'),'Color','r','LineWidth',2)

%line(get(ax,'XLim'), 0.5*goodTrackData(ii).max_ref*[1 1],'Color','b','LineWidth',2)
%line(get(ax,'XLim'), 0.5*goodTrackData(ii).max_cor*[1 1],'Color','r','LineWidth',2)

%line(get(ax,'XLim'), goodTrackData(ii).mean_ref*[1 1],'Color','b','LineWidth',2)
%line(get(ax,'XLim'), goodTrackData(ii).mean_cor*[1 1],'Color','r','LineWidth',2)

end