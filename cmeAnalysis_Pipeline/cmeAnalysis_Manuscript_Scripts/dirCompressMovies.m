fileList = dir('Fast0*.nd2');

tic

if ~isempty(fileList)
    mkdir Fast
end

for ii = 1:length(fileList)

    imData = bfopen(fileList(ii).name);
    imStack = imData2mat(imData,1);
    imStack = cell2mat(imStack);
    Frames(1, ii) = size(imStack,3);
    [compressedMovie] = compressMovie(imStack, 30);
    writeTiffs(compressedMovie, strcat(fileList(ii).name(1:end-4),'_compressed'));
    movefile(strcat(fileList(ii).name(1:end-4),'_compressed.tif'),'Fast')
    clear imData imStack compressedMovie
    
end
toc