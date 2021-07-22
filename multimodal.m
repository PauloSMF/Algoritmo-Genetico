%% Função multimodal usada no Algoritmo Genético
function f_x = multimodal(X)
    %Realizando a conversão dos cromossomos para números reais
    [X1, X2] = binarioReal(X);
    %Computando os somatórios
    Y1 = (cos((2)*X1+1))+(2*cos((3)*X1+2))+(3*cos((4)*X1+3))+(4*cos((5)*X1+4))+(5*cos((6)*X1+5));
    Y2 = (cos((2)*X2+1))+(2*cos((3)*X2+2))+(3*cos((4)*X2+3))+(4*cos((5)*X2+4))+(5*cos((6)*X2+5));
    %Retornando o valor de f_x (Fitness)
    f_x = Y1*Y2;
end