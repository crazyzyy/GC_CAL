%omplex hilbert transform (without ingnoring the complex part) 
%revised for practical purpose. remove the constant base line signal;
%divided by 2
%x len*p*...
function [hx] = chilbert_cut(x,cutod)
y = ifft(x);
y(1) = 0;
y(cutod+1:end) = 0;
hx = fft(y);