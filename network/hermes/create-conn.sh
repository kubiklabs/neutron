#!/bin/bash
set -e

# Load shell variables
. ./network/hermes/variables.sh

### Configure the clients and connection
echo "Initiating connection handshakegaia-neutron..."
$HERMES_BINARY --config $CONFIG_DIR create connection --a-chain neutron-test-1 --b-chain gaia-test-2

sleep 2
$HERMES_BINARY --config $CONFIG_DIR create channel --a-chain neutron-test-1 --a-connection connection-0 --a-port transfer --b-port transfer


echo "Initiating connection handshake neutron-juno..."
$HERMES_BINARY --config $CONFIG_DIR create connection --a-chain neutron-test-1 --b-chain juno-test-3

sleep 2
$HERMES_BINARY --config $CONFIG_DIR create channel --a-chain neutron-test-1 --a-connection connection-1 --a-port transfer --b-port transfer
