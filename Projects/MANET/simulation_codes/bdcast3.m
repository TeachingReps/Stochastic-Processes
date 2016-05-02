%Vary number of nodes, moving source and moving destination
%Broadcast time is the expected time for all the nodes to 
%receive the information from the original source (here node 1)
%or any node which has already received the information

time_slots = 10^5;
num_runs = 10^4;
torus_lim = 15;
num_nodes = [2:1:10];

bcast_time = zeros(size(num_nodes,2),1);
for i = 1 : size(num_nodes,2)
    
    for run = 1 : num_runs
        src_node = zeros(1,num_nodes(i));
        src_node(1) = 1;
        node_pos = randi([0 torus_lim], 1, num_nodes(i));
        rw_vals = randi([0 1],time_slots,num_nodes(i));
        rw_vals(rw_vals == 0) = -1;
        allnodes = 1: 1: num_nodes(i);
        rem_nodes = setdiff(allnodes,src_node);
        slot = 1; src_indx = 1;
        while (slot <= time_slots)           
           
           bool_tmp = (node_pos(rem_nodes) == any(node_pos(src_node(1:src_indx))));
           nz_ind = find(bool_tmp ~= 0);
           if (size(nz_ind,2) > 0)
               for tmp = 1 : size(nz_ind,2)
                   src_indx = src_indx + 1;
                   src_node(src_indx) = rem_nodes(nz_ind(tmp));
               end
               rem_nodes = setdiff(allnodes,src_node);
           end
           
           if (size(rem_nodes,2) == 0)
              break;
           end  
           
           node_pos = node_pos + rw_vals(slot,:);
           node_pos(node_pos == (torus_lim+1)) = -torus_lim;
           node_pos(node_pos == -torus_lim-1) = torus_lim;
           
           slot = slot + 1;
        end
        bcast_time(i) = bcast_time(i) + slot;
    end
    fprintf('Broadcast time for %d nodes is %d\n',num_nodes(i),bcast_time(i));
end
bcast_time = bcast_time./num_runs;

figure;
plot(num_nodes, bcast_time, 'b--o');
xlabel('Torus limit');
ylabel('Broadcast time');
title('Average broadcast time for a moving source and a moving destination');

