clear; clc; close all;

path = 'D:\subjects\pdi\pcarps';

classnumber = 3;
imagetoload = 700;

cd(path);

for i = 1 : 3
    foldername = strcat(path, '\rockpaperscissors\o', int2str(i));
    for k = 1 : imagetoload
        filename = strcat(foldername, '\i', int2str(k), '.png');
        
        tmp = imread(filename);
        
        if(ndims(tmp) == 3)
            tmp = rgb2gray(imread(filename));
        end
        
        imwrite(tmp, filename);
    end
end

clear all; close all;