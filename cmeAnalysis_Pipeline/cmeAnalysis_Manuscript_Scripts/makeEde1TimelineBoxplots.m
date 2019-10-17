%% Makes timeline boxplot, sorted by relative arrival
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

[sortedMedians,I] = sort(MedRelArrival);
sortedNames = Names(I,:);
sortedCell = cellstr(sortedNames);
figure
h = boxplot(-RelArrival,G,'Symbol','','GroupOrder',sortedCell,'Widths',0.5, ...
    'Orientation','Horizontal');
set(h,{'linew'},{6})

ax = gca;
ax.FontSize = 44;
ax.XTickLabelRotation = 45;
%ax.XLabel.String = 'Time to Sla1-RFP Arrival (sec)';
ax.XLabel.String = 'Time to Ede1-mCherry Arrival (sec)';
ax.YLabel.String = 'Protein of Interest';
ax.LineWidth = 4;
ax.XTick = [-150:10:100];