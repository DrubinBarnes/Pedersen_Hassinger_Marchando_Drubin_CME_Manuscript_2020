
fileList = dir('Slow0*.nd2');

tic

mkdir Slow

for ii = 1:length(fileList)

    imData = bfopen(fileList(ii).name);
    imStack = imData2mat(imData,2);
    imStackGFP = cell2mat(imStack(1));
    imStackRFP = cell2mat(imStack(2));
    
    writeTiffs(imStackGFP, strcat(fileList(ii).name(1:end-4),'-GFP'));
    writeTiffs(imStackRFP, strcat(fileList(ii).name(1:end-4),'-RFP'));
    movefile(strcat(fileList(ii).name(1:end-4),'-GFP.tif'),'Slow')
    movefile(strcat(fileList(ii).name(1:end-4),'-RFP.tif'),'Slow')
    clear imData imStack imStackGFP imStackRFP
    
end
toc