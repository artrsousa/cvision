%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%ARTHUR RICARDO - PDI2019 %%
%%        MAIN             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function main()
    close all, clear all, clc;

    path = pwd();
    ngroups = 40;
    nimages = 10;
    windows = false; % change folder name to run in windows %

    classf(path, nimages, ngroups, windows);

    function PC = classf(path, nimages, ngroups, windows)
        train = [50, 60, 70];
        for t = 1 : size(train, 2)
            tmptrainned = round(nimages * train(t) / 100)

            data = lerImgs(tmptrainned, path, ngroups, windows);

            cd(path);

            disp(strcat('NUMBER OF IMAGES IN DATABASE: ', int2str(nimages)));
            disp(strcat('TRAINING WITH: ', int2str(train(t)), '%. ', num2str(tmptrainned)));

            disp('GENERATING AV...');
            [P PC mn] = GerarPCs(data);

            disp('TESTING...');
            hit = 0;
            for i = 1 : ngroups
               folder = strcat(path, '\TOCHANGE\TOCHANGE', int2str(i));
               hitsperclass = 0;
               for j = tmptrainned + 1 : nimages
                    filename = strcat(folder, '\i', int2str(j), '.png'); 
                    tmp = imread(filename);

                    d = Classificar(PC, ProjetarAmostra(tmp, mn, P));

                    if (ceil(d / tmptrainned) == i)
                        hit = hit + 1;
                        hitsperclass = hitsperclass + 1;
                    %else
                    %    figure(1);
                    %    imshowpair(reshape(data(:, d), 200, 300), tmp, 'montage');
                    end

               end
               disp(strcat('Hits per class: ', i, ': hitsperclass: ', int2str(hitsperclass), ' .total:', int2str(nimages - (tmptrainned + 1))));
            end

            hitpercent = hit / (ngroups * (nimages - tmptrainned - 1));
            misspercent = 1 - hitpercent;

            totalt = num2str(ngroups * (nimages - tmptrainned));

            disp(strcat('numero de testes=', totalt))
            disp(strcat('numero de acertos=', int2str(hit)));

            disp(strcat('Porcentagem de erro=', num2str(100 * misspercent), '%'));
            disp(strcat('Porcentagem de acerto=', num2str(100 * hitpercent), '%'));
            disp('\\\');

        end

        return;
    end
end
