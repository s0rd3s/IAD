function f = hihi(n, x) 
f=(x.^(n/2 - 1)).*exp(-x/2)./(2^(n/2)*gamma(n/2));
