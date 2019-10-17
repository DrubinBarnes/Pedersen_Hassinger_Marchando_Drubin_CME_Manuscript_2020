clear
fileList = dir('goodTrackData*.mat');

linFitStruct = struct('name', {}, 'n_obs', {}, ...
    'gfp_l_gfp_f', {}, 'gfp_l_rfp_l', {}, 'gfp_l_rfp_f', {}, ...
    'coeffs_gfp_l_gfp_f', {}, 'coeffs_gfp_l_rfp_l', {}, 'coeffs_gfp_l_rfp_f', {}, ...
    'r2_gfp_l_gfp_f', {}, 'r2_gfp_l_rfp_l', {}, 'r2_gfp_l_rfp_f', {}, ...
    'gof_gfp_l_gfp_f', {}, 'gof_gfp_l_rfp_l', {}, 'gof_gfp_l_rfp_f', {}, ...
    'MedTime2rfpPeak', {}, 'MedRelArrival', {}););

for ii = 1:length(fileList)
    
   load(fileList(ii).name);
   nStart = find(fileList(ii).name == '_')+1;
   nEnd = find(fileList(ii).name == '.')-1;
   name = fileList(ii).name(nStart:nEnd)
   linFitStruct(ii).name = name;
   
   find_outliers
   
   linFitStruct(ii).n_obs = sum(~TF_gfp_rfp);
   
   [linFitStruct(ii).gfp_l_gfp_f, linFitStruct(ii).gof_gfp_l_gfp_f] = ...
       fit(lifetime_associated(~TF_gfp_rfp,1), maxGFP(~TF_gfp_rfp)','poly1');
   
   [linFitStruct(ii).gfp_l_rfp_l, linFitStruct(ii).gof_gfp_l_rfp_l] = ...
       fit(lifetime_associated(~TF_gfp_rfp,1), lifetime_associated(~TF_gfp_rfp,2),'poly1');
   
   [linFitStruct(ii).gfp_l_rfp_f, linFitStruct(ii).gof_gfp_l_rfp_f] = ...
       fit(lifetime_associated(~TF_gfp_rfp,1), maxRFP(~TF_gfp_rfp)','poly1');
   
   linFitStruct(ii).coeffs_gfp_l_gfp_f = coeffvalues(linFitStruct(ii).gfp_l_gfp_f);
   linFitStruct(ii).coeffs_gfp_l_rfp_l = coeffvalues(linFitStruct(ii).gfp_l_rfp_l);
   linFitStruct(ii).coeffs_gfp_l_rfp_f = coeffvalues(linFitStruct(ii).gfp_l_rfp_f);
   
   linFitStruct(ii).r2_gfp_l_gfp_f = linFitStruct(ii).gof_gfp_l_gfp_f.rsquare;
   linFitStruct(ii).r2_gfp_l_rfp_l = linFitStruct(ii).gof_gfp_l_rfp_l.rsquare;
   linFitStruct(ii).r2_gfp_l_rfp_f = linFitStruct(ii).gof_gfp_l_rfp_f.rsquare;
   
   linFitStruct(ii).MedTime2rfpPeak = median(time2rfpPeak(~TF_gfp_rfp));
   linFitStruct(ii).MedRelArrival = median(relArrival(~TF_gfp_rfp));
    
end