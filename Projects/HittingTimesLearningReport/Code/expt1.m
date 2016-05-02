clear;
N=200;    %samples for plot
m=10;    %No of markov chains
%T=100;   %Horizon

num_expts=10;

P=zeros(N,1);
Q=zeros(N,1);
R=zeros(N,1);
S=zeros(N,1);

global A0 B0 A1 B1;
    A0=ones(m,1);
    B0=ones(m,1);
    A1=ones(m,1);
    B1=ones(m,1);
    
    
global C_hat_00 C_hat_01 C_hat_10 C_hat_11 P_hat_01 P_hat_11   
    C_hat_00=zeros(m,1)+0.001; %added small value to avoid NaN
    C_hat_01=zeros(m,1)+0.001;
    C_hat_10=zeros(m,1)+0.001;
    C_hat_11=zeros(m,1)+0.001;
    
    
    P_hat_01=zeros(m,1);
    P_hat_11=zeros(m,1);
    
    
%Transition matrices
%P_00=rand(m,1);
P_00=(rand(m,1)/5)+0.8;
P_00(1,1)=0.1;P_00(2,1)=0.2;
P_01=1-P_00;
P_10=(rand(m,1)/5)+0.8;
P_10(1,1)=0.1;P_10(2,1)=0.2;
P_11=1-P_10;




for k=1:N



X=zeros(m,1);
Y=zeros(m,1);
Z=zeros(m,1);
W=zeros(m,1);


H_time1=zeros(num_expts,1);
H_time2=zeros(num_expts,1);
H_time3=zeros(num_expts,1);
H_time4=zeros(num_expts,1);

for n=1:num_expts
    H_time1(n)=randalloc(X,m,P_11,P_01);
    H_time2(n)=thompsonsampling(Y,m,P_11,P_01);
    H_time3(n)=sampbasalloc(Z,m,P_11,P_01);
    H_time4(n)=optStrategy(W,m,P_11,P_01);
end

 P(k)=mean(H_time1);
 Q(k)=mean(H_time2);
 R(k)=mean(H_time3);
 S(k)=mean(H_time4);
end        

plot(P,'r')
hold on;
plot(Q,'g')
hold on;
plot(R,'b')
hold on;
plot(S,'c')
xlabel('No of times experiment is done')
ylabel('average hitting time')
title('Average hitting time')
legend('randomChoice','ThompsonSamplingChoice','sampleAverageChoice','idealOptimalChoice')
