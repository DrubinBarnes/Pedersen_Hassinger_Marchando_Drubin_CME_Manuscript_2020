%% Makes timeline boxplot, sorted by time to RFP peak
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
% Run after extractBoxplotData.m
% Change the xlabel string

[sortedMedians,I] = sort(MedTime2rfpPeak);
sortedNames = Names(I,:);
sortedCell = cellstr(sortedNames);
figure
h = boxplot(-Time2rfpPeak,G,'Symbol','','GroupOrder',sortedCell,'Widths',0.5, ...
    'Orientation','Horizontal');
set(h,{'linew'},{6})

ax = gca;
ax.FontSize = 32;
ax.XTickLabelRotation = 45;
ax.XLabel.String = 'Time to Abp1-RFP Peak (sec)';
ax.YLabel.String = 'Protein of Interest';
ax.LineWidth = 4;
ax.XTick = [-150:10:0];