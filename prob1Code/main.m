clear all; clc;
load adjMat;
x0 = 2*rand(size(A,1),1)-1;
numT = 10; maxit = 10; alpha = 10; T0 = 10;
[xbest, fvec, Evec] = MinBisection(A, x0, numT, maxit, alpha, T0);