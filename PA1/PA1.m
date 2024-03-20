% Programming Assignment 1
img0 = imread("baboon.bmp");
img0 = rgb2gray(img0);
img0 = im2double(img0);

% Q1
PSF = ones(5, 5);
PSF = 0.04 * PSF;
img1 = conv2(img0, PSF);
imwrite(img1, 'PA1_1.bmp');

% Q2
img2_1 = awgn(img1, 1000, "measured");
img2_2 = awgn(img1, 100, "measured");
img2_3 = awgn(img1, 10, "measured");
imwrite(img2_1, 'PA1_2_30dB.bmp');
imwrite(img2_2, 'PA1_2_20dB.bmp');
imwrite(img2_3, 'PA1_2_10dB.bmp');

% Q3
img3_1 = deconvwnr(img1, PSF, 0);
img3_2 = deconvwnr(img2_1, PSF, 0.001);
img3_3 = deconvwnr(img2_2, PSF, 0.01);
img3_4 = deconvwnr(img2_3, PSF, 0.1);
imwrite(img3_1, 'PA1_3_psf.bmp');
imwrite(img3_2, 'PA1_3_30dB.bmp');
imwrite(img3_3, 'PA1_3_20dB.bmp');
imwrite(img3_4, 'PA1_3_10dB.bmp');
