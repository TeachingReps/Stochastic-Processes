% Queue lengths for priority max weight for deterministic arrivals.
% Figure 4



clc; clear all; close all;


N = 100;    % Number of time slots for which the algorithm is run
T = 3;       % Impatience time of Person A


% Initializations
a1 = zeros(N,1);
a2 = zeros(N,1);
Q1 = zeros(N,1);
Q2 = zeros(N,1);

% Initial value
Q1(1) = 10; Q2(1) = 10;

% Deterministic arrival process
a1(1:2:N) = 1;
a2(1:2:N) = 1;


%% Allocation

for t = 1: N-1
    
    
    b1 = 0; b2 = 0;
    
    if mod(t,T) == 1
        b1 = 1;
    elseif Q1(t) >= Q2(t)
        b1 = 1;
    else b2 = 1;
        
    end
    
    Q1(t+1) = max(Q1(t)-b1,0) + a1(t+1);
    
    Q2(t+1) = max(Q2(t)-b2,0) + a2(t+1);
    
    
end


%%


figure; plot(Q1,'o'); %title('Q1','fontsize',24)
xlabel('Time','fontsize',24)
ylabel('Queue Length','fontsize',24)
Ymin = min(Q1); Ymax = max(Q1); Xmin = 1; Xmax = N;
axis([Xmin Xmax Ymin-1 Ymax+1])
export_fig Deterministic_1.pdf -transparent

figure; plot(Q2,'o'); %title('Q2','fontsize',24)
xlabel('Time','fontsize',24)
ylabel('Queue Length','fontsize',24)
Ymin = min(Q2); Ymax = max(Q2); Xmin = 1; Xmax = N;
axis([Xmin Xmax Ymin-1 Ymax+1])
export_fig Deterministic_2.pdf -transparent
