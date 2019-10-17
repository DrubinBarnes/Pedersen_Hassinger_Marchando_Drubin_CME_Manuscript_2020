% by Joh Schöneberg 2018


% let the user select the processedTracks.mat file
param_processedTracks_path = ''
if isequal(param_processedTracks_path,'')
    [file,path] = uigetfile('*.mat');
    if isequal(file,0)
        disp('User selected Cancel');
    else
        disp(['User selected ', fullfile(path,file)]);
    end
end

param_processedTracks_path = fullfile(path,file);

%-------------------------------------------------------
% load the file into memory

    if exist(param_processedTracks_path, 'file')==2
        processedTracks = load(param_processedTracks_path);
    else
        fprintf(['file not found.\n']);
        return;
    end

    
    %----
    % write csv file
    %----
    
    
    csvPath = [path 'processedTracks.csv'];
    disp(csvPath);
    fid= fopen(csvPath,'w');
    fprintf(fid,'trackId,length,t,f,x,y,A,c\n');
    %, c,A,x_pstd, y_pstd, A_pstd, c_pstd, SE_sigma_r, pval_Ar, isPSF\n');
    
    for i = 1:length(processedTracks.tracks)
        track = processedTracks.tracks(i);
        trackLength = length(track.t);
        %disp(trackLength)
         t = track.t;
            f = track.f;
            x = track.x;
            y = track.y;
            A = track.A;
            c = track.c;
            x_pstd = track.x_pstd;
            y_pstd = track.y_pstd;
            A_pstd = track.A_pstd;
            c_pstd = track.c_pstd;
            sigma_r = track.sigma_r;
            SE_sigma_r = track.SE_sigma_r;
            pval_Ar = track.pval_Ar;
            isPSF = track.isPSF;
        for j = 1:trackLength
           
            
            fprintf(fid,'%i,%i, %d, %d, %d, %d, %d, %d\n',...%, %d, %d, %d, %d, %d \n',...
                        i,trackLength, t(j), f(j), x(j), y(j), A(j), c(j));%, ...
                        %x_pstd(j), y_pstd(j), A_pstd(j), c_pstd(j),...
                        %SE_sigma_r(j), pval_Ar(j), isPSF(j));
                        
        end
      
    end
    fclose(fid);
         
disp('done.')        
