function z = lerImgs(train, path, ngroups, windows)
    z = [];
    for j = 1:ngroups
        filename = strcat(path, '\dataBase\orl_faces\s', int2str(j));
        
        if ~windows
            filename = strrep(filename, '\', '/');
        end
        
        cd(filename);
        
        for k = 1 : train
            imagename = strcat(filename, '\', int2str(k),'.pgm'); 
           
            if ~windows
                imagename = strrep(imagename, '\', '/');
            end
            
            x = imread(imagename);
            y = reshape(x,[size(x,1)*size(x,2),1]);
            z = [z , y];
        end
    end
    return;
end