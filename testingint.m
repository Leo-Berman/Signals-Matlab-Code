syms w
eq1 = 2*sin(w)/w;
freq = linspace(1,1000,1000);
eq1 = double(subs(eq1,w,freq));
myFFT(eq1,1000)