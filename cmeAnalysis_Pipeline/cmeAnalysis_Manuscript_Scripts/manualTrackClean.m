function manualTrackClean(goodTrackData, name)

trackAnnotation = zeros(length(goodTrackData),1);

for ii = 1:length(goodTrackData)
    
    f = figure;
   
    trackStart = goodTrackData(ii).tp_prev_all;
    trackEnd = goodTrackData(ii).tp_post_all;
    [gfpInt] = goodTrackData(ii).ref_intensity_bg_corrected;
    [rfpInt] = goodTrackData(ii).cor_intensity_bg_corrected;
    hold off
    plot(trackStart:trackEnd,gfpInt,'g','LineWidth',4)
    hold on
    plot(trackStart:trackEnd,rfpInt,'r','LineWidth',4)
    plot(trackStart:trackEnd,smooth(gfpInt),'b','LineWidth',4)
    plot(trackStart:trackEnd,smooth(rfpInt),'m','LineWidth',4)
    ax = gca;
    ax.XLabel.String = 'Time (sec)';
    ax.YLabel.String = 'Intensity (a.u.)';
    ax.LineWidth = 2;
    ax.Box = 'on';
    ax.FontSize = 24;
    title(num2str(ii))
    
    trackAnnotation(ii) = input('Good track? 1) Yes, 0) No: ');
    
    close(f)
    
end

save([name '.mat'], 'trackAnnotation')

end