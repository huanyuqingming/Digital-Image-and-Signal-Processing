%% 1
x = [0.5 1 1 1 1 1 1 1 1 1 0.5];
X = fft(x, 1000);
X = fftshift(X);
f = linspace(-pi, pi, 1000);

figure;
subplot(1, 3, 1);
stem([0 1 2 3 4 5 6 7 8 9 10], x);
title('Original Signal');
xlabel('N');
ylabel('Amplitude');

subplot(1, 3, 2);
plot(f, abs(X));
title('Magnitude Spectrum');
xlabel('Frequency');
ylabel('Magnitude');

subplot(1, 3, 3);
plot(f, angle(X));
title('Phase Spectrum');
xlabel('Frequency');
ylabel('Phase');

%% 2
x1 = [0 1 1 1 1 1 1 1 1 1 1];
X1 = fft(x1, 1000);
X1 = fftshift(X1);
X1_copy = X1;
figure;
subplot(1, 3, 1);
stem([0 1 2 3 4 5 6 7 8 9 10], x1);
title('Original Signal');
xlabel('N');
ylabel('Amplitude');

subplot(1, 3, 2);
plot(f, abs(X1));
title('Magnitude Spectrum');
xlabel('Frequency');
ylabel('Magnitude');

subplot(1, 3, 3);
plot(f, angle(X1));
title('Phase Spectrum');
xlabel('Frequency');
ylabel('Phase');

%% 3
t = -5:0.01:15;
x1 = zeros(size(t));
x1((t > 0.5) & (t < 10.5)) = 1;
x1(t == 0.5) = 0.5;
x1(t == 10.5) = 0.5;

X1 = fft(x1, 1000);
X1 = fftshift(X1);

X1(1:450) = 0;
X1(551:1000) = 0; % 理想低通滤波，截止频率为(10*pi)Hz
x1 = abs(real(ifft(X1)));

y = x1(250:50:1000);
Y = fft(y, 1000);
Y = fftshift(Y);

figure;
subplot(1, 3, 1);
stem([0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15], y);
title('Original Signal');
xlabel('N');
ylabel('Amplitude');

subplot(1, 3, 2);
plot(f, abs(Y));
hold on;
plot(f, abs(X1_copy), "--");
legend('Y', '$X_1$', 'Interpreter', 'latex');
title('Magnitude Spectrum');
xlabel('Frequency');
ylabel('Magnitude');

subplot(1, 3, 3);
plot(f, angle(Y));
hold on;
plot(f, angle(X1_copy), "--");
legend('Y', '$X_1$', 'Interpreter', 'latex');
title('Phase Spectrum');
xlabel('Frequency');
ylabel('Phase');
