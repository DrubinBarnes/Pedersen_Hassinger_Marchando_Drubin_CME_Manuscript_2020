function [trackStart, trackEnd, refInt, corInt] = plotRefCorNorm(goodTrackData, trackNum, window, spf, ref_cor)
trackStart = goodTrackData(trackNum).tp_prev_all;
trackEnd = goodTrackData(trackNum).tp_post_all;
[refInt] = goodTrackData(trackNum).ref_intensity_bg_corrected;
[corInt] = goodTrackData(trackNum).cor_intensity_bg_corrected;
figure
hold on

if isempty(ref_cor) || ref_cor == 0
    
    plot(spf*(trackStart:trackEnd),refInt/max(refInt),'g','LineWidth',4)
    plot(spf*(trackStart:trackEnd),corInt/max(corInt),'m','LineWidth',4)
    plot(spf*(trackStart:trackEnd),smooth(refInt,window)/max(refInt),'b','LineWidth',4)
    plot(spf*(trackStart:trackEnd),smooth(corInt,window)/max(corInt),'r','LineWidth',4)
    
    ax = gca;
    
    line(goodTrackData(trackNum).ref_peak*[1 1], get(ax,'YLim'), 'Color', 'b', 'LineWidth', 2)
    line(goodTrackData(trackNum).cor_peak*[1 1], get(ax,'YLim'), 'Color', 'r', 'LineWidth', 2)
    
    line(get(ax,'XLim'), goodTrackData(trackNum).max_ref*[1 1]/max(refInt), 'Color', 'b', 'LineWidth', 2)
    line(get(ax,'XLim'), goodTrackData(trackNum).max_cor*[1 1]/max(corInt), 'Color', 'r', 'LineWidth', 2)

else
    
    plot(spf*(trackStart:trackEnd),refInt/max(refInt),'m','LineWidth',4)
    plot(spf*(trackStart:trackEnd),corInt/max(corInt),'g','LineWidth',4)
    plot(spf*(trackStart:trackEnd),smooth(refInt,window)/max(refInt),'r','LineWidth',4)
    plot(spf*(trackStart:trackEnd),smooth(corInt,window)/max(corInt),'b','LineWidth',4)
    
    ax = gca;
    
    %line(goodTrackData(trackNum).ref_peak*[1 1], get(ax,'YLim'), 'Color', 'r', 'LineWidth', 2)
    %line(goodTrackData(trackNum).cor_peak*[1 1], get(ax,'YLim'), 'Color', 'b', 'LineWidth', 2)
    
    line(goodTrackData(trackNum).ref_tp_first*spf*[1 1], get(ax,'YLim'), 'Color', 'r', 'LineWidth', 2)
    line(goodTrackData(trackNum).cor_tp_first*spf*[1 1], get(ax,'YLim'), 'Color', 'b', 'LineWidth', 2)
    line(goodTrackData(trackNum).ref_tp_last*spf*[1 1], get(ax,'YLim'), 'Color', 'r', 'LineWidth', 2)
    line(goodTrackData(trackNum).cor_tp_last*spf*[1 1], get(ax,'YLim'), 'Color', 'b', 'LineWidth', 2)
    
    line(get(ax,'XLim'), goodTrackData(trackNum).max_ref*[1 1]/max(refInt), 'Color', 'r', 'LineWidth', 2)
    line(get(ax,'XLim'), goodTrackData(trackNum).max_cor*[1 1]/max(corInt), 'Color', 'b', 'LineWidth', 2)

end


ax.XLabel.String = 'Time (sec)';
ax.YLabel.String = 'Intensity (a.u.)';
ax.LineWidth = 2;
ax.Box = 'on';
ax.FontSize = 24;



end