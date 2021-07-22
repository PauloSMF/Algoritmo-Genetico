%% Seleção método roleta de um índice para reprodução
function indice = selecaoTorneio(populacao, numeroIndividuos)
    %Seleção de N índices aleatórios
    N = 10;
    indices = randperm(numeroIndividuos, N);
    %Definição de K e seleção aleatória de R
    K = 0.75;   
    R = rand;
    %Buscando o índice a se selecionar
    indice = indices(1);
    for i = 2:N     %Se R é menor que K o indivíduo de maior fitness é selecionado
        %neste caso, o menor valor, já que o problema é de minimização
        if R < K && populacao(indices(i)).fitness < populacao(indice).fitness
            indice = indices(i);    %Se R é meior que K o indivíduo de menor fitness é selecionado
        %neste caso, o maior valor, já que o problema é de minimização
        elseif R > K && populacao(indices(i)).fitness > populacao(indice).fitness
            indice = indices(i);
        end
    end
end