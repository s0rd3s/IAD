function f = beta(q, x)
a = q(1);
b = q(2);
B = gamma(a)*gamma(b)/gamma(a+b);
f = (x.^(a-1)).*(1-x).^(b-1)/B;