clc;
clear all;
close all;
statespace=0:500:10000;
n=21;

%%%%% BEFORE DEMONETIZATION
histwithdrawal1=[2524 110 80 55 67 15 28 4 17 20 40 22 17 14 25 19 11 9 2 1 20];
histconsumption1=[415 1919 424 102 70 46 10 13 17 7 19 2 3 4 1 1 2 1 1 1 2];
pdfwithdrawal1=histwithdrawal1./sum(histwithdrawal1(1:n));
pdfconsumption1=histconsumption1./sum(histconsumption1(1:n));
pbar1=histwithdrawal1(1)/3100; 
pwithdrawal1=1-pbar1;
pcbar1=histconsumption1(1)/3100; 
pconsumption1=1-pcbar1;

tpm1=zeros(n,n);

for i=1:n
    
    for j=1:n
       

        for k=1:n
           if (j-i+k)>=1 && (j-i+k)<=n
                tpm1(i,j)=tpm1(i,j)+pdfwithdrawal1(j-i+k)*pdfconsumption1(k);
                
           end
        end
    end
end
for i=1:21
    tpm1(i,:)=tpm1(i,:)./sum(tpm1(i,:));
end

A=tpm1;
[V , D ] = eig(A');
 
[foo , tp] = sort(diag(D));
 
Pstationary = (V(: , tp(end))/sum(V(: , tp(end))))';


%%%%% NOVEMBER 8 - DECEMBER 7
histwithdrawal2=[2707 80 27 16 93 37 5 1 5 8 6 1 1 1 2 4 1 1 1 1 2];
histconsumption2=[1141 1472 205 47 43 20 12 8 11 6 12 3 1 2 2 2 4 1 3 1 4];
pdfwithdrawal2=histwithdrawal2./sum(histwithdrawal2(1:n));
pdfconsumption2=histconsumption2./sum(histconsumption2(1:n));
tpm2=zeros(n,n);
pbar2=histwithdrawal2(1)/3100; 
pwithdrawal2=1-pbar2;
pcbar2=histconsumption2(1)/3100; 
pconsumption2=1-pcbar2;
% 
for i=1:n
    
    for j=1:n
       
        for k=1:n
           if (j-i+k)>=1 && (j-i+k)<=n
                tpm2(i,j)=tpm2(i,j)+pdfwithdrawal2(j-i+k)*pdfconsumption2(k);
                
           end
        end
    end
end
for i=1:21
    tpm2(i,:)=tpm2(i,:)./sum(tpm2(i,:));
end

PI2=Pstationary;

for pp=1:30
    PI2=PI2*tpm2; 
end

 %%%%DECEMBER 8 -JANUARY 7
histwithdrawal3=[2706 106 49 35 102 14 8 12 25 10 15 1 2 1 1 1 2 1 1 1 7];
histconsumption3=[1097 1435 379 51 40 17 14 9 16 4 18 1 2 1 1 2 3 3 2 4 1];
pdfwithdrawal3=histwithdrawal3./sum(histwithdrawal3(1:n));
pdfconsumption3=histconsumption3./sum(histconsumption3(1:n));
pbar3=histwithdrawal3(1)/3100; 
pwithdrawal3=1-pbar3;
pcbar3=histconsumption3(1)/3100; 
pconsumption3=1-pcbar3;
tpm3=zeros(n,n);
% 
for i=1:n
    
    for j=1:n
       
        for k=1:n
           if (j-i+k)>=1 && (j-i+k)<=n
                tpm3(i,j)=tpm3(i,j)+pdfwithdrawal3(j-i+k)*pdfconsumption3(k);
                
           end
        end
    end
end
for i=1:21
    tpm3(i,:)=tpm3(i,:)./sum(tpm3(i,:));
end

PI3=PI2;

for pp=1:30
    PI3=PI3*tpm3; 
end


%%%%JANUARY 8 -FEBRUARY 7

histwithdrawal4=[2612 106 68 42 127 42 13 18 14 22 7 1 8 2 1 1 4 1 2 1 8];
histconsumption4=[621 1811 390 114 54 30 8 6 12 8 14 7 11 2 1 3 3 1 1 1 2];
pdfwithdrawal4=histwithdrawal4./sum(histwithdrawal4(1:n));
pdfconsumption4=histconsumption4./sum(histconsumption4(1:n));
tpm4=zeros(n,n);
pbar4=histwithdrawal4(1)/3100; 
pwithdrawal4=1-pbar4;
pcbar4=histconsumption4(1)/3100; 
pconsumption4=1-pcbar4;
% 
for i=1:n
    
    for j=1:n
       
        for k=1:n
           if (j-i+k)>=1 && (j-i+k)<=n
                tpm4(i,j)=tpm4(i,j)+pdfwithdrawal4(j-i+k)*pdfconsumption4(k);
                
           end
        end
    end
end
for i=1:21
    tpm4(i,:)=tpm4(i,:)./sum(tpm4(i,:));
end

PI4=PI3;

for pp=1:30
    PI4=PI4*tpm4; 
end
PI5=PI4;

%%%%% AFTER FEBRUARY
for nn=1:10000
    PI5=PI5*tpm1;
    if(abs(PI5-Pstationary)<=(10^-5)*ones(1,n))
        break;
    end
end


Simulated_Expected_Mixing_Time=nn
%%%%Theoretical

PP= kron(Pstationary,ones(n,1));
G=ginv(eye(n)-tpm1);
H=G*(eye(n)-tpm1);
C=eye(n)-H;
D=inv(kron((diag(PP))',ones(n,1)).*eye(n));
E=ones(n,n);
Cd=kron((diag(C))',ones(n,1)).*eye(n);
M=(C-E*Cd+E)*D;
Theoretical_Expected_time_to_mix=M(1,:)*Pstationary'



plot(statespace(2:n),pdfwithdrawal1(2:n)/pwithdrawal1,'r*-');
grid on;
xlabel('Withdrawal in Rs.')
ylabel('Probability');
title('Otober 8th-November 7th');
figure;

plot(statespace(2:n),pdfwithdrawal2(2:n)/pwithdrawal2,'r*-');
xlabel('Withdrawal in Rs.')
ylabel('Probability');
title('November 8th-December 7th');
grid on; figure;

plot(statespace(2:n),pdfwithdrawal3(2:n)/pwithdrawal3,'r*-');
xlabel('Withdrawal in Rs.')
ylabel('Probability');
title('December 8th-January 7th');
grid on; figure;

plot(statespace(2:n),pdfwithdrawal4(2:n)/pwithdrawal4,'r*-');
xlabel('Withdrawal in Rs.')
ylabel('Probability');
title('January 8th-February 7th');
grid on; figure;

plot(statespace(2:n),pdfconsumption1(2:n)/pconsumption1,'r*-');
grid on;
axis([0 10000 -0.02 1]);
title('Otober 8th-November 7th');
xlabel('Consumption in Rs.')
ylabel('Probability');
figure;

plot(statespace(2:n),pdfconsumption2(2:n)/pconsumption2,'r*-');
grid on;
title('November 8th-December 7th');
axis([0 10000 -0.02 1]);
xlabel('Consumption in Rs.')
ylabel('Probability');
figure;

plot(statespace(2:n),pdfconsumption3(2:n)/pconsumption3,'r*-');
xlabel('Consumption in Rs.')
ylabel('Probability');
grid on;
title('December 8th-January 7th');
axis([0 10000 -0.02 1]);

figure;
plot(statespace(2:n),pdfconsumption4(2:n)/pconsumption4,'r*-');
grid on;
xlabel('Consumption in Rs.')
ylabel('Probability');
title('January 8th-Febraury 7th');
axis([0 10000 -0.02 1]);




