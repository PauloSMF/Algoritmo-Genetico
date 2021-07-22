%% Preenchendo população com números aleatórios
function [populacao, melhorSolucao, piorSolucao] = ...
    preencherPopulacao(populacao, numeroIndividuos, melhorSolucao, piorSolucao, numeroBits)
   for i = 1:numeroIndividuos
       %Assinalando ao indivíduo uma cadeia de bits 
       populacao(i).cromossomo = randi([0,1], 1, numeroBits);
       %Calculando o fitness do indivíduo
       populacao(i).fitness = multimodal(populacao(i).cromossomo);
       %Verificando se o indivíduo tem o melhor fitness
       if populacao(i).fitness < melhorSolucao.fitness
           melhorSolucao = populacao(i);
       elseif populacao(i).fitness > piorSolucao
           piorSolucao = populacao(i).fitness;
       end
   end
end