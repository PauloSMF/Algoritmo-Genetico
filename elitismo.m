%% Realização do elitismo para a construção da população para a nova geração
function elite = elitismo(populacao, novaPopulacao, numeroIndividuos)
    porcentagemPais = 0.1;  %Porcentagem dos pais que vão se manter na geração
    %Ordenando as populações de modo que os mínimos sejam os primeiros
    %elementos
    [~, ordem] = sort([populacao.fitness]);
    populacao = populacao(ordem);   %Ordenando população
    [~, ordem] = sort([novaPopulacao.fitness]);
    novaPopulacao = novaPopulacao(ordem);   %Ordenando a novaPopulação
    %Selecao dos melhores da geração de pais
    for i = 1:round((porcentagemPais*numeroIndividuos))
        elite(i) = populacao(i);
    end
    %Seleção dos melhores da geração de filhos
    parcelaFilhos = numeroIndividuos - round((porcentagemPais*numeroIndividuos));
    for i = 1:parcelaFilhos
        elite(i + round(porcentagemPais*numeroIndividuos)) = novaPopulacao(i);
    end
end