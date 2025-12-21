clear; clc; close all;

imgNames = ["baboon","barbara","boat","cameraman","peppers"];

results = table('Size',[numel(imgNames) 7], ...
    'VariableTypes',["string","double","double","double","double","double","double"], ...
    'VariableNames',["Image","MSE_deg","PSNR_deg","SSIM_deg","MSE_res","PSNR_res","SSIM_res"]);

for i = 1:numel(imgNames)
    name = imgNames(i);

    orig = imread("images/original_" + name + ".png");
    deg  = imread("images/degraded_" + name + ".png");

    if size(orig,3)==3; orig = rgb2gray(orig); end
    if size(deg,3)==3;  deg  = rgb2gray(deg);  end

    restored = restore_pipeline(deg);

    [mseD, psnrD, ssimD] = metrics(orig, deg);
    [mseR, psnrR, ssimR] = metrics(orig, restored);

    results(i,:) = {name,mseD,psnrD,ssimD,mseR,psnrR,ssimR};

    imwrite(restored,"results/restored_" + name + ".png");

    figure('Name',name);
    montage({orig,deg,restored},'Size',[1 3]);
    title(name + " | Original - Degraded - Restored");
end

disp(results);
writetable(results,"results/metrics_table.csv");
