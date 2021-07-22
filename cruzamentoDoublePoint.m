%% Função de cruzamento double point 
function [filhoUm, filhoDois] = cruzamentoDoublePoint(populacao, indicePaiUm, ...
    indicePaiDois, probabilidadeCruzamento, numeroBits)
    %Calculando a incompatibilidade e caso os pais irão cruzar
    incompatibilidade = rand; %Gerando compatibilidade aleatória
    %Caso a incompatibilidade dos pais seja menor que a probabilidade de
    %cruzamento
    if(incompatibilidade < probabilidadeCruzamento)
        pontosCruzamento = randperm(numeroBits,2);  %Gerando dois pontos de cruzamento aleatório
        pontoCruzamentoUm = min(pontosCruzamento(1), pontosCruzamento(2));  %Primeiro ponto de cruzamento 
        pontoCruzamentoDois = max(pontosCruzamento(1), pontosCruzamento(2));  %Segundo ponto de cruzamento
        %Geração dos filhos
        filhoUm.cromossomo = [populacao(indicePaiUm).cromossomo(1:pontoCruzamentoUm)...
            populacao(indicePaiDois).cromossomo(pontoCruzamentoUm+1:pontoCruzamentoDois)...
            populacao(indicePaiUm).cromossomo(pontoCruzamentoDois+1:end)];
        filhoDois.cromossomo = [populacao(indicePaiDois).cromossomo(1:pontoCruzamentoUm)...
            populacao(indicePaiUm).cromossomo(pontoCruzamentoUm+1:pontoCruzamentoDois)...
            populacao(indicePaiDois).cromossomo(pontoCruzamentoDois+1:end)];
    else    %Do contrário os pais são passados adiante
        filhoUm = populacao(indicePaiUm);
        filhoDois = populacao(indicePaiDois);
    end
end