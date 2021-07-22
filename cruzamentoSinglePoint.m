%% Função de cruzamento single point
function [filhoUm, filhoDois] = cruzamentoSinglePoint(populacao, indicePaiUm, ...
    indicePaiDois, probabilidadeCruzamento, numeroBits)
    %Calculando a incompatibilidade e caso os pais irão cruzar
    incompatibilidade = rand; %Gerando compatibilidade aleatória
    %Caso a incompatibilidade dos pais seja menor que a probabilidade de
    %cruzamento
    if(incompatibilidade < probabilidadeCruzamento)
        %O cruzamento single point é realizado
        pontoCruzamento = randi([1, numeroBits]); %Gerando ponto de cruzamento aleatório
        %Geração dos filhos
        filhoUm.cromossomo = [populacao(indicePaiUm).cromossomo(1:pontoCruzamento)...
            populacao(indicePaiDois).cromossomo(pontoCruzamento+1:end)];
        filhoDois.cromossomo = [populacao(indicePaiDois).cromossomo(1:pontoCruzamento)...
            populacao(indicePaiUm).cromossomo(pontoCruzamento+1:end)];
    else    %Do contrário os pais são passados adiante
        filhoUm = populacao(indicePaiUm);
        filhoDois = populacao(indicePaiDois);
    end
end