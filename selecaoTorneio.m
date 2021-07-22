%% Sele��o m�todo roleta de um �ndice para reprodu��o
function indice = selecaoTorneio(populacao, numeroIndividuos)
    %Sele��o de N �ndices aleat�rios
    N = 10;
    indices = randperm(numeroIndividuos, N);
    %Defini��o de K e sele��o aleat�ria de R
    K = 0.75;   
    R = rand;
    %Buscando o �ndice a se selecionar
    indice = indices(1);
    for i = 2:N     %Se R � menor que K o indiv�duo de maior fitness � selecionado
        %neste caso, o menor valor, j� que o problema � de minimiza��o
        if R < K && populacao(indices(i)).fitness < populacao(indice).fitness
            indice = indices(i);    %Se R � meior que K o indiv�duo de menor fitness � selecionado
        %neste caso, o maior valor, j� que o problema � de minimiza��o
        elseif R > K && populacao(indices(i)).fitness > populacao(indice).fitness
            indice = indices(i);
        end
    end
end