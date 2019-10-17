%% Saves a vector PDF of the current figure
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
%% Input
%   filname - string of filename (in the form 'filename.pdf')

function printPDF(filename)

h = gcf;

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,filename,'-painters','-dpdf','-r0')

end