function [c,A,b]=definecAb(X,y,w)

%Defines c,A,b for milp.m

n=size(X,1);
p=size(X,2);

c3=repmat(0,1,n);   %gammas integer
c1=repmat(0,1,p);    %betas
c2=repmat(0,1,n);     %phis
c4=repmat(1,1,n);      %sm's
c5=repmat(1,1,n);       %sp's

c=[c3 c1 c2 c4 c5];

 d=10;
%d=5;
for i=1:1:n
    M(i)=abs(X(i,1))*d+abs(X(i,2:end))*repmat(d,1,p-1)';
end

for i=1:n         %constraint 3c in pdf ssrn
   A1(i,1:n)=0;  %gammas
   for j=1:p
   A1(i,(n+j))=X(i,j);  %betas
   end
   A1(i,(n+p+1):(2*n+p))=-1.*(1:n==i);   %phis
   A1(i,(2*n+p+1):(3*n+p))=0;             %sm's
   A1(i,(3*n+p+1):(4*n+p))=0;              %sp's
end

for i=1:n
   b1(i)=0;
end

for i=1:n       %constraint 3e in pdf ssrn
   A2(i,1:n)=M(i).*(1:n==i);   %gammas
   for j=1:p
   A2(i,(n+j))=-X(i,j);  %betas
   end
   A2(i,(n+p+1):(2*n+p))=1.*(1:n==i);        %phis
   A2(i,(2*n+p+1):(3*n+p))=0;       %sm's
   A2(i,(3*n+p+1):(4*n+p))=0;        %sp's
end

for i=1:n
   b2(i)=M(i);
end

for i=1:n       %constraint 3f in pdf ssrn
  A3(i,1:n)=-M(i).*(1:n==i);   %gammas
  A3(i,(n+1):(n+p))=0; %betas
  A3(i,(n+p+1):(2*n+p))=1.*(1:n==i);  %phis
  A3(i,(2*n+p+1):(3*n+p))=0;  %sm's
  A3(i,(3*n+p+1):(4*n+p))=0; %sp's
end

for i=1:n
   b3(i)=0;  % for left censoring at 0 
end

A= [A1 ; A2 ; A3];
b= [b1  b2  b3]';



end