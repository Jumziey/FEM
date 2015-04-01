function b = SourceAssembler1D(x,f,kappa,g)
b = LoadAssembler1D(x,f);
b(1) = b(1) + kappa(1)*g(1);
b(end) = b(end) + kappa(2)*g(2);
