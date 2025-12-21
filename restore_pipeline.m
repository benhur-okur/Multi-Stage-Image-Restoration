function restored = restore_pipeline(deg)
% Fixed pipeline for all images:
% Median -> Gaussian Smoothing -> Wiener Deconvolution -> Sharpen -> CLAHE

if ~isa(deg,'double')
    deg = im2double(deg);
end

% 1) Median
stage1 = medfilt2(deg, [3 3]);

% 2) Gaussian smoothing (stronger)
sigma = 1.5;
stage2 = imgaussfilt(stage1, sigma);

% 3) Wiener deconvolution
psf = fspecial('gaussian', 7, 1.6);
NSR = 0.12;
stage3 = deconvwnr(stage2, psf, NSR);

% 4) Sharpen (very soft)
stage4 = imsharpen(stage3, 'Radius', 0.7, 'Amount', 0.15);

% 5) Enhancement (PSNR-friendly)
restored = imadjust(stage4);


restored = min(max(restored, 0), 1);
end
