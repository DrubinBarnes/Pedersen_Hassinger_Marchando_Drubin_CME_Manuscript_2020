function plotIntensityProfiles(ii, associated_tracks, ROI_track_ref)

figure
plot(ROI_track_ref(ii).tp_prev_all:ROI_track_ref(ii).tp_post_all, associated_tracks(ii).ref_intensity_bg_corrected(1,:))
hold on
plot(ROI_track_ref(ii).tp_prev_all:ROI_track_ref(ii).tp_post_all, associated_tracks(ii).cor_intensity_bg_corrected(1,:))

end