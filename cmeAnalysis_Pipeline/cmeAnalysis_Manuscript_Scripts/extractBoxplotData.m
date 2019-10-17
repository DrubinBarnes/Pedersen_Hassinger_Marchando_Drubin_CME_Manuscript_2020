%% Extract data in form to make boxplots
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

% Generate a list of files with data
fileList = dir('goodTrackData*.mat');

% Generate empty arrays for things to plot
MaxRFP = [];
MaxGFP = [];
GFPLifetime = [];
RFPLifetime = [];
RelArrival = [];
Time2rfpPeak = [];
G = [];
Names = [];
MedTime2rfpPeak = [];
MedRelArrival = [];
N = [];

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
   
   % calculate track data
   goodTrackData = calculateTwoColorStatsSmoothed(goodTrackData, window, spf);
   
   % filter the tracks
   [TF_ref_cor, goodTrackData] = filter_tracks(goodTrackData);
   
   % group the data by name
   for kk = 1:7-(nEnd-nStart)
       name = [name ' '];
   end
   Names = [Names; name];
   
   % pull out needed data from data structure
   maxRFP = [goodTrackData.max_cor];
   maxGFP = [goodTrackData.max_ref];
   gfpLifetime = [goodTrackData.ref_lifetime];
   rfpLifetime = [goodTrackData.cor_lifetime];
   relArrival = [goodTrackData.rel_arrival];
   time2rfpPeak = [goodTrackData.ref_time_2_cor_peak];
   
   % add data for each protein to vector for making boxplot
    MaxRFP = [MaxRFP maxRFP(~TF_ref_cor)];
    MaxGFP = [MaxGFP maxGFP(~TF_ref_cor)];
    GFPLifetime = [GFPLifetime gfpLifetime(~TF_ref_cor)];
    RFPLifetime = [RFPLifetime rfpLifetime(~TF_ref_cor)];
    RelArrival = [RelArrival relArrival(~TF_ref_cor)];
    Time2rfpPeak = [Time2rfpPeak time2rfpPeak(~TF_ref_cor)];
    MedTime2rfpPeak = [MedTime2rfpPeak; median(time2rfpPeak(~TF_ref_cor))];
    MedRelArrival = [MedRelArrival; median(relArrival(~TF_ref_cor))];
    N = [N sum(~TF_ref_cor)];
   
   
   for jj = 1:length(maxRFP(~TF_ref_cor))
        G = [G; name];
   end
    
end