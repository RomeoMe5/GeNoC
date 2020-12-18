function [ bool ] = GA_SaveResult( dir2save, graphStruct, xFrame, xFrameGr )
%save result

%1 save the mat file
saveFile = [dir2save  '\grStruct.mat'];
save(saveFile, 'graphStruct');

%2save the txt file
saveFile = [dir2save  '\param.txt'];
fid = fopen(saveFile, 'w+');
fprintf(fid, 'D: %d\n', graphStruct.Diameter);
fprintf(fid, 'Ed: %d\n', graphStruct.EdgeCount);
fprintf(fid, 'St: %d\n', graphStruct.Power);
fprintf(fid, 'Lav: %d\n', graphStruct.MedDist);
fclose(fid);

%also save the matrix that represent the graph
xlsFile = [dir2save '\Matrix.xls'];
xlswrite(xlsFile, graphStruct.Matrix);

if isempty(xFrame.colormap)
   imwrite(xFrame.cdata, [dir2save '\evolution.bmp']);
else
   imwrite(xFrame.cdata, xFrame.colormap, [dir2save '\evolution.tif']);
end

if isempty(xFrameGr.colormap)
   imwrite(xFrameGr.cdata, [dir2save '\graph.bmp']);
else
   imwrite(xFrameGr.cdata, xFrameGr.colormap, [dir2save '\graph.tif']);
end

end

