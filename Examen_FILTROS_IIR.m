clc;
clear all
close all

[entrada, FS] = audioread('archivoPrueba_CI.wav'); 
x = entrada(:,1);

figure,;
plot(x, 'Color','#FF5733');
title('Señal audio_Andrea Gutiérrez');
xlabel('t');
ylabel('Amplitud');

%[X, W] = freqz(x,1);
X = fftshift(fft(x));
F = -FS/2:FS/length(x):FS/2-FS/length(x);

figure,;
%plot(W*FS/(2*pi),abs(X))
plot(F,abs(X), 'Color',	'#F16E22');
title('Señal sin filtrar_Andrea Gutiérrez');
xlabel('F');
ylabel('Amplitud');

a1 = [1	-8.28447760855642	32.2864044082028	-77.5223316369112	126.653272939593	-146.905680487499...
    122.462107474462	-72.4765505140442	29.1860938658082	-7.24115164920489	0.845143389101421];
b1 = [0.919316805623295	-7.74636286703066	30.7052779815476	-74.9838777258455	124.591916251413...
    -146.969710710463	124.591916251413	-74.9838777258455	30.7052779815476	-7.74636286703066	0.919316805623295];

a2 = [1	-7.80270822867679	29.1881323630035	-68.1882845791920	109.668054646046	-126.568754394738...
    106.085686384012	-63.8062261533998	26.4202147413975	-6.83207459039393	0.847005456428825];
b2 = [0.920328993582633	-7.30228599160090	27.7770375564654	-65.9845859765001	107.907180245396...
    -126.624304010198	107.907180245396	-65.9845859765001	27.7770375564654	-7.30228599160090	0.920328993582633];

%Filtrado IIR
y1 = filter(b1,a1,x);
y2 = filter(b2,a2,y1);

figure,;
plot(y1, 'Color',	'#FF9999');
title('Señal audio con primer filtro_Andrea Gutiérrez');
xlabel('t');
ylabel('Amplitud');

Y1 = fftshift(fft(y1));
F1=-FS/2:FS/length(Y1):FS/2-FS/length(Y1);
figure,;
plot(F1,abs(Y1), 'Color',	'#9999FF');
title('Señal con primer filtro_Andrea Gutiérrez');
xlabel('F');
ylabel('Amplitud');

figure,;
plot(y2, 'Color',	'#61A534');
title('Señal audio con segundo filtro_Andrea Gutiérrez');
xlabel('t');
ylabel('Amplitud');

Y2 = fftshift(fft(y2));
F2=-FS/2:FS/length(Y2):FS/2-FS/length(Y2);
figure,;
plot(F2,abs(Y2), 'Color',	'#E43989');
title('Señal con segundo filtro_Andrea Gutiérrez');
xlabel('F');
ylabel('Amplitud');

%sound(y2,FS);

audiowrite('GutiérrezHerreraAndrea_FiltradaIIR.wav',y2,FS);