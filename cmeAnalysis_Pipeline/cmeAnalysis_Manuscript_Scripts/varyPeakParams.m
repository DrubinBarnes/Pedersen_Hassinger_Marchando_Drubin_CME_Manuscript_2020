function [sumDiff, falsePos, falseNeg, totalGood] = varyPeakParams(goodTrackData, TF_consensus, MinPeakProm, MinPeakWidth)

sumDiff = zeros(length(MinPeakWidth),length(MinPeakProm));
falsePos = zeros(length(MinPeakWidth),length(MinPeakProm));
falseNeg = zeros(length(MinPeakWidth),length(MinPeakProm));
totalGood = zeros(length(MinPeakWidth),length(MinPeakProm));

for ii = 1:length(MinPeakProm)
    
    for jj = 1:length(MinPeakWidth)
    
        [TF_peaks] = findIntPeaks(goodTrackData, MinPeakProm(ii), MinPeakWidth(jj));
        
        theDiff = TF_consensus-(~TF_peaks);
        totalGood(jj,ii) = sum(~TF_peaks);
        sumDiff(jj,ii) = sum(logical(abs(theDiff)));
        falsePos(jj,ii) = sum(theDiff(theDiff==1));
        falseNeg(jj,ii) = sum(theDiff(theDiff==-1));
        
        (ii-1)*length(MinPeakWidth)+jj
    
    end

end

