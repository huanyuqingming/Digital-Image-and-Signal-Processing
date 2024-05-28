%% 1
image = imread('roman.jpg');
R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);

% 进行直方图均衡化
eq_R = histeq(R);

% 显示图像
figure;
subplot(1, 2, 1);
imshow(R);
title('原始红色通道图像');
subplot(1, 2, 2);
imshow(eq_R);
title('直方图均衡化后的红色通道图像');

%% 2
% 生成0-1之间的指数分布数据
exp = uint8(255 * -log(1-rand(size(R))));

% 生成-1-1的正态分布数据
e = 0; % 期望值
v = 1; % 标准差
gaussian = uint8(255 * (v * randn(size(R)) + e));

% 对 red_channel 进行直方图匹配
exp_R = imhistmatch(R, exp);
gaussian_R = imhistmatch(R, gaussian);

% 显示图像
figure;
subplot(1, 3, 1);
imshow(R);
title('原始红色通道图像');
subplot(1, 3, 2);
imshow(exp_R);
title('经指数分布直方图匹配后的红色通道图像');
subplot(1, 3, 3);
imshow(gaussian_R);
title('经高斯分布直方图匹配后的红色通道图像');

%% 3
% 对每个通道进行直方图均衡化
eq_R = histeq(R);
eq_G = histeq(G);
eq_B = histeq(B);

% 合并均衡化后的通道
eq_img = cat(3, eq_R, eq_G, eq_B);

% 显示图像
figure;
subplot(1, 2, 1);
imshow(image);
title('原始图像');
subplot(1, 2, 2);
imshow(eq_img);
title('直方图均衡化后的图像');

%% 4
% 转换到HSV空间
hsv = rgb2hsv(image);

% 对亮度V进行直方图均衡化
hsv(:,:,3) = histeq(hsv(:,:,3));

% 转换回RGB空间
eq_img = hsv2rgb(hsv);

% 显示图像
figure;
subplot(1, 2, 1);
imshow(image);
title('原始图像');
subplot(1, 2, 2);
imshow(eq_img);
title('在HSV空间直方图均衡化后的图像');