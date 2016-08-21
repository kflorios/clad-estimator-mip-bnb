function [x,cost,feasible]=milp10(c,A,b,Aeq,beq,lb,ub,n, best);   
% Solves a integer lp using branch and bound proceeding in a 
% depth-first manner (recursive)
% c: is cost        A: is constraint matrix   b: is constraint vector
% lb: lower bound     ub: upper bound   n: number of integer variables
% best: is best solution so far
% Note this traverses along the right most branch
% unlike the usual way of checking both branches before continuing. Also,
% it assumes first n variables must be integer.
% Written by Kevin Tomsovic

% Initialization
feasible=0;         % 1 - Feasible, 0 - Infeasible
tol=1e-3;           % Tolerance on integers
%%%tol=1e-6;           % Tolerance on integers
cost=inf;

global cp;

% Solve current linprog, suppress error messages

%1. linprog
%options=optimset('display','off');
%options=optimset(options,'simplex','on');
%options=optimset(options,'LargeScale','off');
%[x,cost,how]=linprog(c,A,b,Aeq,beq,lb,ub,[],options);

%2. opti_linprog
%options = optiset('solver',CLP)
[x,cost,how]=opti_linprog(c,A,b,Aeq,beq,lb,ub);
cp=cp+1;

if mod(cp,100)==0
    msg=sprintf('%d iteration and %f bestsofar and %f a solution',cp,best,cost);
    disp(msg);
end

% If infeasible or cost is greater than bound (best solution found)
%   then stop and return with infinite cost
if how<=0 | cost>best, cost=inf; return; end;   %KJF comments out 1.4.2016

% Take first non integer u and branch
branch=0;
for i=1:n   % Split LP on first non-integer u
   if abs(x(i)-round(x(i)))>tol, branch=i; break; end;
end;      

if cp>=10*10^3
   return 
end

% If integer solution then return optimal solution
if branch==0, feasible=1; % If valid integer solution (branch==0), return 
   return;   
else  % Solve subproblems by putting new upper and lower bounds on branch variable
      % Proceeding depth-first
   lba=lb; uba=ub;
   uba(branch)=floor(x(branch)); lba(branch)=ceil(x(branch));
   
   % Solve right branch (x>=ceil(x))with new best
   [x,cost,how]=milp10(c,A,b,Aeq,beq,lba,ub,n,best);
   best=min(cost,best);
   
   % Solve left branch (x<=floor(x)) 
   [xb,cost,feasible]=milp10(c,A,b,Aeq,beq,lb,uba,n,best);   
   
   if cost<best, x=xb; % Better solution found
   else cost=best; 
   end; 
   feasible=feasible | how;    % Feasible solution found?
end;
return;