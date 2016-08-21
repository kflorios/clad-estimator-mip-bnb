function [lb,ub, Aeq, beq, n, best]=definelbub(X,y)

%Defines lb,ub for milp.m
 d=10;
%d=5;
n=size(X,1);
p=size(X,2);

lb1=repmat(0,1,n);     %gammas
lb2=repmat(-d,1,p);     %betas
%lb3=repmat(-Inf,1,n);    %phis
lb3=repmat(0,1,n);          %phis, left censoring at zero (0)
lb4=repmat(0,1,n);          %sm's
lb5=repmat(0,1,n);           %sp's

lb=[lb1 lb2 lb3 lb4 lb5];

BIGNUM=+Inf;

ub1=repmat(1,1,n);     %gammas
ub2=repmat(d,1,p);      %betas
ub3=repmat(+BIGNUM,1,n);    %phis
ub4=repmat(+BIGNUM,1,n);     %sm's
ub5=repmat(+BIGNUM,1,n);      %sp's

ub=[ub1 ub2 ub3 ub4 ub5];


for i=1:n
   Aeq(i,1:n)=0; %gammas
   Aeq(i,(n+1):(n+p))=0; %betas
   Aeq(i,(n+p+1):(2*n+p))=-1.*(1:n==i);  %phis
   Aeq(i,(2*n+p+1):(3*n+p))=1.*(1:n==i);  %sm's
   Aeq(i,(3*n+p+1):(4*n+p))= -1.*(1:n==i);  %sp's
end

for i=1:n
   beq(i)= -y(i); 
end


best=+Inf;

end