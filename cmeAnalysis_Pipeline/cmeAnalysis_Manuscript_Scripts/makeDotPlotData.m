% Analyze percent of max intensity when actin starts to assemble

%clc
%clear
%close all

name = input('Input the name of your protein: ', 's');
full_name = ['goodTrackData_' name '.mat'];
load(full_name);

num_tracks = length(goodTrackData);

working_dat = struct2cell(goodTrackData);

final_dat = zeros(num_tracks,1);

for i = 1:num_tracks
    
    actin_start_pos = working_dat{7,1,i};
    gfp_start_pos = working_dat{5,1,i};
    start_index = actin_start_pos - gfp_start_pos + 1;
    if start_index > 0
        gfp_track_inten = working_dat{1,1,i};
        final_dat(i) = (gfp_track_inten(start_index) - min(gfp_track_inten)) / (max(gfp_track_inten)-min(gfp_track_inten));
    else
        final_dat(i) = 0;
    end
    
end

final_dat = final_dat(final_dat~=0);
