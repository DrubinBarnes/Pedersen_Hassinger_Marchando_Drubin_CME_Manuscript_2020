track_flag_asso = track_flag_list(track_flag_list(:,1)==1,:);
track_flag_asso = track_flag_asso(track_flag_asso(:,3)==1,:);

cleaned_tracks = zeros(4,size(track_flag_asso,1));

for ii = 1:size(track_flag_asso,1)
   
    track = track_flag_asso(ii,2);
    
    cleaned_tracks(:,ii) = [mean(ROI_track_ref(track).center_coord,1) ...
        max(associated_tracks(track).ref_intensity_bg_corrected(1,:)),...
        ROI_track_ref(track).ref_tp_last-ROI_track_ref(track).ref_tp_first];
    
end

figure(1)
hold on
scatter3(cleaned_tracks(1,:)',cleaned_tracks(2,:)',...
    zeros(size(cleaned_tracks(1,:)',1),1),75,cleaned_tracks(3,:)','filled');    
view(0,90);
c1 = colorbar;
c1.Label.String = 'Fluorescence Intensity (a.u.)';
daspect([1 1 1]);
ax1 = gca;
ax1.XLabel.String = 'X Position';
ax1.YLabel.String = 'Y Position';
ax1.LineWidth = 2;
ax1.Box = 'on';
ax1.FontSize = 24;

figure(2)
hold on
scatter3(cleaned_tracks(1,:)',cleaned_tracks(2,:)',...
    zeros(size(cleaned_tracks(1,:)',1),1),75,cleaned_tracks(4,:)','filled');    
view(0,90);
c2 = colorbar;
c2.Label.String = 'Lifetime (sec)';
daspect([1 1 1]);
ax2 = gca;
ax2.XLabel.String = 'X Position (nm)';
ax2.YLabel.String = 'Y Position (nm)';
ax2.LineWidth = 2;
ax2.Box = 'on';
ax2.FontSize = 24;