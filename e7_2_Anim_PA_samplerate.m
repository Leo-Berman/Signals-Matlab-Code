% file e7_2_Anim_PA_samplerate.m   
% plot various sample rates of cos(pi*t) vs. discrete frequency and period 
clear; close all; set(0,'defaultAxesFontSize',13);  
L = 4; incr = 0.1; % incr=0.1 means 10 points per sec.   L is # secs
n  = [0:incr:L]; x = cos(pi*n);       % "Continous time signal", period T = 2*pi/pi = 2, 10 sample/sec, 20 sample/cycle
n2 = [0:2*incr:L]; x2 = cos(pi*n2);   % sample rate T_s = 5 samples/sec = 10 samples/cyc, \Omega_0=2\pi/10= 0.2\pi 
n3 = [0:3*incr:L]; x3 = cos(pi*n3);   % sample rate T_s = 10/3,= 20/3 sample/cyc; W=0.3\pi
n4 = [0:4*incr:L]; x4 = cos(pi*n4);   % sample rate T_s = 2.5, 5 sample/cyc, W=2pi/5 = 0.4\pi 
n10= [0:10*incr:L]; x10= cos(pi*n10); % sample rate T_s = 1, 2 sample/cyc, W=2pi/2 = \pi
n10_= [0.5:10*incr:L]; x10_ = cos(pi*n10_); % sampled at aliasing locations, rate T_s = 1, 2 sample/cyc, W=2pi/2 = \pi
n15 = [0:15*incr:L]; x15 = cos(pi*n15); % (under)sample rate T_s = 1.5 s, 1.33 sample/cyc, W=2pi*1.5/2 = 1.5 \pi

n3_3 = [0:3*incr:1.5*L]; x3_3 = cos(pi*n3_3);  % 3 cycles of 0.3\pi sample rate T_s = 10/3 sample/s = 20/3 sample/cyc; W=0.3\pi
n_3 = [0:incr:1.5*L]; x_3 = cos(pi*n_3); x_32 = cos(pi*n_3/3);
n15_3 = [0:15*incr:1.5*L]; x15_3 = cos(pi*n15_3);  % 3 cycles of 1.33\pi sample rate 
n7 = [0:7*incr:4*L]; x7 = cos(pi*n7);   % sample rate T_s = 0.7, W= 0.7\pi 
n_8 = [0:incr:4*L]; x_8 = cos(pi*n_8);

figure('position',[600,750,600,240]), plot(n,x,'b','LineWidth',2),grid on, title('x(t) = cos(\pit)');
   
figure('position',[100,50,450,1000]),
 subplot(6,1,6), plot(n,x,'b'), hold on, stem(n2,x2,'r','LineWidth',2), hold off,
   title('10 sample/cyc, \Omega_0= 2\pi/10= 0.2\pi, N_0= 2\pi/\Omega_0= 10','FontWeight','normal'),
 subplot(6,1,5), plot(n,x,'b'), hold on, stem(n3,x3,'r','LineWidth',2), hold off,
   title('20/3 sample/cyc, \Omega_0= 2\pi*3/20= 0.3\pi, N_0= 2\pik/\Omega_0= 20','FontWeight','normal'),
 subplot(6,1,4), plot(n,x,'b'), hold on, stem(n4,x4,'r','LineWidth',2), hold off,
   title('5 sample/cyc, \Omega_0= 2\pi/5 = 0.4\pi, N_0= 2\pi/\Omega_0= 5','FontWeight','normal'),
 subplot(6,1,3), plot(n,x,'b'), hold on, stem(n10_,x10_,'r','LineWidth',2), hold off,
   title('2 sample/cyc, \Omega_0= 2\pi/2 =  \pi, N_0= 2\pi/\Omega_0= 2','FontWeight','normal'),
 subplot(6,1,2), plot(n,x,'b'), hold on, stem(n10,x10,'r','LineWidth',2), hold off,
   title('2 sample/cyc, \Omega_0= 2\pi/2 =  \pi, N_0= 2\pi/\Omega_0= 2','FontWeight','normal'),
 subplot(6,1,1), plot(n,x,'b'), hold on, stem(n15,x15,'r','LineWidth',2), hold off,
   title('4/3 sample/cyc, \Omega_0= 2\pi*1.5/2 = 1.5\pi','FontWeight','normal');
   
 figure('position',[600,250,680,140]), 
   plot(n_3,x_3,'b'), hold on, stem(n3_3,x3_3,'r','LineWidth',2), hold off,
   title('20/3 sample/cyc, \Omega_0= 2\pi*3/20= 0.3\pi, N_0= 2\pi k/\Omega_0= 20','FontWeight','normal') 
   
 figure('position',[600,550,680,140]), %plot aliased signal and equivalent cosine
   plot(n_3,x_3,'b'), hold on, stem(n15_3,x15_3,'r','LineWidth',2),
   plot(n_3,x_32,'m'), hold off,
   title('T_s=1.5 sec, \Omega_0= 2\pi*1.5/2 = 1.5\pi, aliases to x[n]=cos(0.5\pin), x_a(t)=cos(\pit/3)','FontWeight','normal')   
   
 figure('position',[600,750,680,140]), 
   plot(n_8,x_8,'b'), hold on, stem(n7,x7,'r','LineWidth',2), hold off,
   title('0.7 sample time, \Omega_0=  0.7\pi, N_0= 2\pi k/\Omega_0= 20','FontWeight','normal') 
   