function gauss = my_gauss_gen(N, m, D)
gauss = m + randn(N, 1)*sqrt(D);