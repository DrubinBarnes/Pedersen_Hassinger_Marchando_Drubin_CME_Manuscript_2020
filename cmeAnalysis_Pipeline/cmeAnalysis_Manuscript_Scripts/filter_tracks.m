%% Filters out bad traces
%
%   Julian Hassinger
%   Biophysics Graduate Group
%   David Drubin Lab
%   University of California, Berkeley
%
%   Copyright 2019
%
%   Last Edited: 8/5/2019
%
%% 

% Inputs:
%   goodTrackData - data structure from extractGoodTrackData.m

% Outputs:
%   TF_ref_cor - boolean vector (0 = good trace, 1 = bad trace)
%   goodTrackData - data structure with all traces
%   goodTracks - data structure of only good traces

function [TF_ref_cor, goodTrackData, goodTracks] = filter_tracks(goodTrackData)

% Calculate two color stats if not done already
if isfield(goodTrackData,'ref_lifetime') == 0
   spf = input('How many seconds per frame? ');
   window = input('How many frames to smooth over? ');
   goodTrackData = calculateTwoColorStatsSmoothed(goodTrackData, window, spf); 
end

% Looks for outliers in max intensity
TF_ref_int = isoutlier([goodTrackData.max_ref],'quartiles');
TF_cor_int = isoutlier([goodTrackData.max_cor],'quartiles');

% Looks for outliers in lifetimes
TF_ref_lt = isoutlier([goodTrackData.ref_lifetime],'quartiles');
TF_cor_lt = isoutlier([goodTrackData.cor_lifetime],'quartiles');

% Looks for outliers in relative arrival, disapperance, and time from 
% ref arrival to cor peak
TF_arrival = isoutlier([goodTrackData.rel_arrival],'quartiles');
TF_disp = isoutlier([goodTrackData.rel_end],'quartiles');
TF_time2corPeak = isoutlier([goodTrackData.ref_time_2_cor_peak],'quartiles');

% Filters traces within 5 frames of the beginning or end of the movie
TF_start = [goodTrackData.tp_prev_all] == 1;
TF_end = [goodTrackData.tp_post_all] == max([goodTrackData.tp_post_all]);

% Excludes tracks where traces go very negative
TF_ref_neg = [goodTrackData.min_ref]./[goodTrackData.max_ref] < -0.25;
TF_cor_neg = [goodTrackData.min_cor]./[goodTrackData.max_cor] < -0.25;

% Collates results
TF_ref_cor = TF_ref_lt | TF_cor_lt | TF_ref_int | TF_cor_int | ...
    TF_arrival | TF_disp | TF_time2corPeak | TF_start | TF_end | ...
    TF_ref_neg | TF_cor_neg;

% Applies filter to traces
goodTracks = goodTrackData(~TF_ref_cor);

end