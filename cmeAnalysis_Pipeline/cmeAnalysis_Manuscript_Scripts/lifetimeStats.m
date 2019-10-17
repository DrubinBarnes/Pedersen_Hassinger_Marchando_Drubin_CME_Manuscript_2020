function [gfpLifetime, rfpLifetime, relArrival, time2rfpPeak] = lifetimeStats(goodTrackData)

gfpLifetime = zeros(1,length(goodTrackData));
rfpLifetime = zeros(1,length(goodTrackData));
relArrival = zeros(1,length(goodTrackData));
time2rfpPeak = zeros(1,length(goodTrackData));

for ii = 1:length(goodTrackData)
    gfpLifetime(ii) = goodTrackData(ii).ref_tp_last - goodTrackData(ii).ref_tp_first + 1;
    rfpLifetime(ii) = goodTrackData(ii).cor_tp_last - goodTrackData(ii).cor_tp_first + 1;
    relArrival(ii) = goodTrackData(ii).cor_tp_first - goodTrackData(ii).ref_tp_first + 1;
    
    [~, jj] = max(smooth(goodTrackData(ii).cor_intensity_bg_corrected));
    
    time2rfpPeak(ii) = (goodTrackData(ii).tp_prev_all + jj) - goodTrackData(ii).ref_tp_first;
end