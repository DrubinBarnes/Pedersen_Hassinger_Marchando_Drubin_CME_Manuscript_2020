[maxRFP, maxGFP] = max_RFP_GFP(goodTrackData);
[rel_arrival, rel_end] = relativeArrival(goodTrackData);
[gfpLifetime, rfpLifetime, relArrival, time2rfpPeak] = lifetimeStats(goodTrackData);
minPeakProm = 0.58;
minPeakWidth = 5;

TF_gfp_int = isoutlier(maxGFP','quartiles');
TF_rfp_int = isoutlier(maxRFP','quartiles');

TF_gfp = isoutlier(lifetime_associated(:,1),'quartiles');
TF_rfp = isoutlier(lifetime_associated(:,2),'quartiles');

TF_arrival = isoutlier(rel_arrival,'quartiles');
TF_end = isoutlier(rel_end,'quartiles');
TF_time2rfpPeak = isoutlier(time2rfpPeak','quartiles');

%[TF_peaks] = findIntPeaks(goodTrackData, minPeakProm, minPeakWidth);


TF_gfp_rfp = TF_gfp | TF_rfp | TF_gfp_int | TF_rfp_int | ...
    TF_arrival | TF_end | TF_time2rfpPeak;% | sasaveTF_peaks;