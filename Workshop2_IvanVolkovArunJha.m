% Medical Imaging
% Workshop 2
% Ivan Volkov 988146 and Arun Jha 997110
% 07/04/22

%% Section A
% Q1: Create a pixel image
SquareImg = zeros(100);
SquareImg(40:50, 76:86) = 1;

% Q2: plot
figure(1);
imagesc(SquareImg);
colormap gray
axis image
axis off
title('Original Square Image');

% Q3: projection angles
theta = 0:1:179;

% Q4: create a sinogram
[R_square, xp_square] = radon(SquareImg, theta);
figure(2);
imagesc(xp_square, theta, R_square');
xlabel('Parallel sensor position, r (pixels)');
ylabel('Prallel rotation angle, \theta (degrees)');
colormap gray
axis image
title('Sinogram of Square Image');

% Q5: image reconstruction
output_size = max(size(SquareImg));
Img_est_square = iradon(R_square, theta, output_size);
figure(3);
imagesc(Img_est_square);
colormap gray
axis image
axis off
title('Reconstruction of Square Image, default filter');

% Q6: image reconstruction 2
Img_est_square2 = iradon(R_square, theta, 'linear', 'none', output_size);
figure(4);
imagesc(Img_est_square2);
colormap gray
axis image
axis off
title('Reconstruction of Square Image, no Ram-Lak filter');

% Q7: phantom creation
PhantomImg = phantom(256);
figure(5);
imagesc(PhantomImg);
colormap gray
axis image
axis off
title('Original Phantom Image');

% phantom sinogram
[R_square_phantom, xp_square_phantom] = radon(PhantomImg, theta);
figure(6);
imagesc(xp_square_phantom, theta, R_square_phantom');
xlabel('Parallel sensor position, r (pixels)');
ylabel('Prallel rotation angle, \theta (degrees)');
colormap gray
axis image
title('Sinogram of Phantom Image');

% phantom image reconstruction
output_size_phantom = max(size(PhantomImg));
Img_est_square_phantom = iradon(R_square_phantom, theta, output_size_phantom);
figure(7);
imagesc(Img_est_square_phantom);
colormap gray
axis image
axis off
title('Reconstruction of Phantom Image');

% Q8: investigation of projection angles
theta_new = 0:5:179;

% phantom sinogram
[R_square_phantom, xp_square_phantom] = radon(PhantomImg, theta_new);
figure(8);
imagesc(xp_square_phantom, theta_new, R_square_phantom');
xlabel('Parallel sensor position, r (pixels)');
ylabel('Prallel rotation angle, \theta (degrees)');
colormap gray
axis image
title('Sinogram of Phantom Image with larger angle step');

% phantom image reconstruction
output_size_phantom = max(size(PhantomImg));
Img_est_square_phantom = iradon(R_square_phantom, theta_new, output_size_phantom);
figure(9);
imagesc(Img_est_square_phantom);
colormap gray
axis image
axis off
title('Reconstruction of Phantom Image with larger angle step');
%% Section B
% Q1: fan beam on phantom
D = 190;
[R_phantom_fan, sensors_fan, theta_fan] = fanbeam(PhantomImg, D);
figure(8);
imagesc(sensors_fan, theta_fan, R_phantom_fan');
xlabel('Fanbeam Sensor Position r (pixels)');
ylabel('Fanbeam rotation Angle, \theta (degrees)');
colormap gray
axis image
% axis off
title('Sinogram of Phantom Image, Fan Beam');

% Q2: image reconstruction
[Img_est_phantom_fan, H_default] = ifanbeam(R_phantom_fan, D, 'OutputSize', output_size_phantom);
figure(9);
imagesc(Img_est_phantom_fan);
colormap gray
axis image
axis off
title('Reconstruction of Phantom Image, Fan Beam');

% Q3: increase spacing to 2 degrees
[R_phantom_fan2, sensors_fan2, theta_fan2] = fanbeam(PhantomImg, D, 'FanSensorSpacing', 2);
figure(10);
imagesc(sensors_fan2, theta_fan2, R_phantom_fan2');
xlabel('Fanbeam Sensor Position r (pixels)');
ylabel('Fanbeam rotation Angle, \theta (degrees)');
colormap gray
axis image
% axis off
title('Sinogram of Phantom Image, 2 Degree Fan Sensor Spacing');

% image reconstruction
Img_est_phantom_fan2 = ifanbeam(R_phantom_fan2, D, 'OutputSize', output_size_phantom, 'FanSensorSpacing', 2);
figure(11);
imagesc(Img_est_phantom_fan2);
colormap gray
axis image
axis off
title('Reconstruction of Phantom Image, 2 Degree Fan Sensor Spacing');

% decrease spacing to .25 degrees
[R_phantom_fan3, sensors_fan3, theta_fan3] = fanbeam(PhantomImg, D, 'FanSensorSpacing', .25);
figure(12);
imagesc(sensors_fan3, theta_fan3, R_phantom_fan3');
xlabel('Fanbeam Sensor Position r (pixels)');
ylabel('Fanbeam rotation Angle, \theta (degrees)');
colormap gray
axis image
% axis off
title('Sinogram of Phantom Image, .25 Degree Fan Sensor Spacing');

% image reconstruction
Img_est_phantom_fan3 = ifanbeam(R_phantom_fan3, D, 'OutputSize', output_size_phantom, 'FanSensorSpacing', 0.25);
figure(13);
imagesc(Img_est_phantom_fan3);
colormap gray
axis image
axis off
title('Reconstruction of Phantom Image, .25 Degree Fan Sensor Spacing');

% Q4: increase the fan projection angle to 5 degrees
[R_phantom_fan4, sensors_fan4, theta_fan4] = fanbeam(PhantomImg, D, 'FanRotationIncrement', 5);
figure(14);
imagesc(sensors_fan4, theta_fan4, R_phantom_fan4');
xlabel('Fanbeam Sensor Position r (pixels)');
ylabel('Fanbeam rotation Angle, \theta (degrees)');
colormap gray
axis image
% axis off
title('Sinogram of Phantom Image, 5 Degree Fan Projection Angle');

% image reconstruction
Img_est_phantom_fan4 = ifanbeam(R_phantom_fan4, D, 'OutputSize', output_size_phantom, 'FanRotationIncrement', 5);
figure(15);
imagesc(Img_est_phantom_fan4);
colormap gray
axis image
axis off
title('Reconstruction of Phantom Image, 5 Degree Fan Projection Angle');

% Q5: filter change
% image reconstruction
[Img_est_phantom_fan, H_hamming] = ifanbeam(R_phantom_fan, D, 'OutputSize', output_size_phantom, 'Filter', 'Hamming');
figure(16);
imagesc(Img_est_phantom_fan);
colormap gray
axis image
axis off
title('Reconstruction of Phantom Image, Hamming Filter');

% Q6: plot freq responses
figure(17);
plot(-512:1:511, fftshift(H_default));
hold on
plot(-512:1:511, fftshift(H_hamming));
hold off
xlabel('Frequency (Hz)');
legend('Ram-Lak', 'Hamming');
title('Filter Frequency Response');

%% Section C
% Q1: projection angles 
theta2 = 0:1:90;

% sinogram
[R1, xp1] = radon(SquareImg, theta2);
figure(18);
imagesc(xp1, theta2, R1');
xlabel('Parallel sensor position, r (pixels)');
ylabel('Prallel rotation angle, \theta (degrees)');
colormap gray
axis image

% Q2: move the square
SquareImg2 = zeros(100);
SquareImg2(41:51, 75:85) = 1;
theta3 = 91:1:179;

% sinogram
[R2, xp2] = radon(SquareImg2, theta3);
figure(19);
imagesc(xp2, theta3, R2');
xlabel('Parallel sensor position, r (pixels)');
ylabel('Prallel rotation angle, \theta (degrees)');
colormap gray
axis image

% Q3: combined sinograms
R_combined = [R1 R2];
figure(20);
imagesc(xp1, 0:1:179, R_combined');
xlabel('Parallel sensor position, r (pixels)');
ylabel('Prallel rotation angle, \theta (degrees)');
colormap gray
axis image
title('Sinogram of Moving Square Image');

% Q4: image reconstruction
Img_est_C = iradon(R_combined, theta, output_size);
figure(21);
imagesc(Img_est_C);
colormap gray
axis image
axis off
title('Reconstruction of Moving Square Image');

%% Section D
% Q1: Noisy sinogram
NoiseSquareImg = poissrnd(SquareImg);
[R_noisysquare, xp_square] = radon(NoiseSquareImg, theta);
figure(22);
imagesc(xp_square, theta, R_noisysquare');
xlabel('Parallel sensor position, r (pixels)');
ylabel('Prallel rotation angle, \theta (degrees)');
colormap gray
axis image
title('Sinogram of Noisy Square Image');

% Q2&3: image reconstruction
Img_est_noisysquare = iradon(R_noisysquare, theta, output_size);
figure(23);
imagesc(log10(Img_est_noisysquare-min(Img_est_noisysquare(:))));
colormap gray
axis image
axis off
title('Reconstruction of Noisy Square Image');

%% Section E
% Q1: read the image
im = imread('MicroCTExample.bmp');
im = double(im(:, :, 1));
figure(24);
imagesc(im);
axis equal
axis tight
title('Original Image');

% Q2: filter
filter = fspecial('gaussian', [3 3], 1.2);
im_filt = imfilter(im, filter);
figure(25);
imagesc(im_filt);
axis equal
axis tight
title('Filtered Image');

% Q3: histogram
im_array = reshape(im_filt, 1, []);
figure(26);
histogram(im_array, 20);
title('Filtered Image Histogram');

% Q4: thresholding
Thr = 55;
index = find(im_filt > Thr);
im_bw = zeros(size(im_filt));
im_bw(index) = 1;
figure(27);
imagesc(im_bw);
axis equal
axis tight
title('Thresholded Image');

% Q5: masking
filter2 = fspecial('gaussian', [18 18], 5); 
im_filt2 = imfilter(im, filter2);
index2 = find(im_filt2 > Thr);
mask = zeros(size(im_filt2));
mask(index2) = 1;
figure(28);
imagesc(mask);
axis equal
axis tight
title('Mask');

% Q6: mask visualisation
im_mask_pict = im_filt + 255*mask;
figure(29);
imagesc(im_mask_pict, [0 255]);
axis equal
axis tight
title('Filtered + Mask');

im_mask_pict = im_bw + 2*mask;
figure(30);
imagesc(im_mask_pict, [0 2]);
axis equal
axis tight
title('Segmented + Mask');

% Q7: apply mask to an image
im_bw_mask = mask.*im_bw;
figure(31);
imagesc(im_bw_mask);
axis equal
axis tight
title('Masked image');

% Q8: porosity
bone_pix = sum(im_bw_mask(:));
mask_pix = sum(mask(:));
porosity = 100*(1 - bone_pix/mask_pix);
disp(['Porosity: ', num2str(porosity), '%']);
