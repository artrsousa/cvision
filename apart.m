clear; clc; close all;

originalpath = pwd();
pathdestiny = strcat(originalpath, '\dataBase\orl_facesPDI');
path = strcat(originalpath, '\dataBase\orl_faces');
classname = '\s';

classnumber = 40;
imagetoload = 10;

cd(path);

for i = 1 : classnumber
    foldername = strcat(path,classname,int2str(i));
    foldernamedestiny = strcat(pathdestiny,classname,int2str(i));
    for k = 1 : imagetoload
        filename = strcat(foldername, '\', int2str(k), '.pgm');
        filedestiny = strcat(foldernamedestiny, '\', int2str(k), '.pgm');
        
        tmp = imread(filename);
        tmp = imnoise(tmp, 'gaussian');
       
        imwrite(tmp, filedestiny);
    end
end

chdir(originalpath);
clear all; close all;
