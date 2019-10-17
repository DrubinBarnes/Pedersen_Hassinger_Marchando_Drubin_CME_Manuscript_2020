function [trackStart, trackEnd, refInt, corInt] = plotRefCor_old(goodTrackData, trackNum, window, spf, ref_cor)
trackStart = goodTrackData(trackNum).tp_prev_all;
trackEnd = goodTrackData(trackNum).tp_post_all;
[refInt] = goodTrackData(trackNum).ref_intensity_bg_corrected;
[corInt] = goodTrackData(trackNum).cor_intensity_bg_corrected;
figure
hold on

if isempty(ref_cor) || ref_cor == 0
    
    plot(spf*(trackStart:trackEnd),refInt,'g','LineWidth',4)
    plot(spf*(trackStart:trackEnd),corInt,'m','LineWidth',4)
    plot(spf*(trackStart:trackEnd),smooth(refInt,window),'b','LineWidth',4)
    plot(spf*(trackStart:trackEnd),smooth(corInt,window),'r','LineWidth',4)

else
    
    plot(spf*(trackStart:trackEnd),refInt,'m','LineWidth',4)
    plot(spf*(trackStart:trackEnd),corInt,'g','LineWidth',4)
    plot(spf*(trackStart:trackEnd),smooth(refInt,window),'r','LineWidth',4)
    plot(spf*(trackStart:trackEnd),smooth(corInt,window),'b','LineWidth',4)

end


ax = gca;
ax.XLabel.String = 'Time (sec)';
ax.YLabel.String = 'Intensity (a.u.)';
ax.LineWidth = 2;
ax.Box = 'on';
ax.FontSize = 24;

end