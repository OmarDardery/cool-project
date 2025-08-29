[y, fs] = audioread("The Subway.mp3");
% Play the audio file
% Parameters for the Gaussian function
a = 10;          % Amplitude
b = 1;          % Mean
c = 50;          % Standard deviation

% Generate an array of x values
x_smooth = linspace(-500, 500, round(0.001 * fs));
x_sharpen = linspace(-500, 500, round(0.07 * fs));
mid = ceil(length(x_sharpen)/2);

% Calculate the Gaussian values
z = a * exp(-((x - b).^2) / (2 * (c)^2));
z = z / sum(z);

z_low_smoothing = a * exp(-((x_smooth - b).^2) / (2 * (c * 1.5)^2));
z_low_smoothing = z_low_smoothing / sum(z_low_smoothing);

z_high_smoothing = a * exp(-((x_smooth - b).^2) / (2 * (c * 5)^2));
z_high_smoothing = z_high_smoothing / sum(z_high_smoothing);

z_low_sharpening = ones(1, length(x_sharpen)) * -0.01;
z_low_sharpening(mid) = 1;

z_high_sharpening = ones(1, length(x_sharpen)) * -0.03;
z_high_sharpening(mid) = 1;

% Plot the Gaussian curve
figure;
subplot(3, 2, 1);
plot(x, z);
title('Gaussian Curve');
xlabel('t');
ylabel('Gaussian Value');
grid on;

subplot(3, 2, 3);
plot(x_smooth, z_low_smoothing);
title('Gaussian Curve, low smoothing');
xlabel('t');
ylabel('Gaussian Value');
grid on;

subplot(3, 2, 4);
plot(x_smooth, z_high_smoothing);
title('Gaussian Curve, high smoothing');
xlabel('t');
ylabel('Gaussian Value');
grid on;

subplot(3, 2, 5);
plot(x_sharpen, z_low_sharpening);
title('low sharpening');
xlabel('t');
grid on;


subplot(3, 2, 6);
plot(x_sharpen, z_high_sharpening);
title('high sharpening');
xlabel('t');
grid on;

left = y(:, 1);
right = y(:, 2);

left_low_sharpening = conv(left, z_low_sharpening);
right_low_sharpening = conv(right, z_low_sharpening);
y_low_sharpening = [left_low_sharpening, right_low_sharpening];

left_low_smoothing = conv(left, z_low_smoothing);
right_low_smoothing = conv(right, z_low_smoothing);
y_low_smoothing = [left_low_smoothing, right_low_smoothing];

left_high_sharpening = conv(left, z_high_sharpening);
right_high_sharpening = conv(right, z_high_sharpening);
y_high_sharpening = [left_high_sharpening, right_high_sharpening];

left_high_smoothing = conv(left, z_high_smoothing);
right_high_smoothing = conv(right, z_high_smoothing);
y_high_smoothing = [left_high_smoothing, right_high_smoothing];

player_low_smoothing = audioplayer(y_low_smoothing, fs);
player_high_smoothing = audioplayer(y_high_smoothing, fs);
player_low_sharpening = audioplayer(y_low_sharpening, fs);
player_high_sharpening = audioplayer(y_high_sharpening, fs);
player_original = audioplayer(y, fs);



audiowrite("the subway low smoothing.mp3", y_low_smoothing, fs);
audiowrite("the subway high smoothing.mp3", y_high_smoothing, fs);
% Save the edge-detected audio files
audiowrite("the subway low sharpening.mp3", y_low_sharpening, fs);
audiowrite("the subway high sharpening.mp3", y_high_sharpening, fs);


play = false;
if(play)
    disp("original audio");
    
    play(player_original);
    pause(20);
    stop(player_original);
    pause(10);
    
    disp("low smoothing");
    
    play(player_low_smoothing);
    pause(20);
    stop(player_low_smoothing);
    pause(10);
    
    disp("high smoothing");
    
    play(player_high_smoothing);
    pause(20);
    stop(player_high_smoothing);
    pause(10);
    
    disp("low sharpening");
    
    play(player_low_sharpening);
    pause(20);
    stop(player_low_sharpening);
    pause(10);
    
    disp("high sharpening");
    
    play(player_high_sharpening);
    pause(20);
    stop(player_high_sharpening);
    pause(10);
end
