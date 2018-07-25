%% Draw Zeros, Poles on Complex Plane and Draw Spectrum %%
% Author: Linus Cheng, https://github.com/LinusCheng
% This function generate:
% (1) The positions of the zeros and poles on the complex plane.
% (2) The warping effect of the zeros, poles in 3D diagram. 
% (3) The spectrum, which is the unit circle on the complex plane.
% Variables:
% a: the poles
% b: the zeros
clc;clear all;close all;

%% First Part: Z-transform
X = linspace(-2,2,100);
Y = linspace(-2,2,100);
[X,Y] = meshgrid(X,Y);
Z =X+Y*1j;

% Enter zeros and poles here
a = [0.5,-0.9,-0.3+0.45j,-0.3-0.45j];
b = [0.2, -0.6];
% a = [0.1,0.4,0.6,0.8];
% b=[0];

F =1;
for k = 1:length(a)
   F =F./(1-a(k)./Z);   
end

for k = 1:length(b)
   F =F.*((1-b(k)./Z));  
end

FF = abs(F);

%%
% Draw Spectrum |Z|=1, DTFT

p = length(a);
q = length(b);
w = linspace(0,pi,1000);

H =1;
for k = 1:p
   H = H./(   1-a(k).*exp(-1j.*w)         );
end

for k = 1:q
   H = H.*(   1-b(k).*exp(-1j.*w)         );
end

%% Plot in one window %%

% 1 Plot the zeros & poles
figure(5)
subplot(2,2,1);
title('(1) Poles & Zeros on Z-Complex Plane')
ax =real(a);
ay =imag(a);
scatter(ax,ay,'x')
xlim([-2 2])
ylim([-2 2])
axis equal

hold on

bx =real(b);
by =imag(b);
scatter(bx,by,'o')

w2 = linspace(0,2*pi,100);
cx = cos(w2);
cy = sin(w2);
plot(cx,cy,'black')

n = linspace(-2,2,10);
nline = zeros(1,10);

plot(n,nline,'black')
plot(nline,n,'black')

hold off

% 2 Plot the transfor function in imagesc
subplot(2,2,2);
title('(2) Magnitude of Z on Z-Complex Plane')
imagesc(FF)
axis equal
colorbar

% 3 Plot the transfor function in surf
subplot(2,2,3);
title('(3) Magnitude of Z 3D')
surf(X,Y,FF)

% 4 Plotting Frequency
subplot(2,2,4);
title('(4) Magnitude of |Z|=1 (frequency)')
plot(w,abs(H))
xlabel('0~\pi')
axis([0, pi,-inf, inf]);


%%

fprintf('Completed\n')
