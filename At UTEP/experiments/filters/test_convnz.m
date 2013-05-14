clear all; close all; clc

	a = [1 2 3 0 5 0 0 0 0];
	za = find(a == 0);
	
	b = [1 2 3 0 0 0];
	zb = find(b == 0);
	
	a_no_zeros = a(1:5);
	
	conv_AB = conv(a,b);
	conv_AB_no_zeros= conv(a_no_zeros,b);
	convnz_AB=convnz(a,b);
	
	% Plot	
	fprintf('\n\t\t\t\t Test_CONVNZ\n\n');
	
	fprintf('\na  = [\t%d \t%d \t%d \t%d \t%d \t%d \t%d \t%d \t%d ]',a(:));
	fprintf('\na* = [\t%d \t%d \t%d \t%d \t%d \t \t \t \t  ]',a_no_zeros(:));
	fprintf('\nb  = [\t%d \t%d \t%d \t%d \t%d \t%d \t \t \t  ]',b(:));

	fprintf('\n\n');	
	fprintf('\nconv(a,b)   = [\t%d \t%d \t%d \t%d \t%d \t%d \t%d ]',conv_AB(1:7));
	fprintf('\n              [\t%d \t%d \t%d \t%d \t%d \t%d \t%d  ]',conv_AB(8:14));

	fprintf('\n\n');	
	fprintf('\nconv(a*,b)  = [\t%d \t%d \t%d \t%d \t%d \t%d \t%d ]',conv_AB_no_zeros(1:7));
	fprintf('\n              [\t%d \t%d \t%d \t \t \t \t   ]',conv_AB_no_zeros(8:10));

	fprintf('\n\n');	
	fprintf('\nconvnz(a,b) = [\t%d \t%d \t%d \t%d \t%d \t%d \t%d ]',convnz_AB(1:7));
	
	fprintf('\n\n');	
	
	
	
	
