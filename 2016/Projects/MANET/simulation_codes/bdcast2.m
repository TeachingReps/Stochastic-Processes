%Take two nodes, moving source and moving destination
%Broadcast time is the expected time that the moving destination will
%take to reach the moving source from its initial position

time_slots = 10^5;
num_runs = 10^4;
torus_lim = 6;
bcast_time = zeros(size(torus_lim,2),1);
for i = 1 : size(torus_lim,2)
    
    for run = 1 : num_runs
    %node_pos = randi([0 torus_lim(i)], 1, 2);
    node_pos = [0,torus_lim];
    rw_vals = randi([0 1],time_slots,2);
    rw_vals(rw_vals == 0) = -1;
    
    slot = 0;
    while (slot < time_slots)
         slot = slot + 1;
         node_pos = node_pos + rw_vals(slot,:);
         node_pos(node_pos == (torus_lim(i)+1)) = -torus_lim(i);
         node_pos(node_pos == -torus_lim(i)-1) = torus_lim(i);
         
           
         if (node_pos(1) == node_pos(2))
             break;
         end
         
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
title('Average broadcast time for a moving source and a moving destination');

