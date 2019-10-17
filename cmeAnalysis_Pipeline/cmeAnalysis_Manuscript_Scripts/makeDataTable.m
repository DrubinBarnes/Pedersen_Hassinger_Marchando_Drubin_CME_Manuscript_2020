%% Makes a summary table for all presented data
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

% Generate a list of files with data
fileList = dir('goodTrackData*.mat');


dataStruct = struct('name', {}, 'n_obs', {}, ...
    'med_time2arrival', {}, 'mean_time2arrival', {}, 'std_time2arrival', {}, ...
    'med_lifetime_gfp', {}, 'mean_lifetime_gfp', {}, 'std_lifetime_gfp', {}, ...
    'med_max_gfp', {}, 'mean_max_gfp', {}, 'std_max_gfp', {}, ...
    'med_lifetime_rfp', {}, 'mean_lifetime_rfp', {}, 'std_lifetime_rfp', {}, ...
    'med_max_rfp', {}, 'mean_max_rfp', {}, 'std_max_rfp', {}, ...
    'slope_gfp_l_gfp_f', {}, 'slopeL_gfp_l_gfp_f', {}, 'slopeU_gfp_l_gfp_f', {}, ...
    'r2_gfp_l_gfp_f', {}, 'r2L_gfp_l_gfp_f', {}, 'r2U_gfp_l_gfp_f', {}, ...
    'slope_gfp_l_rfp_l', {}, 'slopeL_gfp_l_rfp_l', {}, 'slopeU_gfp_l_rfp_l', {}, ...
    'r2_gfp_l_rfp_l', {}, 'r2L_gfp_l_rfp_l', {}, 'r2U_gfp_l_rfp_l', {}, ...
    'slope_gfp_l_rfp_f', {}, 'slopeL_gfp_l_rfp_f', {}, 'slopeU_gfp_l_rfp_f', {}, ...
    'r2_gfp_l_rfp_f', {}, 'r2L_gfp_l_rfp_f', {}, 'r2U_gfp_l_rfp_f', {});

% No smoothing, 1 second time intervals
window = 1;
spf = 1;

% Loop over all the identified data files
for ii = 1:length(fileList)
    
   % Extracting the name of the POI from the filename 
   load(fileList(ii).name);
   nStart = find(fileList(ii).name == '_')+1;
   nEnd = find(fileList(ii).name == '.')-1;
   name = fileList(ii).name(nStart:nEnd)
   
   dataStruct(ii).name = name;
   
   % calculate track data
   goodTrackData = calculateTwoColorStatsSmoothed(goodTrackData, window, spf);
   
   % filter the tracks
   [TF_ref_cor, goodTrackData] = filter_tracks(goodTrackData);
   goodTracks = goodTrackData(~TF_ref_cor);
   
   maxRFP = [goodTracks.max_cor]';
   maxGFP = [goodTracks.max_ref]';
   gfpLifetime = [goodTracks.ref_lifetime]';
   rfpLifetime = [goodTracks.cor_lifetime]'; 
   relArrival = [goodTracks.rel_arrival];
   
   % relative arrival
   dataStruct(ii).med_time2arrival = median(relArrival);
   dataStruct(ii).mean_time2arrival = mean(relArrival);
   dataStruct(ii).std_time2arrival = std(relArrival);
   
   % GFP lifetime
   dataStruct(ii).med_lifetime_gfp = median(gfpLifetime);
   dataStruct(ii).mean_lifetime_gfp = mean(gfpLifetime);
   dataStruct(ii).std_lifetime_gfp = std(gfpLifetime);
   
   % RFP lifetime
   dataStruct(ii).med_lifetime_rfp = median(rfpLifetime);
   dataStruct(ii).mean_lifetime_rfp = mean(rfpLifetime);
   dataStruct(ii).std_lifetime_rfp = std(rfpLifetime);
   
   % GFP max intensity
   dataStruct(ii).med_max_gfp = median(maxGFP);
   dataStruct(ii).mean_max_gfp = mean(maxGFP);
   dataStruct(ii).std_max_gfp = std(maxGFP);
   
   % RFP max intensity
   dataStruct(ii).med_max_rfp = median(maxRFP);
   dataStruct(ii).mean_max_rfp = mean(maxRFP);
   dataStruct(ii).std_max_rfp = std(maxRFP);
   
   % number of observations
   dataStruct(ii).n_obs = sum(~TF_ref_cor);
   
   % GFP fluorescence vs. lifetime fit stats
   [gfp_l_gfp_f] = fit(gfpLifetime/median(gfpLifetime), ...
       maxGFP/median(maxGFP),'poly1');
   coeffVal = coeffvalues(gfp_l_gfp_f);
   confInt = confint(gfp_l_gfp_f);
   dataStruct(ii).slope_gfp_l_gfp_f = coeffVal(1);
   dataStruct(ii).slopeL_gfp_l_gfp_f = confInt(1,1);
   dataStruct(ii).slopeU_gfp_l_gfp_f = confInt(2,1);
   
   % RFP lifetime vs. GFP lifetime fit stats
   [gfp_l_rfp_l] = fit(gfpLifetime/median(gfpLifetime), ...
       rfpLifetime/median(rfpLifetime),'poly1');
   coeffVal = coeffvalues(gfp_l_rfp_l);
   confInt = confint(gfp_l_rfp_l);
   dataStruct(ii).slope_gfp_l_rfp_l = coeffVal(1);
   dataStruct(ii).slopeL_gfp_l_rfp_l = confInt(1,1);
   dataStruct(ii).slopeU_gfp_l_rfp_l = confInt(2,1);
   
   % RFP fluorescence vs. GFP lifetime fit stats
   [gfp_l_rfp_f] = fit(gfpLifetime/median(gfpLifetime), ...
       maxRFP/median(maxRFP),'poly1');
   coeffVal = coeffvalues(gfp_l_rfp_f);
   confInt = confint(gfp_l_rfp_f);
   dataStruct(ii).slope_gfp_l_rfp_f = coeffVal(1);
   dataStruct(ii).slopeL_gfp_l_rfp_f = confInt(1,1);
   dataStruct(ii).slopeU_gfp_l_rfp_f = confInt(2,1);
   
   % R^2 max GFP intensity vs. GFP lifetime
   [R,~,RL,RU] = corrcoef(gfpLifetime/median(gfpLifetime), maxGFP/median(maxGFP));
   dataStruct(ii).r2_gfp_l_gfp_f = R(1,2)^2;
   dataStruct(ii).r2L_gfp_l_gfp_f = RL(1,2)^2;
   dataStruct(ii).r2U_gfp_l_gfp_f = RU(1,2)^2;
   
   % R^2 RFP lifetime vs. GFP lifetime
   [R,~,RL,RU] = corrcoef(gfpLifetime/median(gfpLifetime),rfpLifetime/median(rfpLifetime));
   dataStruct(ii).r2_gfp_l_rfp_l = R(1,2)^2;
   dataStruct(ii).r2L_gfp_l_rfp_l = RL(1,2)^2;
   dataStruct(ii).r2U_gfp_l_rfp_l = RU(1,2)^2;
   
   % R^2 max RFP intensity vs. GFP lifetime
   [R,~,RL,RU] = corrcoef(gfpLifetime/median(gfpLifetime), maxRFP/median(maxRFP));
   dataStruct(ii).r2_gfp_l_rfp_f = R(1,2)^2;
   dataStruct(ii).r2L_gfp_l_rfp_f = RL(1,2)^2;
   dataStruct(ii).r2U_gfp_l_rfp_f = RU(1,2)^2;
   
   
   %{
[dataStruct(ii).gfp_f_rfp_l, dataStruct(ii).gof_gfp_f_rfp_l] = ...
       fit(rfpLifetime/median(rfpLifetime), ...
       maxGFP/median(maxGFP),'poly1');
   %}
    
end

T = struct2table(dataStruct);