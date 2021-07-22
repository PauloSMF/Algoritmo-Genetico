%% Realiza��o do elitismo para a constru��o da popula��o para a nova gera��o
function elite = elitismo(populacao, novaPopulacao, numeroIndividuos)
    porcentagemPais = 0.1;  %Porcentagem dos pais que v�o se manter na gera��o
    %Ordenando as popula��es de modo que os m�nimos sejam os primeiros
    %elementos
    [~, ordem] = sort([populacao.fitness]);
    populacao = populacao(ordem);   %Ordenando popula��o
    [~, ordem] = sort([novaPopulacao.fitness]);
    novaPopulacao = novaPopulacao(ordem);   %Ordenando a novaPopula��o
    %Selecao dos melhores da gera��o de pais
    for i = 1:round((porcentagemPais*numeroIndividuos))
        elite(i) = populacao(i);
    end
    %Sele��o dos melhores da gera��o de filhos
    parcelaFilhos = numeroIndividuos - round((porcentagemPais*numeroIndividuos));
    for i = 1:parcelaFilhos
        elite(i + round(porcentagemPais*numeroIndividuos)) = novaPopulacao(i);
    end
end