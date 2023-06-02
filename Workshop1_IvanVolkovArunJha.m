% Medical Imaging
% Workshop 1
% Ivan Volkov 988146 and Arun Jha 997110
% 17/03/22

%% Section A
% create the image (Q1)
Img = zeros(50, 80);

% create initials (Q2)
Img(10:40, 10:15) = 1;
Img(10:15, 10:30) = 1;
Img(10:40, 25:30) = 1;
Img(25:30, 10:30) = 1;

% Second initial
Img(10:40, 60:65) = 1;
Img(35:40, 50:65) = 1;
Img(30:35, 50:55) = 1;

% figure (Q3)
figure(1);
imagesc(Img);
colormap gray
axis image
title("Initials Image, Section A");

% Sobel edge detector (Q4)
% filter
fSx = [-1 0 1; -2 0 2; -1 0 1];
fSy = [1 2 1; 0 0 0; -1 -2 -1];

% filter application
SobXEdges = conv2(Img, fSx, 'same');
SobYEdges = conv2(Img, fSy, 'same');
SobelMagEdges = sqrt(SobXEdges.^2 + SobYEdges.^2);

% binarisation
SobelLetterEdges = (SobelMagEdges >= 1);

% display
figure(2);
imagesc(SobelLetterEdges);
colormap gray
axis image
axis off
title("Sobel Edges, Section A");

% matlab edge function (Q5)
matlabSobel = edge(Img, 'sobel');

% display
figure(3);
imagesc(matlabSobel);
colormap gray
axis image
axis off 
title("Matlab Sobel, Section A");

% A.2 question
figure;
imagesc(SobXEdges);
colormap gray
axis image
axis off
title("Sobel in x, Section A");

figure;
imagesc(SobYEdges);
colormap gray
axis image
axis off
title("Sobel in y, Section A");

%% Section B
% load the image (Q1)
ImgB = imread('NoisyBrainMRI(1).jpg');

% display 
figure(4);
imagesc(ImgB);
colormap gray
axis image
title("Original Image, Section B"); 

% convert to double (Q2)
ImgB = double(ImgB);

% Gaussian filter (Q3)
G = fspecial('gaussian', 5, 2);

% Smoothing filter (Q4)
SmoothImgB = conv2(ImgB, G, 'same');

% display (Q5)
figure(5);
imagesc(SmoothImgB);
colormap gray
axis image
title("Filtered Image, Section B");

% downsampling (Q6)
DownImgB = ImgB(1:10:end, 1:10:end);

% display (Q7)
figure(6);
imagesc(DownImgB);
colormap gray
axis image
title("Downsampled Original Image, Section B");

% downsampling the filtered (Q8)
DownSmooth = SmoothImgB(1:10:end, 1:10:end);

% display (Q9)
figure(7);
imagesc(DownSmooth);
colormap gray
axis image
title("Downsampled Filtered Image, Section B");

%% Secition C
% load file (Q1)
load('Kiwi.mat');

% display
figure(8);
imagesc(Kiwi);
colormap gray
axis image
title("Original Image, Section C");

% Gaussian filter (Q2)
G2 = fspecial('gaussian', 3, 1);

% filtered image (Q3)
KiwiFilt = conv2(Kiwi, G2, 'same');

% display (Q4)
figure(9);
imagesc(KiwiFilt);
colormap gray
axis image
title("Filtered Image, Section C");

% unsharp masking (Q5)
alpha1 = 0.5;
alpha2 = 2;
I1 = Kiwi + alpha1.*(Kiwi - KiwiFilt);
I2 = Kiwi + alpha2.*(Kiwi - KiwiFilt);

% display (Q6)
figure(10);
imagesc(I1);
colormap gray
axis image
title("Unsharp Masking alpha=0.5, Section C");

figure(11);
imagesc(I2);
colormap gray
axis image
title("Unsharp Masking alpha=2, Section C");

% Original SNR (Q7)
oristd = std2(Kiwi(1:5, 1:5));
oriA = mean2(Kiwi(40:44, 60:64));
oriSNR = oriA/oristd;

% Gaussian SNR
gstd = std2(KiwiFilt(1:5, 1:5));
gA = mean2(KiwiFilt(40:44, 60:64));
gSNR = gA/gstd;

% alpha1 SNR
a1std = std2(I1(1:5, 1:5));
a1A = mean2(I1(40:44, 60:64));
a1SNR = a1A/a1std;

% alpha2 SNR
a2std = std2(I2(1:5, 1:5));
a2A = mean2(I2(40:44, 60:64));
a2SNR = a2A/a2std;

%% Section D
% load the image (Q1)
ImgD = imread('Texture(1).jpg');

% convert to gary scale
ImgD = mean(ImgD, 3);

% display
figure(12);
imagesc(ImgD);
colormap gray
axis image
title("Original Image, Section D");

% FFT (Q2)
FTImg = fftshift(fft2(ImgD));
FTMag = log10(abs(FTImg));

% display (Q3)
figure(13);
imagesc(FTMag);
colormap gray
axis image
title("Magnitude Spectrum, Section D");

% display Zoomed in (Q4)
figure(14);
imagesc(FTMag);
axis image
axis([611 810 366 565]);
colormap gray
title("Zoomed In Magnitude Spectrum, Section D");

% average filter (Q5)
FilterD = ones(1, 30);

% filter image
FiltImgD = conv2(ImgD, FilterD, 'same');

% display (Q6)
figure(15);
imagesc(FiltImgD);
colormap gray
axis image
title("Filtered Image, Section D");

% FFT for smoothed (Q7)
FTImg2 = fftshift(fft2(FiltImgD));
FTMag2 = log10(abs(FTImg2));

% display
figure(16);
imagesc(FTMag2);
colormap gray
axis image
title("Magnitude Spectrum, Section D");

% display Zoomed in
figure(17);
imagesc(FTMag2);
axis image
axis([611 810 366 565]);
colormap gray
title("Zoomed In Magnitude Spectrum, Section D");
