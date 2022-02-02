#!/bin/bash

# create an OvS bridge called donut-plains and castle-koopa
sudo ovs-vsctl add-br donut-plains
sudo ovs-vsctl add-br castle-koopa

# create network namespaces
sudo ip netns add wario &> /dev/null
sudo ip netns add yoshi &> /dev/null


# create bridge internal interface
sudo ovs-vsctl add-port donut-plains wario -- set interface wario type=internal
sudo ip link set wario netns wario

# create VETH for yoshi & plug in VETH to namespace
sudo ip link add yoshi2net type veth peer name net2yoshi &> /dev/null
sudo ip link set yoshi2net netns yoshi &> /dev/null
sudo ovs-vsctl add-port castle-koopa net2yoshi

# bring interface UP in bowser and peach
sudo ip netns exec wario ip link set dev wario up
sudo ip netns exec yoshi ip link set dev yoshi2net up
sudo ip netns exec wario ip link set dev lo up
sudo ip netns exec yoshi ip link set dev lo up

# add IP address to interface
sudo ip netns exec wario ip addr add 10.64.2.2/24 dev wario
sudo ip netns exec yoshi ip addr add 10.64.2.3/24 dev yoshi2net

# patch
sudo ovs-vsctl add-port donut-plains toad -- set interface toad type=patch options:peer=metalmario
sudo ovs-vsctl add-port castle-koopa metalmario -- set interface metalmario type=patch options:peer=toad
