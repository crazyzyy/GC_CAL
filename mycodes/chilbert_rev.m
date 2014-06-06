%omplex hilbert transform (without ingnoring the complex part) 
%revised for practical purpose. remove the constant base line signal;
%divided by 2
%x len*p*...
function [hx] = chilbert_rev(x)
 x = x-mean(x);
 hx = 0.5*(conj(hilbert(real(x)))+1i*(conj(hilbert(imag(x)))));