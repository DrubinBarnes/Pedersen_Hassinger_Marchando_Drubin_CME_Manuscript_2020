%% Performs all of the linear fits for plotting
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

clear
fileList = dir('goodTrackData*.mat');

% makes data structure to hold fit statistics
linFitStruct = struct('name', {}, 'n_obs', {}, ...
    'gfp_l_gfp_f', {}, 'gfp_l_rfp_l', {}, 'gfp_l_rfp_f', {}, ...
    'coeffs_gfp_l_gfp_f', {}, 'coeffs_gfp_l_rfp_l', {}, 'coeffs_gfp_l_rfp_f', {}, ...
    'r2_gfp_l_gfp_f', {}, 'r2_gfp_l_rfp_l', {}, 'r2_gfp_l_rfp_f', {}, ...
    'gof_gfp_l_gfp_f', {}, 'gof_gfp_l_rfp_l', {}, 'gof_gfp_l_rfp_f', {}, ...
    'MedTime2rfpPeak', {}, 'MedRelArrival', {});

% No smoothing, 1 second time intervals
window = 1;
spf = 1;

for ii = 1:length(fileList)
    
   load(fileList(ii).name);
   nStart = find(fileList(ii).name == '_')+1;
   nEnd = find(fileList(ii).name == '.')-1;
   name = fileList(ii).name(nStart:nEnd)
   linFitStruct(ii).name = name;
   
   % calculate track data
   goodTrackData = calculateTwoColorStatsSmoothed(goodTrackData, window, spf);
   
   % filter the tracks
   [TF_ref_cor, goodTrackData] = filter_tracks(goodTrackData);
   goodTracks = goodTrackData(~TF_ref_cor);
   
   % pull out data to fit
   maxRFP = [goodTracks.max_cor]';
   maxGFP = [goodTracks.max_ref]';
   gfpLifetime = [goodTracks.ref_lifetime]';
   rfpLifetime = [goodTracks.cor_lifetime]'; 
   relArrival = [goodTracks.rel_arrival];
   time2rfpPeak = [goodTracks.ref_time_2_cor_peak];
   
   linFitStruct(ii).n_obs = sum(~TF_ref_cor);
   
   % GFP fluorescence vs. GFP lifetime
   [linFitStruct(ii).gfp_l_gfp_f, linFitStruct(ii).gof_gfp_l_gfp_f] = ...
       fit(gfpLifetime/median(gfpLifetime), ...
       maxGFP/median(maxGFP),'poly1');
   
   % RFP lifetime vs. GFP lifetime
   [linFitStruct(ii).gfp_l_rfp_l, linFitStruct(ii).gof_gfp_l_rfp_l] = ...
       fit(gfpLifetime/median(gfpLifetime), ...
       rfpLifetime/median(rfpLifetime),'poly1');
   
   % RFP fluorescence vs. GFP lifetime
   [linFitStruct(ii).gfp_l_rfp_f, linFitStruct(ii).gof_gfp_l_rfp_f] = ...
       fit(gfpLifetime/median(gfpLifetime), ...
       maxRFP/median(maxRFP),'poly1');
   
   % GFP fluorescence vs. RFP lifetime
   [linFitStruct(ii).gfp_f_rfp_l, linFitStruct(ii).gof_gfp_f_rfp_l] = ...
       fit(rfpLifetime/median(rfpLifetime), ...
       maxGFP/median(maxGFP),'poly1');
   
   % extract the coefficients of the fit
   linFitStruct(ii).coeffs_gfp_l_gfp_f = coeffvalues(linFitStruct(ii).gfp_l_gfp_f);
   linFitStruct(ii).coeffs_gfp_l_rfp_l = coeffvalues(linFitStruct(ii).gfp_l_rfp_l);
   linFitStruct(ii).coeffs_gfp_l_rfp_f = coeffvalues(linFitStruct(ii).gfp_l_rfp_f);
   linFitStruct(ii).coeffs_gfp_f_rfp_l = coeffvalues(linFitStruct(ii).gfp_f_rfp_l);
   
   % extract the R^2 of the fit
   linFitStruct(ii).r2_gfp_l_gfp_f = linFitStruct(ii).gof_gfp_l_gfp_f.rsquare;
   linFitStruct(ii).r2_gfp_l_rfp_l = linFitStruct(ii).gof_gfp_l_rfp_l.rsquare;
   linFitStruct(ii).r2_gfp_l_rfp_f = linFitStruct(ii).gof_gfp_l_rfp_f.rsquare;
   linFitStruct(ii).r2_gfp_f_rfp_l = linFitStruct(ii).gof_gfp_f_rfp_l.rsquare;
   
   % Median timing data for order the bar graph
   linFitStruct(ii).MedTime2rfpPeak = median(time2rfpPeak);
   linFitStruct(ii).MedRelArrival = median(relArrival);
    
end