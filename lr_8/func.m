function result = func(x,y)
result = -20*exp(-sqrt(0.2*(x.^2 + y.^2))) - exp(0.5*(cos(2*pi*x) + cos(2*pi*y))) + 20 + exp(1);
end