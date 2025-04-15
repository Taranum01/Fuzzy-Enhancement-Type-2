close all; clear; clc;
tic;
%% Read image and Initialization 
input_image = imread('test1.jpg');
im_gray = rgb2gray(input_image);
im_gray_1 = im2double(im_gray);
Noise_density = 0.8; % amount of noise
im_noised = imnoise(im_gray_1, 'salt & pepper', Noise_density);
[p, q] = size(im_noised);
im_denoised = 0.63 * ones(p+20, q+20); % Padding for edges
im_denoised(10:p+9, 10:q+9) = im_noised; % Image at center

%% Algorithm
tic
im_denoised_pixels = zeros(p+20, q+20); % denoised image
im_noised_pixels = zeros(p+20, q+20); % mask showing location of SAP

for rIdx = 10:q+9 % To scan rows
    for cIdx = 10:p+9 % To scan col.
        M = 1;  % Window size
        N_init = 6; % initial number of good pixels
        S_max = 2; % upper bound of 'M'
        n_gp = N_init; % number of good pixels

        while (im_denoised(cIdx, rIdx) == 0) || (im_denoised(cIdx, rIdx) == 1)
            subImg = windowImg(im_denoised, cIdx, rIdx, M); % Vector containing pixel around possible currupted pixel
            [T_Threshold, ave_PI] = type2_MF(subImg);
            windowLen = length(subImg);
            idx = 1;
            GP = zeros(1, n_gp); % for storing good pixels
            for x = 1:windowLen
                if ave_PI(x) >= T_Threshold
                    GP(idx) = subImg(x);
                    idx = idx + 1;
                elseif (subImg(x) ~= 0) && (subImg(x) ~= 1)
                    GP(idx) = subImg(x);
                    idx = idx + 1;
                end
                if idx == n_gp + 1
                    break
                end
            end

            neta = length(find(GP)); % number of good pixels found

            if (neta < n_gp) && (M < S_max)
                M = M + 1;
                continue
            elseif (neta < n_gp) && (M == S_max)
                n_gp = n_gp - 1;
                if n_gp < 1
                    S_max = S_max + 1;
                    n_gp = 1;
                end
                continue
            end
            for k = 1:(length(GP)/2)
                mean(k) = kMiddleMean(k, GP);
            end
            mean_G = (sum(mean)) / length(GP);
            var_G = 2.5 * abs(GP - mean_G);
            var_G = max(var_G);
            if var_G <= .01
                var_G = .01;
            end
            w = gaussmf(GP, [var_G, mean_G]);
            W = sum(w);
            weighted_G = w * GP';
            im_denoised(cIdx, rIdx) = weighted_G / W;
            break
        end
    end
end

%% Plotting
figure;
subplot(1,3,1);
imshow(im_gray_1);
title('Input image');
subplot(1,3,2);
imshow(im_noised);
title('Input noisy image');
subplot(1,3,3);
im_denoised = im2uint8(im_denoised(10:p+9, 10:q+9)); % from [0,1] to [0,255]
imshow(im_denoised);
title('Filtered Image');
PSNR = 10 * log10((255 * 255) / ((1 / ((p-10) * (q-10))) * sum(sum((im_denoised(6:p-5, 6:q-5) - im_gray(6:p-5, 6:q-5)).^2))));
fprintf('\nPSNR: %d\n', PSNR);
toc

%% Helper Functions
function mean = kMiddleMean(k, windElem)
    Lenght_windElem = length(windElem);
    windElem = sort(windElem);
    if mod(Lenght_windElem, 2) == 1
        half_lengh = 0.5 * (Lenght_windElem + 1);
        factor = 1 / (2*k - 1);
        K_middle_vector = windElem((half_lengh - k + 1):(half_lengh + k - 1));
        sum_of_element = sum(K_middle_vector);
    else
        half_lengh = 0.5 * Lenght_windElem;
        factor = 1 / (2*k);
        K_middle_vector = windElem((half_lengh - k + 1):(half_lengh + k));
        sum_of_element = sum(K_middle_vector);
    end
    mean = factor * sum_of_element;
end

function [T_max, ave_PI] = type2_MF(winElem)
    p = numel(winElem);
    H = (p + 1) / 2;
    mu = zeros(1, H);
    for q = 1:H
        mu(1, q) = kMiddleMean(q, winElem);
    end
    average_mu = ((sum(mu)) / H) * ones(1, p);
    tmp = 1.5 * abs(winElem - average_mu).^2;
    mu_Mat = repmat(mu, p, 1)';
    tmp_vector = repmat(winElem, H, 1);
    sigma = kMiddleMean(H, tmp);
    if sigma < 0.0001
        sigma = 0.0001;
    end
    PI = exp(-0.5 * ((tmp_vector - mu_Mat) / sigma).^2);
    T_max = max(max(PI));
    ave_PI = sum(PI) / H;
end

function [windElem] = windowImg(image, i, j, M)
    x = (i - M):(i + M);
    y = (j - M):(j + M);
    neighborhood_length = (2*M + 1)^2;
    Window = image(x, y);
    windElem = reshape(Window, [1, neighborhood_length]);
end
