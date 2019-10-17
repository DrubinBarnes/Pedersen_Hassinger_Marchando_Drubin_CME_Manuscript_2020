function [maxRFP, maxGFP] = max_RFP_GFP(goodTrackData)

maxRFP = zeros(1,length(goodTrackData));
maxGFP = zeros(1,length(goodTrackData));

for ii = 1:length(goodTrackData)
    maxRFP(ii) = max(goodTrackData(ii).cor_intensity_bg_corrected);
    maxGFP(ii) = max(goodTrackData(ii).ref_intensity_bg_corrected);
end