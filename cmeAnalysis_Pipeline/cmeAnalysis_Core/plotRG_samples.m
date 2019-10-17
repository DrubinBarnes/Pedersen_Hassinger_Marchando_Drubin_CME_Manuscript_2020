function plotRG_samples(goodTrackData, numPlots)

samples = datasample(1:length(goodTrackData),numPlots);%,'Replace',false);
%samples = 1:length(goodTrackData);

figure

m = 4;
n = 5;

for ii = 1:numPlots
    
    jj = samples(ii);
    
    trackStart = goodTrackData(jj).tp_prev_all;
    trackEnd = goodTrackData(jj).tp_post_all;
    [gfpInt] = goodTrackData(jj).ref_intensity_bg_corrected;
    [rfpInt] = goodTrackData(jj).cor_intensity_bg_corrected;
    
    subplot(m,n,ii)
    hold on
    plot(trackStart:trackEnd,(gfpInt-min(gfpInt))/(max(gfpInt)-min(gfpInt)),'g','LineWidth',4)
    plot(trackStart:trackEnd,(rfpInt-min(rfpInt))/(max(rfpInt)-min(rfpInt)),'r','LineWidth',4)
    title(num2str(jj))
    %legend(num2str(jj),'Location','southeast')
    ax = gca;
    %ax.XLabel.String = 'Time (sec)';
    %ax.YLabel.String = 'Intensity (a.u.)';
    ax.LineWidth = 4;
    ax.Box = 'on';
    ax.FontSize = 24;
    ax.YLim = [0 1];
    ax.XLim = [trackStart trackEnd];
end