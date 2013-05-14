function y = filter_fft(x, freq_sampling, freq, filter_type)

%
% y = filter_fft(x, freq_sampling, freq, filter_type)
%
% FILTER_FFT recebe um sinal X no dominio do tempo
% e retorna um sinal filtrado no dominio do tempo.
% As componentes de frequencia em torno de FREQ são zeradas,
% de acordo com FILTER_TYPE - 'notch', 'low', 'high', 'bandpass' ou 'reject'.
%
% Exemplo de uso,
%
%	freq_sampling = 1000;
%	freq_low = 60;
%	freq_high = 120;
%	freq = [freq_low freq_high];
%	filter_type = 'reject';
%	x = randn(2000);
%	
%	y = filter_fft(x, freq_sampling, freq, filter_type);
%
% Veja também filter_fir filter_iir fir1 energy
%
% Nov 03 2011
% Diogo

	if (nargin < 3),
		error('Please see help for INPUT DATA.');
	elseif (nargin == 3)
		filter_type = 'notch';
	end;
	
	signal_length = length(x);
	X = fft(x);
	Y = X;

	if (length(freq) == 1)
		k = round(freq*signal_length/freq_sampling);		
	else
		k_low = round(freq(1)*signal_length/freq_sampling);			
		k_high = round(freq(2)*signal_length/freq_sampling);	
	end
	
	switch filter_type
		case 'high'
			Y(1 : k - 1) = 0;
			Y(mirror(k-1, signal_length) : signal_length) = 0;			
			
		case 'low'
			Y(k + 1 : mirror(k + 1, signal_length)) = 0;
			
		case 'notch'
			% TODO tem que parametrizar isso? este valor está arbritrário
			n_coeficientes = round(0.0022*signal_length);

			% Filtragem no domínio da frequência
			if (k < n_coeficientes), 
				k = n_coeficientes/2 + 1;
			end

			Y(k-n_coeficientes/2 : k + n_coeficientes/2) = 0;
			k_espelhado = signal_length - k + 2;
			Y(k_espelhado-n_coeficientes/2 : k_espelhado + n_coeficientes/2) = 0;
		
		case 'bandpass'
			Y(1 : k_low - 1) = 0;
			Y(mirror(k_low - 1, signal_length)  : signal_length) = 0;
			Y(k_high + 1 : mirror(k_high + 1, signal_length)) = 0;		
						
		case 'reject'
			Y(k_low + 1 : k_high -1) = 0;
			Y(mirror(k_high - 1, signal_length) : mirror(k_low + 1, signal_length)) = 0;
			
		otherwise
			 error('Unrecognized FILTER_TYPE. Please see help for FILTER_FFT usage.');

	end
	
	y = ifft(Y);
	
	
function espelhado = mirror(k, N)

	espelhado = N - k + 2;
	
	
	
	
	
