#!/bin/bash
# TEARDOWN

# delete bridges
sudo ovs-vsctl del-br donut-plains &> /dev/null
sudo ovs-vsctl del-br castle-koopa &> /dev/null

# delete VENH
sudo ip netns exec yoshi ip link delete yoshi2net &> /dev/null

# delete network namespaces
sudo ip netns del wario &> /dev/null
sudo ip netns del yoshi &> /dev/null

