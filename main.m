clc; clear; close all;
rng shuffle     %Gerar diferentes n�meros rand�micos a cada execu��o
%% Par�metros do Algoritmo Gen�tico

%Representa��o bin�ria
numeroIndividuos = 100;     %N�mero de indiv�duos da popula��o
numeroBits = 36;        %N�mero de bits usados na representa��o do cromossomo
                    %18 bits s�o necess�rios para representar os 200000
                    %n�meros no intervalo de -10 a 10 com 4 casas decimais
                    %Bits 1 a 18 referem-se a x1 e 19 a 36 referem-se a x2
                    
%Template do indiv�duo
individuo.cromossomo = [];  %Cromossomo armazena a cadeia de bits do indiv�duo
individuo.fitness = [];     %Fitness armazena o resultado de f_x do indiv�duo

melhorSolucao.cromossomo = [];  %Armazena cromossomo do melhor indiv�duo
melhorSolucao.fitness = inf;    %Armazena o indiv�duo de melhor solu��o
                                %Seu fitness inicialmente � um n�mero muito
                                %grande, como � um problema de minimiza��o
piorGeracaoInicial = -inf;  %Armazena o pior da gera��o inicial

numeroGeracoes = 100;       %N�mero de gera��es do algoritmo
melhoresCasos = zeros(numeroGeracoes, 1);   %Vetor para armazenamento de melhor e pior 
pioresCasos = zeros(numeroGeracoes, 1);     %fitness de cada gera��o, iniciado como 0s
fitnessMedio = zeros(numeroGeracoes, 1);    %Vetor para armazenar fitness m�dio de cada gera��o

probabilidadeCruzamento = 0.7;    %Probabilidade de cruzamento de indiv�duos
probabilidadeMutacao = 0.2; %Probabilidade de muta��o de um indiv�duo

%% Popula��o inicial
%Criando uma popula��o com tamanho numeroIndividuos com indiv�duos vazios
populacao = repmat(individuo, numeroIndividuos, 1);
%Preenchendo a populacao inicial
[populacao, melhorSolucao, piorGeracaoInicial] = ...
    preencherPopulacao(populacao, numeroIndividuos, melhorSolucao, piorGeracaoInicial, numeroBits);
melhorGeracaoInicial = melhorSolucao;

%% Loop principal do GA
for geracao = 1:numeroGeracoes
    %Criando uma nova popula��o de tamanho numeroIndividuos com indiv�duos
    novaPopulacao = repmat(individuo, numeroIndividuos, 1); %vazios
    
    %Realizando sele��es, cruzamentos e muta��es
    for numeroCruzamento = 1:2:numeroIndividuos
        %Realizando a sele��o dos pais
        indicePaiUm = selecaoTorneio(populacao, numeroIndividuos);
        indicePaiDois = selecaoTorneio(populacao, numeroIndividuos);
        %Caso o indice dos pais � o mesmo
        while indicePaiUm == indicePaiDois
            indicePaiDois = selecaoTorneio(populacao, numeroIndividuos);
        end
        %Executando cruzamentos        
        [filhoUm, filhoDois] = cruzamentoSinglePoint(populacao, ...
            indicePaiUm, indicePaiDois, probabilidadeCruzamento, numeroBits);
        
        novaPopulacao(numeroCruzamento).cromossomo = filhoUm.cromossomo;
        novaPopulacao(numeroCruzamento+1).cromossomo = filhoDois.cromossomo;
    end
    
    %Realizando muta��es
    for numeroMutacao = 1:round(numeroIndividuos*probabilidadeMutacao)
        novaPopulacao(numeroMutacao).cromossomo = ...
            mutacaoInversao(novaPopulacao(numeroMutacao).cromossomo, numeroBits);
    end
    
    %Avaliando o fitness da nova popula��o
    for i = 1:numeroIndividuos
        %Avaliando o indiv�duo
        novaPopulacao(i).fitness = multimodal(novaPopulacao(i).cromossomo);
    end
    %Realizando o elitismo
    populacao = elitismo(populacao, novaPopulacao, numeroIndividuos);
    
    %Verificando melhor e pior fitness e calculando a m�dia da gera��o
    melhorGeracao = inf;  
    piorGeracao = -inf;    
    media = 0;
    for i = 1:numeroIndividuos
        %Verificando se esta solu��o � a melhor hist�rica, se � m�nima
        if populacao(i).fitness < melhorSolucao.fitness
            melhorSolucao = populacao(i);
        end
        %Verificando melhor e pior da gera��o    
        if populacao(i).fitness < melhorGeracao
            melhorGeracao = populacao(i).fitness;
        elseif populacao(i).fitness > piorGeracao
            piorGeracao = populacao(i).fitness;
        end
        %C�lculo da m�dia da gera��o
        media = media + populacao(i).fitness;
    end
    media = media/numeroIndividuos;
    %Atualizando a melhor e pior solu��o desta gera��o nos vetores
    melhoresCasos(geracao) = melhorGeracao;
    pioresCasos(geracao) = piorGeracao;
    fitnessMedio(geracao) = media;
end

%% Impress�o dos resultados
%Fitness m�dio
figure;
plot(fitnessMedio, 'yellow');
xlabel('Gera��o');
ylabel('Fitness');
title('Fitness m�dio por gera��o');
grid on;
%Imprimindo gr�fico: piores solu��es por gera��o
figure;
plot(pioresCasos, 'red');
xlabel('Gera��o');
ylabel('Fitness');
title('Piores casos de fitness por gera��o');
grid on;
%Melhores solu��es
[x1, x2] = binarioReal(melhorSolucao.cromossomo);
melhorFitness = num2str(melhorSolucao.fitness);
x1 = num2str(x1);
x2 = num2str(x2);
melhorFitness = strcat('Melhor solu��o:  ', melhorFitness,'  em x1 =  ',x1,'  e x2 =  ',x2);
%Imprimindo gr�fico: melhores solu��es por gera��o
figure;
plot(melhoresCasos);
xlabel('Gera��o');
ylabel('Fitness');
title(melhorFitness);
grid on;
%Imprimindo melhor e pior caso da gera��o inicial
melhorInicial = strcat('Melhor caso da gera��o inicial: ', num2str(melhorGeracaoInicial.fitness));
piorInicial = strcat('Pior caso da gera��o inicial: ', num2str(piorGeracaoInicial));
disp(melhorInicial);
disp(piorInicial);