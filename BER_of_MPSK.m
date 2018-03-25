clc
close all
clear all

M=4;
data = randi([1 M],1,10^4);
Eb= sqrt(mean(data.^2));
s=zeros(length(data),2);
for i=1:length(data)
    s(i,:)=[Eb*cos((2*data(i)-1)*(pi/M)),Eb*sin((2*data(i)-1)*(pi/M))];
end



snr=0:1:20;
p=1./(10.^(snr/10));
for i=1:length(snr)
    noise(:,:,i)= p(i)*randn(10^4,2);
end

for i=1:length(snr)
        Y(:,:,i)=s+noise(:,:,i);
end

scatter(Y(:,1),Y(:,2))

for j=1:length(data)
    for i=1:length(snr)
             if Y(j,1,i)>=0 && Y(j,2,i)>=0
                a=atan(Y(j,2,i)/Y(j,1,i));
             elseif Y(j,1,i)<0 && Y(j,2,i)>0
                a=pi-atan(Y(j,2,i)/Y(j,1,i));
             elseif Y(j,1,i)<0 && Y(j,2,i)<0
                a=pi+atan(Y(j,2,i)/Y(j,1,i));
             elseif Y(j,1,i)>0 && Y(j,2,i)<0
                a=2*pi-atan(Y(j,2,i)/Y(j,1,i)); 
             end
       for k=1:M
            if (2*k-2)*(pi/M)<= a && a<(2*k)*(pi/M)
            out(j,1,i)=k;
            end
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
    figure;
    plot(snr,ber)

