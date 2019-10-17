function [TF_peaks] = findIntPeaks(goodTrackData, minPeakProm, minPeakWidth)

rfpPeaks = zeros(1,length(goodTrackData));
gfpPeaks = zeros(1,length(goodTrackData));

for ii = 1:length(goodTrackData)
    
    trackStart = goodTrackData(ii).tp_prev_all;
    trackEnd = goodTrackData(ii).tp_post_all;
    [gfpInt] = goodTrackData(ii).ref_intensity_bg_corrected;
    [rfpInt] = goodTrackData(ii).cor_intensity_bg_corrected;
    
    [rfpPeak] = findpeaks((rfpInt-min(rfpInt))/(max(rfpInt)-min(rfpInt)),...
        trackStart:trackEnd,'MinPeakProminence',minPeakProm,'MinPeakWidth',minPeakWidth);
    [gfpPeak] = findpeaks((gfpInt-min(gfpInt))/(max(gfpInt)-min(gfpInt)),...
        trackStart:trackEnd,'MinPeakProminence',minPeakProm,'MinPeakWidth',minPeakWidth);
    
    rfpPeaks(ii) = length(rfpPeak);
    gfpPeaks(ii) = length(gfpPeak);
    
end

TF_peaks = (~(rfpPeaks == 1))'|(~(gfpPeaks == 1))';

end