[sortedMedians,I] = sort(-MedRelArrival);
sortedNames = Names(I,:);
sortedCell = cellstr(sortedNames);
figure
h = boxplot(MaxGFP,G,'Symbol','','GroupOrder',sortedCell,'Widths',0.5);
set(h,{'linew'},{6})

ax = gca;
ax.FontSize = 32;
ax.XTickLabelRotation = 45;
ax.XLabel.String = 'Protein of Interest';
ax.YLabel.String = 'Max Fluorescence Intensity (a.u.)';
ax.LineWidth = 4;