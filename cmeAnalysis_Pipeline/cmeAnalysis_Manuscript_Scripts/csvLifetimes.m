%% Exports lifetime data to a csv
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


function csvLifetimes(filename, datafile)

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
    
    % writes lifetime data to csv
    dlmwrite(fullfile(path,filename), data.lifetime_associated)

end