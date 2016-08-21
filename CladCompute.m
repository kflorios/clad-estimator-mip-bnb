function [values,estimates,times,qualities,nodes]=CladCompute(X,y,w)

global cp;

%Main Program: Computes Max score by defining a MILP and calling milp.m
tic
%%%[X,y,w]=readXyw();
%[X,mu,sigma]=standardizeX(X,y);
[c,A,b]=definecAb(X,y,w);
[lb,ub, Aeq, beq, n, best]=definelbub(X,y);
[x10,cost10,feasible10]=milp10(c,A,b,Aeq,beq,lb,ub,n, best);    %10

estimates10=x10;
value10=cost10;
time10=toc;

quality10=feasible10;

%%%[x01,cost01,feasible01]=milp01(c,A,b,Aeq,beq,lb,ub,n, best);    %01
x01=nan(size(estimates10,1),1);
cost01=nan;
feasible01=nan;

%estimatesRaw=denormalizeEstimates(estimatesNorm,mu,sigma)

estimates01=x01;
value01=cost01;
time01=nan;
quality01=feasible01;

values=[value10 value01];
estimates=[estimates10 estimates01];
times=[time10 time01]
qualities=[quality10 quality01];
nodes=[cp NaN];
end