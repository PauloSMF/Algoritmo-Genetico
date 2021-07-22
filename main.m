clc; clear; close all;
rng shuffle     %Gerar diferentes números randômicos a cada execução
%% Parâmetros do Algoritmo Genético

%Representação binária
numeroIndividuos = 100;     %Número de indivíduos da população
numeroBits = 36;        %Número de bits usados na representação do cromossomo
                    %18 bits são necessários para representar os 200000
                    %números no intervalo de -10 a 10 com 4 casas decimais
                    %Bits 1 a 18 referem-se a x1 e 19 a 36 referem-se a x2
                    
%Template do indivíduo
individuo.cromossomo = [];  %Cromossomo armazena a cadeia de bits do indivíduo
individuo.fitness = [];     %Fitness armazena o resultado de f_x do indivíduo

melhorSolucao.cromossomo = [];  %Armazena cromossomo do melhor indivíduo
melhorSolucao.fitness = inf;    %Armazena o indivíduo de melhor solução
                                %Seu fitness inicialmente é um número muito
                                %grande, como é um problema de minimização
piorGeracaoInicial = -inf;  %Armazena o pior da geração inicial

numeroGeracoes = 100;       %Número de gerações do algoritmo
melhoresCasos = zeros(numeroGeracoes, 1);   %Vetor para armazenamento de melhor e pior 
pioresCasos = zeros(numeroGeracoes, 1);     %fitness de cada geração, iniciado como 0s
fitnessMedio = zeros(numeroGeracoes, 1);    %Vetor para armazenar fitness médio de cada geração

probabilidadeCruzamento = 0.7;    %Probabilidade de cruzamento de indivíduos
probabilidadeMutacao = 0.2; %Probabilidade de mutação de um indivíduo

%% População inicial
%Criando uma população com tamanho numeroIndividuos com indivíduos vazios
populacao = repmat(individuo, numeroIndividuos, 1);
%Preenchendo a populacao inicial
[populacao, melhorSolucao, piorGeracaoInicial] = ...
    preencherPopulacao(populacao, numeroIndividuos, melhorSolucao, piorGeracaoInicial, numeroBits);
melhorGeracaoInicial = melhorSolucao;

%% Loop principal do GA
for geracao = 1:numeroGeracoes
    %Criando uma nova população de tamanho numeroIndividuos com indivíduos
    novaPopulacao = repmat(individuo, numeroIndividuos, 1); %vazios
    
    %Realizando seleções, cruzamentos e mutações
    for numeroCruzamento = 1:2:numeroIndividuos
        %Realizando a seleção dos pais
        indicePaiUm = selecaoTorneio(populacao, numeroIndividuos);
        indicePaiDois = selecaoTorneio(populacao, numeroIndividuos);
        %Caso o indice dos pais é o mesmo
        while indicePaiUm == indicePaiDois
            indicePaiDois = selecaoTorneio(populacao, numeroIndividuos);
        end
        %Executando cruzamentos        
        [filhoUm, filhoDois] = cruzamentoSinglePoint(populacao, ...
            indicePaiUm, indicePaiDois, probabilidadeCruzamento, numeroBits);
        
        novaPopulacao(numeroCruzamento).cromossomo = filhoUm.cromossomo;
        novaPopulacao(numeroCruzamento+1).cromossomo = filhoDois.cromossomo;
    end
    
    %Realizando mutações
    for numeroMutacao = 1:round(numeroIndividuos*probabilidadeMutacao)
        novaPopulacao(numeroMutacao).cromossomo = ...
            mutacaoInversao(novaPopulacao(numeroMutacao).cromossomo, numeroBits);
    end
    
    %Avaliando o fitness da nova população
    for i = 1:numeroIndividuos
        %Avaliando o indivíduo
        novaPopulacao(i).fitness = multimodal(novaPopulacao(i).cromossomo);
    end
    %Realizando o elitismo
    populacao = elitismo(populacao, novaPopulacao, numeroIndividuos);
    
    %Verificando melhor e pior fitness e calculando a média da geração
    melhorGeracao = inf;  
    piorGeracao = -inf;    
    media = 0;
    for i = 1:numeroIndividuos
        %Verificando se esta solução é a melhor histórica, se é mínima
        if populacao(i).fitness < melhorSolucao.fitness
            melhorSolucao = populacao(i);
        end
        %Verificando melhor e pior da geração    
        if populacao(i).fitness < melhorGeracao
            melhorGeracao = populacao(i).fitness;
        elseif populacao(i).fitness > piorGeracao
            piorGeracao = populacao(i).fitness;
        end
        %Cálculo da média da geração
        media = media + populacao(i).fitness;
    end
    media = media/numeroIndividuos;
    %Atualizando a melhor e pior solução desta geração nos vetores
    melhoresCasos(geracao) = melhorGeracao;
    pioresCasos(geracao) = piorGeracao;
    fitnessMedio(geracao) = media;
end

%% Impressão dos resultados
%Fitness médio
figure;
plot(fitnessMedio, 'yellow');
xlabel('Geração');
ylabel('Fitness');
title('Fitness médio por geração');
grid on;
%Imprimindo gráfico: piores soluções por geração
figure;
plot(pioresCasos, 'red');
xlabel('Geração');
ylabel('Fitness');
title('Piores casos de fitness por geração');
grid on;
%Melhores soluções
[x1, x2] = binarioReal(melhorSolucao.cromossomo);
melhorFitness = num2str(melhorSolucao.fitness);
x1 = num2str(x1);
x2 = num2str(x2);
melhorFitness = strcat('Melhor solução:  ', melhorFitness,'  em x1 =  ',x1,'  e x2 =  ',x2);
%Imprimindo gráfico: melhores soluções por geração
figure;
plot(melhoresCasos);
xlabel('Geração');
ylabel('Fitness');
title(melhorFitness);
grid on;
%Imprimindo melhor e pior caso da geração inicial
melhorInicial = strcat('Melhor caso da geração inicial: ', num2str(melhorGeracaoInicial.fitness));
piorInicial = strcat('Pior caso da geração inicial: ', num2str(piorGeracaoInicial));
disp(melhorInicial);
disp(piorInicial);