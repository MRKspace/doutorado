function [y,num,den] = filter_iir(x, freq_sampling, freq, filter_type, order, filter_class, parameters)

%
% [y,num,den] = filter_iir(x, order, freq_sampling, freq, filter_type, filter_class, parameters)
%
% FILTER_IIR recebe um sinal de entrada no dominio do tempo x,
% retorna sinal filtrado y no domínio do tempo e 
% NUM e DEN, que são o numerador e denominador do filtro utilizado.
% y = filter(num,den,x)
%  
% ORDER é a ordem do filtro, FREQ_SAMPLING é a frequencia de amostragem de x,
% FREQ é a frequencia de corte (nos casos em que FILTER_TYPE é passa-altas, passa-baixa
% ou afins) ou é um vetor do tipo [FREQ_LOW,FREQ_HIGH] (nos casos em que FILTER_TYPE é
% passa faixa ou afins.
% 
% FILTER_CLASS é a classe do filtro (cheby1, cheby2, butter, etc), e PARAMETERS são parâmetros
% adicionais associados à classe escolhida.
% Por exemplo, se utilizarmos a classe cheby1, PARAMETERS deve conter [R];
% se utilizarmos a classe butter, PARAMETERS não deve ser passado;
% se utilizarmos a classe ellip, PARAMETERS deve conter [Rp,Rs].
%
% Exemplo de uso:
%
%	load input_signal
%	x = input_signal;
%	order = 20;
%	freq_sampling = 2000;	
%	freq = 60;
%	filter_type = 'low';
%	filter_class = 'ellip';
%	parameters = [0.8,25];
%	
%	[y,num,den] = filter_iir(x, order, freq_sampling, freq, filter_type, filter_class, parameters)
%
% Veja também filter_fir filter_fft fir1 energy
%
% Nov 03 2011
% Diogo

	if (nargin < 5),
		error('Please see help for FILTER_IIR usage.');
	elseif (nargin == 5)
		filter_class = 'cheby1';
	end;

	w = (freq./freq_sampling)*2;

	switch filter_class
		case 'cheby1'
			if (exist('parameters'))
				R = parameters;   	% R decibels of peak-to-peak ripple in the passband
			else
				R = 0.5			% 0.5 is a tipical value	
			end
			[num,den] = cheby1(order, R, w, filter_type);
				
		case 'cheby2'
			if (exist('parameters'))
				R = parameters;   	% R decibels of peak-to-peak ripple in the passband
			else
				clear R;
				R = 20;			% 20 is a tipical value	
			end
			[num,den] = cheby2(order, R, w, filter_type);
		
		case 'butter'
			[num,den] = butter(order, w, filter_type);
	
		case 'besself'
			[num,den] = besself(order, w);
	
		case 'ellip'
			if (exist('parameters'))
				Rp = parameters(1);   	% Rp decibels of peak-to-peak ripple in the passband
				Rs = parameters(2);	% Rs is minimun stopband atetenuation
			else
				Rp = 0.5		% 0.5 is a tipical value
				Rs = 20			% 20 is a tipical value		
			end
			[num,den] = ellip(order, Rp, Rs, w, filter_type);
	
		otherwise
			error('Unrecognized FILTER_CLASS. Please see help for FILTER_IIR usage.');
	end

	y = filter(num,den,x);
	
