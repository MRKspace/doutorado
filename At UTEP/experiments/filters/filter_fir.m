function [y,h] = filter_fir(x, freq_sampling, freq, filter_type, order, window_type)

%
% [y,h] = filter_fir(x, order, freq_sampling, freq, filter_type, window)
%
% FILTER_FIR recebe um sinal de entrada no dominio do tempo x,
% retorna um filtro FIR h e um sinal de saída y = conv(h,x).
%  
% ORDER é a ordem do filtro, FREQ_SAMPLING é a frequencia de amostragem de x,
% FREQ é a frequencia de corte (nos casos em que FILTER_TYPE é passa-altas, passa-baixa
% ou afins) ou é um vetor do tipo [FREQ_LOW,FREQ_HIGH] (nos casos em que FILTER_TYPE é
% passa faixa ou afins.
% 
% WINDOW_TYPE determina a janela que será utilizada na construção do filtro.
% Caso WINDOW seja 'fft', o sinal de entrada x terá suas componentes de frequencia em torno
% de FREQ zeradas manualmente e será retornado em y; enquanto h receberá 0.
% Note que WINDOW_TYPE é apenas o nome da janela, e não os coeficientes em si!
%
% Exemplo de uso:
%
%	load input_signal
%	x = input_signal;
%	order = 20;
%	freq_sampling = 2000;	
%	freq = 60;
%	filter_type = 'low';
%	window_type = 'blackman';
%	
%	[y,h] = filter_fir(x, order, freq_sampling, freq, filter_type, window_type)
%
% Veja também filter_iir filter_fft fir1 energy
%
% Nov 03 2011
% Diogo

	if (nargin < 6),
		error('Please see help for FILTER_FIR usage.');
	elseif (nargin == 5)
		window_type = hamming;
	end;

	w = (freq./freq_sampling)*2;
	
	if (strcmpi(filter_type,'fft')),
		h = 0;
		y = filter_fft(x,freq_sampling,freq);
	else
		try
			window = eval([window_type '(order + 1)']);

		catch err
			error('Unrecognized WINDOW_TYPE. Please see help for FILTER_FIR usage.');
		end
	end
	
	h = fir1(order, w, filter_type, window);
	y = conv(h,x);
	
