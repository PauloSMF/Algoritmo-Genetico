%% Fun��o de cruzamento single point
function [filhoUm, filhoDois] = cruzamentoSinglePoint(populacao, indicePaiUm, ...
    indicePaiDois, probabilidadeCruzamento, numeroBits)
    %Calculando a incompatibilidade e caso os pais ir�o cruzar
    incompatibilidade = rand; %Gerando compatibilidade aleat�ria
    %Caso a incompatibilidade dos pais seja menor que a probabilidade de
    %cruzamento
    if(incompatibilidade < probabilidadeCruzamento)
        %O cruzamento single point � realizado
        pontoCruzamento = randi([1, numeroBits]); %Gerando ponto de cruzamento aleat�rio
        %Gera��o dos filhos
        filhoUm.cromossomo = [populacao(indicePaiUm).cromossomo(1:pontoCruzamento)...
            populacao(indicePaiDois).cromossomo(pontoCruzamento+1:end)];
        filhoDois.cromossomo = [populacao(indicePaiDois).cromossomo(1:pontoCruzamento)...
            populacao(indicePaiUm).cromossomo(pontoCruzamento+1:end)];
    else    %Do contr�rio os pais s�o passados adiante
        filhoUm = populacao(indicePaiUm);
        filhoDois = populacao(indicePaiDois);
    end
end