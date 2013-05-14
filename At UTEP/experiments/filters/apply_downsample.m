function ads = apply_downsample(sig)

%
% ads = apply_downsample(sig)
%
% APPLY_DOWNSAMPLE recebe um vetor de células SIG 
% com N células e retorna um vetor com N células dizimadas
% de acordo com a sua posição ao quadrado, ou seja, 
% a primeira célula será dizimada por fator 2,
% a segunda célula será dizimada por fator 4,
% e assim sucessivamente,
% COM EXCEÇÃO DA ÚLTIMA CÉLULA, que será dizimada pelo
% mesmo fator que a célula anterior, ou 2^(N-1).
%
% Exemplo de uso,
%
%	sig = { (1:32) (1:32) (1:32) (1:32) (1:32)};
%	y = apply_downsample(sig);
%	y{:}
%
% Veja também apply_filter_bank apply_upsample iterate_filters synthesis_filter_bank analysis_filter_bank
%
% Dez 07 2011
% Cristiano, Ema e Diogo

	l = length(sig) - 1;
	down = [2.^(1:l) 2^l];
	
	for i = 1 : l + 1
		ads{i} = downsample(sig{i},down(i));
	end

