function [mseVal, psnrVal, ssimVal] = metrics(ref, img)
% Computes MSE, PSNR, SSIM between reference (original) and target image

if ~isa(ref,'double'); ref = im2double(ref); end
if ~isa(img,'double'); img = im2double(img); end

mseVal  = immse(img, ref);
psnrVal = psnr(img, ref);
ssimVal = ssim(img, ref);
end
