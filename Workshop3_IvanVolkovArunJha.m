% Medical Imaging
% Workshop 3
% Ivan Volkov 988146 and Arun Jha 997110
% 05/05/22

%% Section A
% Read data (Q2)
load MRI_SectionA_Data

% Mesh plot (Q4)
% Read only TE 
figure(1);
mesh(abs(MRI_SectionA_Data(:, :, 1)));

% Fourier reconstruction (Q6)
ReconImages = zeros(size(MRI_SectionA_Data));
for nn = 1:1:256
    ReconImages(:, :, nn) = fftshift(fft2(MRI_SectionA_Data(:, :, nn)));
end

% Magnitude images (Q7)
M = abs(ReconImages);
figure(2);
imagesc(M(:, :, 1));
colormap gray
axis image

% Region of Interest (Q8)
ROI1 = M(5:9, 9:13, :);
ROI2 = M(10:14, 23:27, :);
ROI3 = M(25:29, 21:25, :);
ROI4 = M(22:26, 6:10, :);

% Mean timeseries
ROI1_mean = zeros(1, 256);
ROI2_mean = zeros(1, 256);
ROI3_mean = zeros(1, 256);
ROI4_mean = zeros(1, 256);
for k = 1:1:256
    ROI1_mean(k) = mean2(ROI1(:, :, k));
    ROI2_mean(k) = mean2(ROI2(:, :, k));
    ROI3_mean(k) = mean2(ROI3(:, :, k));
    ROI4_mean(k) = mean2(ROI4(:, :, k));
end

% Time vector
tvec = 3.5e-3:3.5e-3:0.896;

% Plot
figure(3);
plot(tvec, ROI1_mean);
hold on
plot(tvec, ROI2_mean);
hold on
plot(tvec, ROI3_mean);
hold on
plot(tvec, ROI4_mean);
hold off
xlabel('Time (sec)');
ylabel('Arbitrary units (a.u.)');
legend('Vial 1', 'Vial 2', 'Vial 3', 'Vial 4');

% T2 and bulk magnetisation estimate (Q9)
T2map = zeros(32, 32);
M0map = zeros(32, 32);
for i = 1:1:32
    for j = 1:1:32
        datavec = squeeze(M(i, j, :));
        CurrentFit = fit(tvec', datavec, fittype('exp1'));
        M0map(i, j) = CurrentFit.a;
        T2map(i, j) = -1/CurrentFit.b;
    end
end

% display T2 (Q10)
figure(4);
imagesc(T2map);
set(gca, 'Clim', [0 0.5]);
colormap gray 
axis image
colorbar

% average T2 for each vial
Vial1 = mean2(T2map(5:9, 9:13));
Vial2 = mean2(T2map(10:14, 23:27));
Vial3 = mean2(T2map(25:29, 21:25));
Vial4 = mean2(T2map(22:26, 6:10));

%% Section B
% Load the data (Q1)
load MRI_SectionB_Data

% Plot (Q2)
figure(5);
plot(0:3:53*3, X);
xlabel("Time (sec)");

% Activation weights estimate (Q3)
y = zeros(128, 128);
beta = zeros(128, 128);
for i = 1:1:128
    for j = 1:1:128
        y = squeeze(LabData(i, j, :));
        beta(i, j) = (X'*X)^-1*X'*y;
    end
end

% display (Q5)
figure(6);
imagesc(beta.*MaskBrain);
axis image
colormap gray
colorbar
