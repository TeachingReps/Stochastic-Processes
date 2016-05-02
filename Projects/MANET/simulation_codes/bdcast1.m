%Take two nodes, fixed source and moving destination
%Broadcast time is the expected time that the moving destination will
%take to reach the fixed source from its initial position

time_slots = 10^5;
num_runs = 10^4;
torus_lim = 6;
bcast_time = zeros(size(torus_lim,2),1);
for i = 1 : size(torus_lim,2)
    
    for run = 1 : num_runs
    %node_pos = randi([0 torus_lim(i)]);
    node_pos = 4;%Initial location of the node
    rw_vals = randi([0 1],time_slots,1);
    rw_vals(rw_vals == 0) = -1;
    
    slot = 1;
    while (slot < time_slots)
         if (node_pos == 0)
             break;
         end
         
         node_pos = node_pos + rw_vals(slot); 
         node_pos(node_pos == (torus_lim(i)+1)) = -torus_lim(i);
         node_pos(node_pos == -torus_lim(i)-1) = torus_lim(i);
      
         slot = slot + 1;
    end
    bcast_time(i) = bcast_time(i) + slot;
    end
    fprintf('Broadcast time for torus limit %d is %d\n',torus_lim(i),bcast_time(i));
end
bcast_time = bcast_time./num_runs;

figure;
plot(torus_lim, bcast_time, 'b--o');
xlabel('Torus limit');
ylabel('Broadcast time');
title('Average broadcast time for a fixed source and a moving destination');

