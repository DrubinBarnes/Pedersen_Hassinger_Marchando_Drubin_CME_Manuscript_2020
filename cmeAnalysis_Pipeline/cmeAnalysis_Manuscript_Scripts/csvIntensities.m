%% Exports fluorescence intensity data to csv
%
%   Julian Hassinger
%   Biophysics Graduate Group
%   David Drubin Lab
%   University of California, Berkeley
%
%   Copyright 2018
%
%   Last Edited: 10/31/2018
%
%%

% Inputs: 
%   filename - String the specifies name of output .csv file
%   datafile - String that specifies the data file (will save .csv 
%                   in current directory if given)


function csvIntensities(selection, filename, datafile)

    % checks for existence of datafile
    if ~exist('datafile', 'var')
        
        % prompts user to select a file
        [datafile,path] = uigetfile('*.mat',...
            'Select the Track Data file.');
        
        % opens data file
        data = open(fullfile(path,datafile));
        
    else
        
        % opens data file
        data = open(datafile);
        
        % sets current directory as path to save csv
        path = pwd;
    
    end
    
    
    % asks user for filename if it doesn't exist
    if ~exist('filename', 'var')
       
        filename = input('What do you want to call this file? ', 's');
        
    end
    
    % adds .csv to the filename if not specified by user
    if ~contains(filename, '.csv')
       
        filename = [filename '.csv'];
        
    end
    
    if ~exist('selection','var')
        
        selection = 0;
       
        while selection ~= 1 && selection ~= 2 && selection ~= 3
           
            selection = input(...
                'Do you want the 1)ref, 2)cor, or 3)both data? ');
            
        end
        
    end
    
    switch selection
        
        case 1
            
            for ii = 1:length(data.goodTrackData)
        
                dlmwrite(fullfile(path,filename), ...
                    data.goodTrackData(ii).ref_intensity_bg_corrected,...
                    '-append')
        
            end
            
        case 2
            
            for ii = 1:length(data.goodTrackData)
        
                dlmwrite(fullfile(path,filename), ...
                    data.goodTrackData(ii).cor_intensity_bg_corrected,...
                    '-append')
        
            end
            
        case 3
            
            for ii = 1:length(data.goodTrackData)
        
                dlmwrite(fullfile(path,filename), ...
                    data.goodTrackData(ii).ref_intensity_bg_corrected,...
                    '-append')
                
                dlmwrite(fullfile(path,filename), ...
                    data.goodTrackData(ii).cor_intensity_bg_corrected,...
                    '-append')
        
            end
        
        
    end


end