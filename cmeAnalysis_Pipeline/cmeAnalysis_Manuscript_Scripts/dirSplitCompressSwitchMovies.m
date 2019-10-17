fileList = dir('FastSwitch0*.nd2');

tic

mkdir FastSwitch

for ii = 1:length(fileList)

    imData = bfopen(fileList(ii).name);
    imStack = imData2mat(imData,2);
    imStackGFP = cell2mat(imStack(1));
    imStackRFP = cell2mat(imStack(2));
    
    omeMeta = imData{1,4};
    omeXML = char(omeMeta.dumpXML());

    dtIdx = strfind(omeXML,'DeltaT=');
    quoteIdx = strfind(omeXML,'"');

    DeltaT = zeros(1,length(dtIdx));

    for jj = 1:length(dtIdx)
   
        idx = quoteIdx(find(quoteIdx>dtIdx(jj),2));
        DeltaT(jj) = str2double(omeXML(idx(1)+1:idx(2)-1)); 
    
    end
    
    [imStackGFP] = compressMovie(imStackGFP(:,:,2:end), 15);
    [imStackRFP] = compressMovie(imStackRFP, 15);
    
    writeTiffs(imStackGFP, strcat(fileList(ii).name(1:end-4),'-GFP'));
    writeTiffs(imStackRFP, strcat(fileList(ii).name(1:end-4),'-RFP'));
    movefile(strcat(fileList(ii).name(1:end-4),'-GFP.tif'),'FastSwitch')
    movefile(strcat(fileList(ii).name(1:end-4),'-RFP.tif'),'FastSwitch')
    clear imData imStack imStackGFP imStackRFP
    
    save(strcat(fileList(ii).name(1:end-4),'.mat'), 'DeltaT')
    
end
toc