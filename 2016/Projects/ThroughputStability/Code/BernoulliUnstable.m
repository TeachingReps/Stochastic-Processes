% Queue lengths for priority max weight for Bernoulli arrivals for the
% unstable case.
% Figure 3


clc; clear all; close all;


N = 10000;    % Number of time slots for which the algorithm is run
T = 3;       % Impatience time of Person A


% Initializations
a1 = zeros(N,1);
a2 = zeros(N,1);
Q1 = zeros(N,1);
Q2 = zeros(N,1);

% Initial value
Q1(1) = 10; Q2(1) = 10;

% Bernoulli arrival rates
p1 = 0.6;  p2 =  0.5;


%% Allocation

for t = 1: N-1
    
    if rand(1)<p1
        a1(t+1) = 1;
    end
    
    if rand(1)<p2
        a2(t+1) = 1;
    end
    
    b1 = 0; b2 = 0; % Allocation
    
    
    % Priority max weight
    if mod(t,T) == 1
        b1 = 1;
    elseif Q1(t) >= Q2(t)
        b1 = 1;
    else b2 = 1;
        
    end
    
    Q1(t+1) = max(Q1(t)-b1,0) + a1(t+1);
    
    Q2(t+1) = max(Q2(t)-b2,0) + a2(t+1);
    
    
end


%% Figures


figure; plot(Q1,'o'); %title('Q1','fontsize',24)
xlabel('Time','fontsize',24)
ylabel('Queue Length','fontsize',24)
export_fig Bernoulli_3.pdf -transparent

figure; plot(Q2,'o'); %title('Q2','fontsize',24)
xlabel('Time','fontsize',24)
ylabel('Queue Length','fontsize',24)
export_fig Bernoulli_4.pdf -transparent
