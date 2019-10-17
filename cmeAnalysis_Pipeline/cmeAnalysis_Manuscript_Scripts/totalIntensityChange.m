totalIntRFP = zeros(1,length(goodTrackData));
totalIntGFP = zeros(1,length(goodTrackData));

for ii = 1:length(goodTrackData)
    totalIntRFP(ii) = sum(abs(diff(goodTrackData(ii).cor_intensity_bg_corrected)));
    totalIntGFP(ii) = sum(abs(diff(goodTrackData(ii).ref_intensity_bg_corrected)));
end