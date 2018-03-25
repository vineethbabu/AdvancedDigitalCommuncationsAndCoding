clc 
close all 
clear all 

data = randi([0,1],1,10^4);
Eb = mean(data.^2);

 s=zeros(length(data),1);
 
% Mapping %
for i=1:length(data)
    if data(i) == 0
        s(i)=sqrt(Eb);
    else
        s(i)=-sqrt(Eb);
    end
end

%Noise%
snr=0:1:30;
p = 1./(10.^(snr/10));

for i=1:length(snr)
    noise(:,:,i)= p(i)*randn(10^4,1);
end

for i=1:length(snr)
    Y(:,:,i)=s+noise(:,:,i);
end

for i=1:length(snr)
for j=1:length(data)
    if Y(j,1,i)>=0
        out(j,1,i)=0;
    else
        out(j,1,i)=1;
    end
end
end

for i=1:length(snr)
    count=0;
    for j=1:length(data)
   if out(j,1,i) ~= data(1,j)
       count=count+1;
   end
    end
    ber(i)=count/length(data);
end

plot(snr,ber)



