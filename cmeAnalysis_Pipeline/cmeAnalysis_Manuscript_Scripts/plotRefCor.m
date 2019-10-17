%% Plots fluorescence intensity over time
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

% Inputs:
%   goodTrackData - data structure from extractGoodTrackData.m, preferably
%       after using filter_tracks.m
%   trackNum - which track number to plot
%   window - frames to smooth over (1 is no smoothing)
%   spf - seconds per frame
%   ref_cor - flag to swap colors of ref and cor traces

% Outputs:
%   trackStart - starting frame of traces
%   trackEnd - ending frame of traces
%   refInt - vector of intensity values for the reference 
%   corInt - vector of intensity values for the correlated 

function [trackStart, trackEnd, refInt, corInt] = plotRefCor(goodTrackData, trackNum, window, spf, ref_cor)

% pull out the outputs from the data structure
trackStart = goodTrackData(trackNum).tp_prev_all;
trackEnd = goodTrackData(trackNum).tp_post_all;
[refInt] = goodTrackData(trackNum).ref_intensity_bg_corrected;
[corInt] = goodTrackData(trackNum).cor_intensity_bg_corrected;

figure
hold on

% plots ref in green, cor in magenta
if ~exist('ref_cor') || ref_cor == 0
    
    % plots intensity over time
    plot(spf*(trackStart:trackEnd),refInt,'g','LineWidth',6)
    plot(spf*(trackStart:trackEnd),corInt,'m','LineWidth',6)
    
    % plots smoothed traces
    %plot(spf*(trackStart:trackEnd),smooth(refInt,window),'b--','LineWidth',4)
    %plot(spf*(trackStart:trackEnd),smooth(corInt,window),'r--','LineWidth',4)

% plots ref in magenta, cor in green
else
    
    % plots intensity over time
    plot(spf*(trackStart:trackEnd),refInt,'m','LineWidth',4)
    plot(spf*(trackStart:trackEnd),corInt,'g','LineWidth',4)
    
    % plots smoothed traces
    plot(spf*(trackStart:trackEnd),smooth(refInt,window),'r--','LineWidth',4)
    plot(spf*(trackStart:trackEnd),smooth(corInt,window),'b--','LineWidth',4)

end

% plot settings
ax = gca;
ax.XLabel.String = 'Time (sec)';
ax.YLabel.String = 'Fluor. Intensity (a.u.)';
ax.LineWidth = 4;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
maxInt = max(max(refInt), max(corInt));
minInt = min(min(refInt), min(corInt));
ax.YLim = [min(minInt)-(100-mod(min(minInt),100)) max(maxInt)+(100-mod(max(maxInt),100))];
ax.Box = 'on';
ax.FontSize = 52;

% draws vertical lines at starts and ends of the ref and cor traces as
% identified by cmeAnalysis
line(goodTrackData(trackNum).ref_tp_first*[1 1],get(ax,'YLim'),'Color','g','LineStyle','--','LineWidth',4)
line(goodTrackData(trackNum).ref_tp_last*[1 1],get(ax,'YLim'),'Color','g','LineStyle',':','LineWidth',4)
line(goodTrackData(trackNum).cor_tp_first*[1 1],get(ax,'YLim'),'Color','m','LineStyle','--','LineWidth',4)
line(goodTrackData(trackNum).cor_tp_last*[1 1],get(ax,'YLim'),'Color','m','LineStyle',':','LineWidth',4)

% draws vertical lines at the peak intensities of the ref and cor
%line(goodTrackData(trackNum).ref_peak*[1 1],get(ax,'YLim'),'Color','b','LineStyle',':','LineWidth',4)
%line(goodTrackData(trackNum).cor_peak*[1 1],get(ax,'YLim'),'Color','r','LineStyle',':','LineWidth',4)

% draws horizontal lines at the half max of the ref and cor
%line(get(ax,'XLim'), 0.5*goodTrackData(trackNum).max_ref*[1 1],'Color','b','LineStyle',':','LineWidth',4)
%line(get(ax,'XLim'), 0.5*goodTrackData(trackNum).max_cor*[1 1],'Color','r','LineStyle',':','LineWidth',4)

% draws horizontal lines at the means of the ref and cor
%line(get(ax,'XLim'), goodTrackData(trackNum).mean_ref*[1 1],'Color','b','LineStyle',':','LineWidth',4)
%line(get(ax,'XLim'), goodTrackData(trackNum).mean_cor*[1 1],'Color','r','LineStyle',':','LineWidth',4)

end