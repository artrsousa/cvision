function z = lerImgs(train, path, ngroups, wn)
    z = [];
    for j = 1:ngroups
        filename = strcat(path, int2str(j));
        
        if ~wn
            filename = strrep(filename, '\', '/');
        end
        
        cd(filename);
        
        for k = 1 : train
            imagename = strcat(filename, '\', int2str(k),'.pgm'); 
           
            if ~wn
                imagename = strrep(imagename, '\', '/');
            end
            
            x = imread(imagename);
            y = reshape(x,[size(x,1)*size(x,2),1]);
            z = [z , y];
        end
    end
    return;
end