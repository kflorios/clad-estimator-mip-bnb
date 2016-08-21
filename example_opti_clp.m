
f = -[1 2 3]';


A = [-1,1,1; 1,-3,1];
b = [20,30]';
Aeq = [1 1 1];
beq = 40;
lb = [0;0;0];
ub = [40;inf;inf];


Ar = [A;Aeq];
rl = [-Inf(size(b));beq];
ru = [b;beq];




[x,fval,exitflag,info] = opti_clp(f,Ar,rl,ru,lb,ub)


% or just use:
% opti_linprog
% instead of:
% linprog
% with same syntax