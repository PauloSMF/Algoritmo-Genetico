%% Muta��o por invers�o
function novoCromossomo = mutacaoInversao(cromossomo, numeroBits)
    %Selecionando um gene aleat�rio para limite inferior
    geneInferior = randi([1, numeroBits]);
    while geneInferior == numeroBits  %Caso este gene seja o �ltimo
        geneInferior = randi([1, numeroBits]);
    end
    %Selecionando um gene aleat�rio para limite superior
    geneSuperior = randi([1, numeroBits]);  %Caso este gene seja igual ou menor que o inferior
    while geneSuperior == geneInferior ||  geneSuperior < geneInferior
        geneSuperior = randi([1, numeroBits]);
    end
    %Invertendo os bits no intervalo
    for i = geneInferior:geneSuperior
        if cromossomo(i) == 1
            cromossomo(i) = 0;
        else
            cromossomo(i) = 1;
        end
    end
    %Retornando o cromossomo mutado
    novoCromossomo = cromossomo;
end