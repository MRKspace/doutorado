function aus = apply_upsample(sig)

%
% aus = apply_upsample(SIG)
%
% APPLY_UPSAMPLE recebe um vetor de células SIG 
% com N células e retorna um vetor com N células reconstruidas
% de acordo com a sua posição ao quadrado, ou seja, 
% a primeira célula será "upsamplezada" por fator 2,
% a segunda célula será "upsamplezada" por fator 4,
% e assim sucessivamente,
% COM EXCEÇÃO DA ÚLTIMA CÉLULA, que será "upsamplezada" pelo
% mesmo fator que a célula anterior, ou 2^(N-1).
%
% Exemplo de uso,
%
%	sig = { (1:32) (1:32) (1:32) (1:32) (1:32)};
%	y = apply_upsample(sig);
%	y{:}
%
% Veja também apply_filter_bank apply_downsample iterate_filters synthesis_filter_bank analysis_filter_bank
%
% Dez 07 2011
% Cristiano, Ema e Diogo

% TODO melhorar este nome "upsamplezada"

	l = length(sig) - 1;
	up = [2.^(1:l) 2^l];
	
	for i = 1 : l + 1
		aus{i} = upsample(sig{i},up(i));
	end

