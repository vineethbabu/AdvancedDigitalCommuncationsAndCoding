clc 
clear all
close all

msg = [1 0 0 1 0 0] ;
k=1;
%out=zeros(1,2*length(msg));
for i=length(msg):-1:3

            out(1,k)=bitxor(bitxor(msg(1,i),msg(1,i-1)),msg(1,i-2));
            out(1,k+1)=bitxor(msg(1,i),msg(1,i-2));
            k=k+2;      
end
j=(2*length(msg)-4)+1;
msg = circshift(msg,[1,2]);  
for i=4:-1:3
            out(1,j)= bitxor(bitxor(msg(1,i),msg(1,i-1)),msg(1,i-2));
            out(1,j+1)= bitxor(msg(1,i),msg(1,i-2));
            j=j+2;
end
