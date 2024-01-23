%% ESD2: Laboratory 1
% Parameters:

b = 60; % baseline [mm]
f = 7; % focal length [mm]
ps = .006; % focal length [mm]
xNumPix = 752; % total number of pixels in x direction of the sensor [px]
yNumPix = 480; % total number of pixels in y direction of the sensor [px]
cxLeft = xNumPix/2; % left camera x center [px]
cxRight = xNumPix/2; % right camera x center [px]

% extra param
cyLeft = yNumPix/2;
cyRight = yNumPix/2;

xLeft = 396; % What does this represent?
xRight = 356; % What does this represent?
%% 
% Depth equation with a single shift:

d = (abs((xLeft-cxLeft)-(xRight-cxRight))*ps); % disparity [mm]
Z = (b * f)/(d * 1000); % depth [m]
disp(['The depth is: ' num2str(Z) ' [m]'])
%% 
% Depth equation with shifts:

shift = 0:350;
xLeft = cxLeft + shift;
xRight = cxRight - shift;
d = (abs((xLeft-cxLeft)-(xRight-cxRight))*ps); % disparity [mm]
Z = (b * f)./(d * 1000); % depth [m]
disp(['The depth is: ' num2str(Z) ' [m]'])
plot(Z)
%% 
% Plot Depth with shifts vs Disparity:

Fig = figure('Position', get(0,"ScreenSize"));
plot(shift,Z);
xlabel("disparity [pixels]");
ylabel("depth [m]");
xlim([0 300]);
title("Depth with shifts vs Disparity");
saveas(Fig, append('depth_vs_disparity.png'));
%% 
% Subplots

Fig = figure('Position', get(0,"ScreenSize"));
subplot(2,2,[1,2]);
plot(shift,Z);

shift = 30; % fixed pixel shift
xLeft = cxLeft + shift;
xRight = cxRight - shift;
d = (abs((xLeft-cxLeft)-(xRight-cxRight))*ps); % disparity [mm]
Z = (b * f)./(d * 1000); % depth [m]

hold on
plot(shift, Z, 'x')
xlabel("disparity [pixels]");
ylabel("depth [m]");
xlim([0 300]);
title("Depth with shifts vs Disparity");

subplot (2,2,3)
scatter(xLeft, cyLeft)
hold on
xline(cxLeft)
yline(cyLeft)
xlim([0 xNumPix])
ylim([0 yNumPix])
title('Left Camera')

subplot (2,2,4)
scatter(xRight, cyRight)
hold on
xline(cxRight)
yline(cyRight)
xlim([0 xNumPix])
ylim([0 yNumPix])
title('Right Camera')

saveas(Fig, append('depth_vs_disparity_subplots.png'));