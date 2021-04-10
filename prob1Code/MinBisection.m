function [xbest, fvec, Evec] = MinBisection(A, x0, numT, maxit, alpha, T0)

graphSize = size(A,1);
if rem(graphSize,2)~=0; error('Graph size must be even for minimum bisection'); end
n = graphSize/2;

%Initialize & parameters
T=T0; Tfac = 0.9; 
x = x0; xbest = x0;
W = A - 2*alpha*(1-eye(2*n));
Ebest = -0.5*xbest'*W*xbest;

Evec = Ebest;
fvec = 0.25*(sum(sum(A)) - xbest'*A*xbest);

%Calculate
for i = 1:maxit
    x = xbest;
    for j = 1:numT
        for k = 1:2*n
            x(k) = tanh(W(k,:)*x/T);
            E = -0.5*x'*W*x;
            if E<Ebest; xbest = x; Ebest = E; end
        end
        fvec = [fvec; 0.25*(sum(sum(A)) - xbest'*A*xbest)];
    Evec = [Evec; Ebest];
    figure(1)
    subplot(2,1,1), plot(Evec,'o-'); hold on
    subplot(2,1,2), plot(fvec,'ro-'); hold on
    end
    T = Tfac*T;
    
end


