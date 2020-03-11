%%%%%%%%%%%%% main %%%%%%%%%%%%%%%%
%%ARTHUR RICARDO - PDI2019 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function main()
    close all, clear all, clc;
    
    mainfolder = pwd();
    path = strcat(mainfolder, '\dataBase\orl_faces');
    classname = '\s';
    wn = false; % change so to run in windows %
    ngroups = 40;
    nimages = 10;
    
    classf(path, classname, nimages, ngroups, wn);
    
    chdir(mainfolder);
    
    function PC = classf(path, classname, nimages, ngroups, wn)
        train = [50, 60 ,70];
        for t = 1 : size(train, 2)
            tmptrainned = round(nimages * train(t) / 100);

            data = lerImgs(tmptrainned, strcat(path, classname), ngroups, wn);
            
            if ~wn
                path = strrep(path, '\', '/');
            end
            
            cd(path);

            disp(strcat('NUMBER OF IMAGES IN DATABASE: ', int2str(nimages)));
            disp(strcat('TRAINING WITH: ', int2str(train(t)), '%. ', num2str(tmptrainned)));

            disp('GENERATING AV...');
            [P PC mn] = GerarPCs(data);

            disp('TESTING...');
            
            hit = 0;
            for i = 1:ngroups
               folder = strcat(path, classname, int2str(i));
               hitsperclass = 0;
               for j = tmptrainned + 1 : nimages
                    filename = strcat(folder,'\',int2str(j),'.pgm'); 
               
                    if ~wn
                        filename = strrep(filename,'\','/');
                    end
                    
                    tmp = imread(filename);
                    d = Classificar(PC,ProjetarAmostra(tmp,mn,P));
                    
                    if (ceil(d/tmptrainned) == i)
                        hit = hit + 1;
                        hitsperclass = hitsperclass + 1;
                    else
                        %figure(1);
                        %imshowpair(reshape(data(:, d), size(tmp, 1), size(tmp, 2)), tmp, 'montage');
                    end

               end
               
               disp(strcat('Hits per class - ',int2str(i),...
                   ': hitsperclass: ',int2str(hitsperclass),...
                   ' - ',num2str(100*hitsperclass/(nimages-tmptrainned)), '%. ',...
                   ' .total:',int2str(nimages - tmptrainned)));
            end

            hitpercent = hit / (ngroups * (nimages - tmptrainned));
            misspercent = 1 - hitpercent;

            totalt = num2str(ngroups * (nimages - tmptrainned));

            disp(strcat('numero de testes=', totalt))
            disp(strcat('numero de acertos=', int2str(hit)));

            disp(strcat('Porcentagem de erro=', num2str(100 * misspercent), '%'));
            disp(strcat('Porcentagem de acerto=', num2str(100 * hitpercent), '%'));
            disp('\\\');

        end

    end
end
