

filename = '滤光片测试数据.xlsx';  

data = xlsread(filename);


x = data(:, 1);          
y1 = data(:, 2);       
y2 = data(:, 3);        
y3 = data(:, 4);         
y4 = data(:, 5);        

% 创建更密集的横坐标点（用于平滑曲线）
x_smooth = linspace(min(x), max(x), 300);  % 生成300个均匀分布的点

% 方法1：使用pchip插值（保形分段三次插值，推荐）
y1_smooth = pchip(x, y1, x_smooth);
y2_smooth = pchip(x, y2, x_smooth);
y3_smooth = pchip(x, y3, x_smooth);
y4_smooth = pchip(x, y4, x_smooth);

% 方法2：使用spline插值（样条插值，曲线更光滑但可能过冲）
% y1_smooth = spline(x, y1, x_smooth);
% y2_smooth = spline(x, y2, x_smooth);
% y3_smooth = spline(x, y3, x_smooth);
% y4_smooth = spline(x, y4, x_smooth);

% 方法3：使用移动平均平滑（适合噪声数据）
% window_size = 5;  % 滑动窗口大小
% y1_smooth = movmean(y1, window_size);
% y2_smooth = movmean(y2, window_size);
% y3_smooth = movmean(y3, window_size);
% y4_smooth = movmean(y4, window_size);
% x_smooth = x;  % 横坐标保持不变

figure;

% 绘制平滑曲线（不显示原始数据点）
plot(x_smooth, y1_smooth, '-r', 'LineWidth', 2); hold on;
plot(x_smooth, y2_smooth, '-g', 'LineWidth', 2);hold on;
plot(x_smooth, y3_smooth, '-b', 'LineWidth', 2);hold on;
plot(x_smooth, y4_smooth, '-m', 'LineWidth', 2);hold on;
plot(x, y1, 'ro', 'MarkerSize', 3, 'MarkerFaceColor', 'r');
plot(x, y2, 'gs', 'MarkerSize', 3, 'MarkerFaceColor', 'g');
plot(x, y3, 'bd', 'MarkerSize', 3, 'MarkerFaceColor', 'b');
plot(x, y4, 'm^', 'MarkerSize', 3, 'MarkerFaceColor', 'm');

% 自动计算范围（基于原始数据或平滑数据）
y_min = min([y1; y2; y3; y4]);
y_max = max([y1; y2; y3; y4]);
y_margin = (y_max - y_min) * 0.05;  % 添加5%的边界余量
ylim([y_min - y_margin, y_max + y_margin]);

% 手动指定范围（如需手动设置，取消下面注释并注释上面自动计算）
ylim([0, 100]);
legend('滤光片1', '滤光片2', '滤光片3', '滤光片4', 'Location', 'best');
xlabel('波长(nm)');
ylabel('透过率(T%)');
title('滤光片光谱曲线');
grid on;
hold off;