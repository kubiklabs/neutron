#!/bin/bash
set -e

script_full_path=$(dirname "$0")

export BINARY=neutrond
export CHAINID=neutron-test-1
export P2PPORT=26656
export RPCPORT=26657
export RESTPORT=1317
export ROSETTA=8080
export GRPCPORT=8090
export GRPCWEB=8091
export STAKEDENOM=untrn

"$script_full_path"/init.sh
"$script_full_path"/init-neutrond.sh
"$script_full_path"/start.sh

export BINARY=gaiad
export CHAINID=gaia-test-2
export P2PPORT=16656
export RPCPORT=16657
export RESTPORT=1316
export ROSETTA=9080
export GRPCPORT=9090
export GRPCWEB=9091
export STAKEDENOM=uatom

"$script_full_path"/init.sh
"$script_full_path"/init-gaiad.sh
"$script_full_path"/start.sh

export BINARY=gaiad
export CHAINID=juno-test-3
export P2PPORT=36656
export RPCPORT=36657
export RESTPORT=1315
export ROSETTA=7080
export GRPCPORT=7090
export GRPCWEB=7091
export STAKEDENOM=ujuno

"$script_full_path"/init_junod_start.sh
"$script_full_path"/init-junod.sh
"$script_full_path"/start.sh

export BINARY=gaiad
export CHAINID=osmosis-test-4
export P2PPORT=46656
export RPCPORT=46657
export RESTPORT=1314
export ROSETTA=6080
export GRPCPORT=6090
export GRPCWEB=6091
export STAKEDENOM=uosmo

"$script_full_path"/init_osmod_start.sh
"$script_full_path"/init-osmod.sh
"$script_full_path"/start.sh
