%% 1
filename = '半醒';
% [audio, Fs] = audioread([filename, '.mp3']);
% audio = mean(audio, 2);
% audiowrite([filename, '.wav'], audio, Fs);
[audio, Fs] = audioread([filename, '.wav']);

% 绘图
figure;
subplot(1, 2, 1);
plot((1:length(audio))/Fs, audio);
title('源文件时域波形图');
xlabel('时间 (s)');
ylabel('幅度');

subplot(1, 2, 2);
window = hamming(1024);
noverlap = 512;
nfft = 1024;
spectrogram(audio, window, noverlap, nfft, Fs, 'yaxis');
title('源文件STFT时频图');

%% 2
% 下采样
resampled_audio_5 = resample(audio, 5e3, Fs);
resampled_audio_10 = resample(audio, 10e3, Fs);
resampled_audio_15 = resample(audio, 15e3, Fs);

% 导出音频
normalized_audio = resampled_audio_5 / max(abs(resampled_audio_5)); % 归一化，防止失真
audiowrite([filename, '+5kHz下采样.wav'], normalized_audio, 5e3);
normalized_audio = resampled_audio_10 / max(abs(resampled_audio_10)); % 归一化，防止失真
audiowrite([filename, '+10kHz下采样.wav'], normalized_audio, 10e3);
normalized_audio = resampled_audio_15 / max(abs(resampled_audio_15)); % 归一化，防止失真
audiowrite([filename, '+15kHz下采样.wav'], normalized_audio, 15e3);

% 绘图
figure;
subplot(2, 3, 1);
plot((1:length(resampled_audio_5))/5e3, resampled_audio_5);
title('5kHz下采样时域波形图');
xlabel('时间 (s)');
ylabel('幅度');

subplot(2, 3, 4);
window = hamming(1024);
noverlap = 512;
nfft = 1024;
spectrogram(resampled_audio_5, window, noverlap, nfft, 5e3, 'yaxis');
title('5kHz下采样STFT时频图');

subplot(2, 3, 2);
plot((1:length(resampled_audio_10))/10e3, resampled_audio_10);
title('10kHz下采样时域波形图');
xlabel('时间 (s)');
ylabel('幅度');

subplot(2, 3, 5);
window = hamming(1024);
noverlap = 512;
nfft = 1024;
spectrogram(resampled_audio_10, window, noverlap, nfft, 10e3, 'yaxis');
title('10kHz下采样STFT时频图');

subplot(2, 3, 3);
plot((1:length(resampled_audio_15))/15e3, resampled_audio_15);
title('15kHz下采样时域波形图');
xlabel('时间 (s)');
ylabel('幅度');

subplot(2, 3, 6);
window = hamming(1024);
noverlap = 512;
nfft = 1024;
spectrogram(resampled_audio_15, window, noverlap, nfft, 15e3, 'yaxis');
title('15kHz下采样STFT时频图');

%% 3
% 插值恢复
interpolated_audio_5 = resample(resampled_audio_5, Fs, 5e3);
interpolated_audio_10 = resample(resampled_audio_10, Fs, 10e3);
interpolated_audio_15 = resample(resampled_audio_15, Fs, 15e3);

% 导出音频
normalized_audio = interpolated_audio_5 / max(abs(interpolated_audio_5)); % 归一化，防止失真
audiowrite([filename, '+5kHz下采样插值.wav'], normalized_audio, Fs);
normalized_audio = interpolated_audio_10 / max(abs(interpolated_audio_10)); % 归一化，防止失真
audiowrite([filename, '+10kHz下采样插值恢复.wav'], normalized_audio, Fs);
normalized_audio = interpolated_audio_15 / max(abs(interpolated_audio_15)); % 归一化，防止失真
audiowrite([filename, '+15kHz下采样插值恢复.wav'], normalized_audio, Fs);

% 绘图
figure;
subplot(3, 3, 1);
plot((1:length(interpolated_audio_5))/Fs, interpolated_audio_5);
title('5kHz插值时域波形图');
xlabel('时间 (s)');
ylabel('幅度');

subplot(3, 3, 4);
window = hamming(1024);
noverlap = 512;
nfft = 1024;
spectrogram(interpolated_audio_5, window, noverlap, nfft, Fs, 'yaxis');
title('5kHz插值STFT时频图');

subplot(3, 3, 2);
plot((1:length(interpolated_audio_10))/Fs, interpolated_audio_10);
title('10kHz插值时域波形图');
xlabel('时间 (s)');
ylabel('幅度');

subplot(3, 3, 5);
window = hamming(1024);
noverlap = 512;
nfft = 1024;
spectrogram(interpolated_audio_10, window, noverlap, nfft, Fs, 'yaxis');
title('10kHz插值STFT时频图');

subplot(3, 3, 3);
plot((1:length(interpolated_audio_15))/Fs, interpolated_audio_15);
title('15kHz插值时域波形图');
xlabel('时间 (s)');
ylabel('幅度');

subplot(3, 3, 6);
window = hamming(1024);
noverlap = 512;
nfft = 1024;
spectrogram(interpolated_audio_15, window, noverlap, nfft, Fs, 'yaxis');
title('15kHz插值STFT时频图');

% 绘制对比图
subplot(3, 3, 7);
plot((1:length(audio))/Fs, audio);
hold on;
plot((1:length(interpolated_audio_5))/Fs, interpolated_audio_5);
legend('源文件', '5kHz插值');
title('5kHz插值与源文件时域波形对比图');
xlabel('时间 (s)');
ylabel('幅度');

subplot(3, 3, 8);
plot((1:length(audio))/Fs, audio);
hold on;
plot((1:length(interpolated_audio_10))/Fs, interpolated_audio_10);
legend('源文件', '10kHz插值');
title('10kHz插值与源文件时域波形对比图');
xlabel('时间 (s)');

subplot(3, 3, 9);
plot((1:length(audio))/Fs, audio);
hold on;
plot((1:length(interpolated_audio_15))/Fs, interpolated_audio_15);
legend('源文件', '15kHz插值');
title('15kHz插值与源文件时域波形对比图');
xlabel('时间 (s)');

%% 4
% 定义窗口参数
win = hamming(128);
overlap = length(win)/2;
nfft = length(win);

% 进行STFT
[S, f, t] = stft(audio, Fs, "Window",win, "OverlapLength",overlap, "FFTLength",nfft);

% 增强人声、削弱乐器
S((f > 5e2) & (f < 8e3), :) = S((f > 5e2) & (f < 8e3), :) * 100;
S((f > 0) & (f < 5e2), :) = S((f > 0) & (f < 5e2), :) * 0.01;
S((f > 8e3) & (f < 24e3), :) = S((f > 8e3) & (f < 24e3), :) * 0.01;

% 进行逆STFT
audio_mod = istft(S, Fs, "OverlapLength",overlap, "FFTLength",nfft);
audio_mod = real(audio_mod);    % 去除虚数部分
normalized_audio = audio_mod / max(abs(audio_mod)); % 归一化，防止失真

% 导出音频
audiowrite([filename, '+清晰人声.wav'], normalized_audio, Fs);
