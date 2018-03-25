clc
close all
clear all

data = randi([0 1],1,10^4);
for i=1:length(data)
    if data(i)==0
        s(i,:) = [1,0];
    else
        s(i,:) = [0,1];
    end
end

snr = 0:1:20;
p = 1./(10.^(snr/10));

for i=1:length(snr)
    Noise(:,:,i) = p(i)*randn(length(data),2);
end

for i=1:length(snr)
    Y(:,:,i) = s+Noise(:,:,i);
end

for i=1:length(data)
    for j=1:length(snr)
        if Y(i,1,j)>=Y(i,2,j)
            out(i,1,j) = 0;
        else
            out(i,1,j) = 1;
        end
    end
end
data = data';
for i=1:length(snr)
    count=0;
    for j=1:length(data)
        if out(j,1,i) ~= data(j)
            count = count+1;
        end
    end
    ber(i) = count/length(data);
end

plot(snr,ber)
