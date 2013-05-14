function cnz = convnz(h_0,h_1)

%
% cnz = convnz(h_0,h_1)
%
% CONVNZ, ou CONV No Zeros, realiza a convolução entre h_0 e h_1 e retorna 
% o resultado após remover todos os 0 a direita do vetor resultado.
%
% Exemplo de uso:
%
%	a = [1 2 3 0 5 0 0 0 0];
%	b = [1 2 3 0 0 0];
%	cnz = convnz(a,b)
%
% Veja também energy_calc filter_iir filter_fir filter_fft fir1 
%
% Dez 07 2011
% Cristiano, Ema, Diogo

	cnz = conv(h_0,h_1);
	cnz = cnz(1:find(cnz,1,'last'));

