function [Results, Obj, maxClique, maxObj] = ReplicatorDyn(AG,N)

%Initialize & parameters
n = size(AG,1);
Results = zeros(n,N);
Initial = zeros(n,N);
myeps = 1e-6;
Obj = zeros(1000,N);

% Begin Algorithm
for i = 1:N
    x0 = rand(n,1); x0 = x0/sum(x0);
    Initial(:,i) = x0;
    itr = 1; notConverged = 1;
    while notConverged
        Obj(itr,i) = (x0'*AG*x0);
        x = x0.*(AG*x0)/Obj(itr,i);
        notConverged = max(abs(x-x0)) > myeps;
        x0 = x;
        itr = itr+1;
    end
    Results(:,i) = x0;
end
Results(Results<myeps) = 0;

% Visualize
maxObj = 0; imax = 0;
figure(1); hold on
for i = 1:N
    stopind = find(Obj(:,i)<eps,1,'first')-1;
    plot(Obj(1:stopind,i),'linewidth',2);
    if Obj(stopind) > maxObj; maxObj = Obj(stopind); imax = i; end
end
maxClique = find(Results(:,imax)~=0);

grid on;
xlabel('Iterations'); ylabel('Objective Function')


