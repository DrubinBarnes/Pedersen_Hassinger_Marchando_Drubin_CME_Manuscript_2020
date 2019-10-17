function plotRG_all(goodTrackData, name)

m = 5;
n = 6;

numFigs = ceil(length(goodTrackData)/(m*n));

for ii = 1:numFigs
    
    f = figure;
    
    for jj = 1:(m*n)
        
        trackNum = (ii-1)*m*n + jj;
    
        trackStart = goodTrackData(trackNum).tp_prev_all;
        trackEnd = goodTrackData(trackNum).tp_post_all;
        [gfpInt] = goodTrackData(trackNum).ref_intensity_bg_corrected;
        [rfpInt] = goodTrackData(trackNum).cor_intensity_bg_corrected;
    
        subplot(m,n,jj)
        hold on
        plot(trackStart:trackEnd,(gfpInt-min(gfpInt))/(max(gfpInt)-min(gfpInt)),'g','LineWidth',2)
        plot(trackStart:trackEnd,(rfpInt-min(rfpInt))/(max(rfpInt)-min(rfpInt)),'r','LineWidth',2)
        title(num2str(trackNum))
        ax = gca;
        ax.LineWidth = 2;
        ax.Box = 'on';
        ax.FontSize = 12;
        ax.YLim = [0 1];
        ax.XLim = [trackStart trackEnd];
        
        if (ii-1)*m*n + jj >= length(goodTrackData)
            break
        end
        
    end
    
    orient('landscape')
    print([name '-' num2str((ii-1)*m*n + 1) '-' num2str(ii*m*n)],'-dpdf','-fillpage')
    close(f)
    
end