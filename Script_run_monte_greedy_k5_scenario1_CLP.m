
%cd D:\Users\Kostas\Desktop\Example4\Scenario1_k=5_greedyMonteCLPforLP
cd C:\Storage\Kostas\AUEB\Postdoc-AUEB-2013\GREGORY-PC-2016\Example4backup\Scenario1_k=5_greedyMonteCLPforLP

rng default
NTimes=10;

%b=[1 1 2 3 4]';  %me, with 100 obs.
b=[-6 3 3 3 3]';  % a la chernozhukov-hong 2003, with 100 obs.
V=zeros(NTimes,2);
E=zeros(NTimes,10);
T=zeros(NTimes,2);
Q=zeros(NTimes,2);
N=zeros(NTimes,2);
global cp;

for i=1:NTimes
    cp=0;
    i
    X=randn(400,4);
    X=[ones(400,1) X];
    scale=X(:,2).*X(:,2);
    u=randn(400,1);
    e=scale.*u;
    ystar=X*b+e;
    ys=ystar.*(ystar>=0);
    w=ones(400,1);
    
    %greedy branching sequence according to response ys in decreasing order
    ybar = ys;
    [ybarSort,idx] = sort(ybar,1,'descend');
    
    XbarSort=X(idx,:);
    
    %[values,estimates,times,qualities]=CladCompute(X,ys,w);
    %[values,estimates,times,qualities]=CladCompute(XbarSort,ybarSort,w);
    [values,estimates,times,qualities,nodes]=CladCompute(XbarSort,ybarSort,w);
    V(i,:)=values;
    E(i,:)=[estimates(401:405,1)' estimates(401:405,2)'];
    T(i,:)=times;
    Q(i,:)=qualities;
    N(i,:)=nodes;
    
end

save VgreedyCLP.txt V -ascii
save EgreedyCLP.txt E -ascii
save TgreedyCLP.txt T -ascii
save QgreedyCLP.txt Q -ascii
save NgreedyCLP.txt N -ascii

temp=1