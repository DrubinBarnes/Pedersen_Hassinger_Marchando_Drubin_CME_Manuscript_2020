%% Makes summary bar plots of linear fit data
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
%% Requirements
% Run after linearFitsNormalized.m
% Change the title strings

% Pulls out the data into vectors for plotting
for ii = 1:length(linFitStruct)
   
    names(ii) = {linFitStruct(ii).name};
    n_obs(ii) = linFitStruct(ii).n_obs;
    
    r2_gfp_l_gfp_f(ii) = linFitStruct(ii).r2_gfp_l_gfp_f;
    r2_gfp_l_rfp_l(ii) = linFitStruct(ii).r2_gfp_l_rfp_l;
    r2_gfp_l_rfp_f(ii) = linFitStruct(ii).r2_gfp_l_rfp_f;
    
    slope_gfp_l_gfp_f(ii) = linFitStruct(ii).coeffs_gfp_l_gfp_f(1);
    slope_gfp_l_rfp_l(ii) = linFitStruct(ii).coeffs_gfp_l_rfp_l(1);
    slope_gfp_l_rfp_f(ii) = linFitStruct(ii).coeffs_gfp_l_rfp_f(1);
    
    MedTime2rfpPeak(ii) = linFitStruct(ii).MedTime2rfpPeak;
    MedRelArrival(ii) = linFitStruct(ii).MedRelArrival;
    
end

% Reorders the bars by relative arrival time or time to peak
for ii = 1:length(names)

    [~, I] = sort(-MedRelArrival);
    %[~, I] = sort(-MedTime2rfpPeak);
    sortedNames{ii} = names{I(ii)};
end

%% RFP lifetime vs. GFP lifetime
c2 = parula(100);

sorted_r2_gfp_l_rfp_l = r2_gfp_l_rfp_l(I);
R2 = round(sorted_r2_gfp_l_rfp_l*100);

figure
b2 = bar(slope_gfp_l_rfp_l(I), 'LineWidth', 4, 'FaceColor', 'flat');
for ii = 1:length(sorted_r2_gfp_l_rfp_l)
   b2.CData(ii,:) = c2(R2(ii)+1,:);
end
set(gca,'xticklabel',sortedNames);
ax2 = gca;
ax2.FontSize = 44;
ax2.XTickLabelRotation = 45;
ax2.XLabel.String = 'Protein of Interest';
ax2.YLabel.String = 'Slope (sec/sec) of linear fit';
ax2.Title.String = 'Ede1-mCherry Lifetime vs. POI-GFP Lifetime';
ax2.LineWidth = 4;
ax2.YLim = [-0.2 1];
ax2.YMinorTick = 'on';
cbar2 = colorbar;
cbar2.LineWidth = 4;
cbar2.Ticks = 0:0.1:1;
cbar2.Label.String = 'R^{2} of linear fit';


%% RFP fluorescence intensity vs. GFP lifetime
c4 = parula(20);
sorted_r2_gfp_l_rfp_f = r2_gfp_l_rfp_f(I);
R2 = round(sorted_r2_gfp_l_rfp_f*100);

figure
b4 = bar(slope_gfp_l_rfp_f(I), 'LineWidth', 4, 'FaceColor', 'flat');
for ii = 1:length(sorted_r2_gfp_l_rfp_f)
   b4.CData(ii,:) = c4(R2(ii)+1,:);
end
set(gca,'xticklabel',sortedNames);
ax4 = gca;
ax4.FontSize = 44;
ax4.XTickLabelRotation = 45;
ax4.XLabel.String = 'Protein of Interest';
ax4.YLabel.String = 'Slope (a.u./sec) of linear fit';
ax4.Title.String = 'Ede1-mCherry Fluorescence Intensity vs. POI-GFP Lifetime';
ax4.LineWidth = 4;
ax4.YLim = [-0.2 1.2];
ax4.YMinorTick = 'on';
cbar4 = colorbar;
cbar4.LineWidth = 4;
cbar4.Ticks = 0:0.1:1;
cbar4.TickLabels = 0:0.02:0.20;
cbar4.Label.String = 'R^{2} of linear fit';
%cbar4.Limits = [0 0.5];

%% GFP fluorescence intensity vs. lifetime
c1 = parula(50);
sorted_r2_gfp_l_gfp_f = r2_gfp_l_gfp_f(I);
R2 = round(sorted_r2_gfp_l_gfp_f*100);

figure
b1 = bar(slope_gfp_l_gfp_f(I), 'LineWidth', 4, 'FaceColor', 'flat');
for ii = 1:length(sorted_r2_gfp_l_gfp_f)
   b1.CData(ii,:) = c1(R2(ii)+1,:);
end
set(gca,'xticklabel',sortedNames);
ax1 = gca;
ax1.FontSize = 44;
ax1.XTickLabelRotation = 45;
ax1.XLabel.String = 'Protein of Interest';
ax1.YLabel.String = 'Slope (a.u./sec) of linear fit';
ax1.Title.String = 'POI-GFP Fluorescence Intensity vs. POI-GFP Lifetime';
ax1.LineWidth = 4;
ax1.YLim = [0 1.4];
ax1.YMinorTick = 'on';
cbar1 = colorbar;
cbar1.LineWidth = 4;
cbar1.Ticks = 0:0.1:1;
cbar1.TickLabels = 0:0.05:0.5;
cbar1.Label.String = 'R^{2} of linear fit';
%cbar1.Limits = [0 0.5];
