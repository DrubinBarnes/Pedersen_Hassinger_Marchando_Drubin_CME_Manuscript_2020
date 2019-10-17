function [rel_arrival, rel_end] = relativeArrival(goodTrackData)

num_tracks = length(goodTrackData);

rel_arrival = zeros(num_tracks,1);
rel_end = zeros(num_tracks,1);

for ii = 1:num_tracks

    rfp_start_pos = goodTrackData(ii).cor_tp_first;
    gfp_start_pos = goodTrackData(ii).ref_tp_first;
    rel_arrival(ii) = rfp_start_pos - gfp_start_pos;
    
    rfp_end_pos = goodTrackData(ii).cor_tp_last;
    gfp_end_pos = goodTrackData(ii).ref_tp_last;
    rel_end(ii) = rfp_end_pos - gfp_end_pos;
    
end

end