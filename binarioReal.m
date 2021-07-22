%% Convers�o da representa��o do cromossomo para n�mero real
function [X1, X2] = binarioReal(X)
    %Separando cromossomos referentes a X1 e referentes a X2
    V1 = X(1:18);
    V2 = X(19:end); 
    %Convers�es
    X1 = bi2de(V1, 'left-msb');
    X1 = -10 + 0.0001*X1;
    
    X2 = bi2de(V2, 'left-msb');
    X2 = -10 + 0.0001*X2;
    %Ajustando valores maiores que desejado pois
    %Com 18 bits � poss�vel representar mais que 200000 n�meros
    if X1 > 10.0000
        X1 = 10.0000;
    end
    if X2 > 10.0000
        X2 = 10.0000;
    end
end