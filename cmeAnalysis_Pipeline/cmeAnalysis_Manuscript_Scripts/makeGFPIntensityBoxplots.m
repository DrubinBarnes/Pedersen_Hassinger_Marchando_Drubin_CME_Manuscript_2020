%% Makes boxplots of GFP intensities, sorted by relative arrival
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
% run after extractBoxplotData.m

%[sortedMedians,I] = sort(-MedTime2rfpPeak);
[sortedMedians,I] = sort(-MedRelArrival);
sortedNames = Names(I,:);
sortedCell = cellstr(sortedNames);
figure
h = boxplot(MaxGFP,G,'Symbol','','GroupOrder',sortedCell,'Widths',0.5);
set(h,{'linew'},{6})

ax = gca;
ax.FontSize = 44;
ax.XTickLabelRotation = 45;
ax.XLabel.String = 'Protein of Interest';
ax.YLabel.String = 'Max Fluorescence Intensity (a.u.)';
ax.LineWidth = 4;