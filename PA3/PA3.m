%% 计算运行时间
profile clear;

N = 2;
power = 4;
l = [];
t1 = [];
t2 = [];
t3 = [];
t4 = [];

for i = 1:7
    N = 2 ^ power;
    x = rand(1, N);
    l(end+1) = power;
    if i <= 3   % 避免内存爆炸
        t1(end+1) = calculate_by_definition(x);
        t2(end+1) = calculate_by_matrix(x);  % 本地用这行
    end
    % if i <= 4   % 避免内存爆炸 虚拟机用这行
    %     t2(end+1) = calculate_by_matrix(x);
    % end
    t3(end+1) = calculate_by_fft(x);
    t4(end+1) = calculate_by_fft_in_GPU(x);
    disp(l);
    disp(t1);
    disp(t2);
    disp(t3);
    disp(t4);
    power = power + 4;
end

%% 绘图
figure;
plot(l(1:3), t1);
hold on;
plot(l(1:3), t2);
hold on;
plot(l, t3);
hold on;
plot(l, t4);
legend('直接计算', '矩阵计算', 'fft', 'fft+GPU');
title('四种方法计算 DFT 的运行时间对比图');
xlabel('序列长度(2^n)');
ylabel('运行时间');

%% 函数定义
% 直接计算
function t = calculate_by_definition(x)
    profile on;
    
        N = length(x);
        X = zeros(1, N);
        WN = exp(-1i*2*pi/N);
        for k = 0:N-1
            for n = 0:N-1
                X(k+1) = X(k+1) + x(n+1) * WN ^ (k * n);
            end
        end
    
    profile off;
    % 计时
    p = profile("info");
    t = 0;
    for i = 1:length(p.FunctionTable)
      t = t + p.FunctionTable(i).TotalTime;
    end
    profile clear;
end

% 矩阵计算
function t = calculate_by_matrix(x)
    profile on;
   
        P = exp(-1i * 2 * pi / length(x) * (0:length(x)-1).' * (0:length(x)-1));
        X = x * P;
    
    profile off;
    % 计时
    p = profile("info");
    t = 0;
    for i = 1:length(p.FunctionTable)
      t = t + p.FunctionTable(i).TotalTime;
    end
    profile clear;
end

% fft计算
function t = calculate_by_fft(x)
    profile on;
    
        X = fft(x);
    
    profile off;
    % 计时
    p = profile("info");
    t = 0;
    for i = 1:length(p.FunctionTable)
      t = t + p.FunctionTable(i).TotalTime;
    end
    profile clear;
end

% fft在GPU中计算
function t = calculate_by_fft_in_GPU(x)
    x_GPU = gpuArray(x);
    profile on;

        X = fft(x_GPU);

    profile off;
    % 计时
    p = profile("info");
    t = 0;
    for i = 1:length(p.FunctionTable)
      t = t + p.FunctionTable(i).TotalTime;
    end
    profile clear;
end
