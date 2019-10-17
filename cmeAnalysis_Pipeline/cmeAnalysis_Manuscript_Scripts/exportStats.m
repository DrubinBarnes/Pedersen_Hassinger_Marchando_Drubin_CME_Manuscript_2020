function goodTrackData = exportStats(goodTrackData, filename)

    
    % adds .csv to the filename if not specified by user
    if ~contains(filename, '.csv')
       
        filename = [filename '.csv'];
        
    end
    
    % remove fields with more than one value
    fieldNames = fields(goodTrackData);
    for ii = 1:length(fieldNames)
            
        if length(goodTrackData(1).(fieldNames{ii})) > 1
            
           goodTrackData = rmfield(goodTrackData, fieldNames{ii});

        end 
        
    end
    
    
    % writes data to csv
    struct2csv(goodTrackData, filename)

end