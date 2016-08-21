function [X,y,w]=readXyw()

%Reads X,y,w of given max score problem

X=load('X_40.txt');
%X=[X(:,2) X(:,3)];
X=X(:,2:end);
y=load('ys_40.txt');
y=[y(:,2)];
%w=load('w_numeric5.txt');
%w=[w(:,2)];
w=repmat(1,size(X,1),1);

end