clc
close all
clear all

n=7;
k=4;

messages = de2bi(0:15,4,'left-msb');
parity = [1 1 1;0 1 1;1 0 1; 0 1 1];
Generator  = [eye(4) parity];
codewords = mod(messages*Generator,2);
ParityCheck = [parity' eye(3)];
errorpattern = eye(7);
Syndrome = errorpattern*ParityCheck';

error = [0 0 0 0 0 0 1];
msg = randi([0 1],1,4);
txCode = mod(msg*Generator,2);
recCode = txCode+error;
recSyndrome=mod(recCode*ParityCheck',2);


    if recSyndrome == [0 0 0]
        CorrectedCode = recCode;
    else
        for i=1:length(Syndrome)
            if recSyndrome == Syndrome(i,:);
                index = i;
                break
            end
        end
    end
  
    CorrectedCode = mod(recCode+errorpattern(i,:),2);
    for i=1:length(codewords)
        if CorrectedCode == codewords(i,:)
            Sentmessage = messages(i,:);
        end
    end
    
    
    