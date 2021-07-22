clc
clear 
close all
format long
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filename = 'Book1.xlsx';
sheet = 1;
xlRange = 'A4:C55936';
St = xlsread(filename,sheet,xlRange);
[n,m]=size(St);
s=zeros(8404,13094);
for i=1:n
    s(St(i,1),St(i,2))=St(i,3);
end
[m,n]=size(s);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Lt=xlsread(filename,'A99335:C142173');
[nl,ml]=size(Lt);
l1=zeros(13094,50);
for i=1:nl
    l1(Lt(i,1),Lt(i,2))=Lt(i,3);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ut=xlsread(filename,'A55940:C99391');
[nu,mu]=size(Ut);
u1=zeros(13094,50);
for i=1:nu
    u1(Ut(i,1),Ut(i,2))=Ut(i,3);
end
[n,d]=size(u1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v=zeros(13094,50);
% for i=1:n
%     f(i)=1+133.68*sum(s(:,i));
% end
%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:50
u=u1(:,i);
l=l1(:,i);
Aeq=[];
beq=[];
b=zeros(8404,1);
f=ones(13094,1);
x=linprog(f,Aeq,beq,s,b,l,u);
% x=quadprog([],f,[],[],s,b,l,u);
v(:,i)=x;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% k=0;
% for i=1:n
%     if norm(v(i,:))<10^-16
%         k=k+1;
%     end
% end
% k
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k=0;
for i=1:n
    if sum(v(i,:)==0)==d
        k=k+1;
    end
end
    k
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ss=s*v;
p=0;
for i=1:d
    if sum(ss(:,i)==0)==m
        p=p+1;
    end
end
    p
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filename = 'output.xlsx';
A = v;
xlswrite(filename,A)
