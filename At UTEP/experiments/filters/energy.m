function energy_band = energy(filter_method, bands, varargin)

%
% energy_band = energy(filter_method, bands, varargin)
%
% ENERGY recebe um sinal X e retorna um vetor ENERGY_BAND com a energia nas bandas BANDS.
% 
% BANDS é um vetor com as bandas de energia a serem calculadas.
% Por exemplo, para BANDS = [8 12; 13 23; 24 28],
% teremos ENERGY = [e1 e2 e3], onde eN representa a energia da banda
% representada pelo N-ésimo elemento de BANDS.
% 
% Note que ENERGY terá sempre o mesmo número de elementos de BANDS.
%
% FILTER_METHOD é o método de filtragem a ser utilizado. Deve ser
% filter_fir, filter_iir ou filter_fft.
%
% VARARGIN é o conjunto de parâmetros de entrada do FILTER_METHOD escolhido.
% Os parametros FREQ e FILTER_TYPE sempre serão sobrescritos automaticamente
% por BANDS e 'bandpass'. 
%
% Note que o sinal X é sempre passado como o primeiro elemento de varargin.
%
% Se BANDS for um vetor [], os valores default listados abaixo serão utilizados.
%
%	DELTA = 0.1 - 04 Hz
%	THETA = 04 - 07 Hz	
%	ALPHA = 08 - 12 Hz
%	MU    = 08 - 13 Hz
%	BETA  = 12 - 30 Hz
%	GAMMA = 25 - 100 Hz
%
% Exemplo de uso:
%
%	bands = [];
%	x = randn(1000);	
%	freq_sampling = 300;
%	freq = 20;	
%	filter_type = 'bandpass';
%	order_iir = 4;
%	filter_class = 'ellip';
%	parameters = [0.5 20];
%	
%	energy_band = energy('filter_iir', bands, x, freq_sampling, freq, filter_type, order_iir, filter_class, parameters)
%
%
% Veja também energy_calc filter_iir filter_fir filter_fft fir1 
%
% Nov 21 2011
% Diogo

	if (size(bands) == [0 0])
		DELTA = [0.1 04];
		THETA = [04 07];
		ALPHA = [08 12];
		MU    = [08 13];
		BETA  = [12 30];
		GAMMA = [25 50];
	
		bands = [DELTA; THETA; ALPHA; MU; BETA; GAMMA];
	elseif (~(size(bands,2) == 2))
		error('Inapropriate BANDS. Please see help for ENERGY usage.');
	end;	

	x 		= varargin{1};
	freq_sampling 	= varargin{2};
	freq 		= varargin{3};
	filter_type 	= 'bandpass';

	switch filter_method
		case 'filter_fir'
			order = varargin{5};
			window_type = varargin{6};
	
			for i = 1 : size(bands,1)
				[y,h] = filter_fir(x, freq_sampling, bands(i,:), filter_type, order, window_type);
				energy_band(i) = energy_calc(y); 
			end	

		case 'filter_iir'
			order = varargin{5};
			filter_class = varargin{6};
			parameters = varargin{7};

			for i = 1 : size(bands,1)
				[y,num,den] = filter_iir(x, freq_sampling, bands(i,:), filter_type, order, filter_class, parameters);
				energy_band(i) = energy_calc(y); 
			end	
			
		case 'filter_fft'
		
			for i = 1 : size(bands,1)
				y = filter_fft(x, freq_sampling, bands(i,:), filter_type);
				energy_band(i) = energy_calc(y); 
			end	
	end %switch
	
	
function energy = energy_calc(x)
	energy = sum(abs(x).^2);
	% energy = norm(x)^2;
	
