function w = weibull(q, x)
a = q(1);
b = q(2);
w =(a*b*x.^(b-1)).*exp(-a*x.^b);