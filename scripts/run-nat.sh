#!/usr/bin/env bash
sudo python ./src/nat/nat_topo.py <<EOF
h1 ping -c 1 h3
h3 ping -c 1 h1
EOF
