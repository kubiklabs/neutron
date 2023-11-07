#!/bin/bash
set -e

# Load shell variables
. ./network/hermes/variables.sh

### Configure the clients and connection
echo "Initiating connection handshake..."
echo "Creating connection between neutron and gaia..."
$HERMES_BINARY --config $CONFIG_DIR create connection --a-chain neutron-test-1 --b-chain gaia-test-2
sleep 2

echo "Creating connection between neutron and juno..."
$HERMES_BINARY --config $CONFIG_DIR create connection --a-chain neutron-test-1 --b-chain juno-test-3
sleep 2

echo "Creating connection between neutron and osmo..."
$HERMES_BINARY --config $CONFIG_DIR create connection --a-chain neutron-test-1 --b-chain osmo-test-4
sleep 2

echo "Creating channel between neutron and gaia(connection-0)..."
$HERMES_BINARY --config $CONFIG_DIR create channel --a-chain neutron-test-1 --b-chain gaia-test-2 --a-port transfer --b-port transfer --new-client-connection
sleep 2

echo "Creating channel between neutron and gaia(connection-1)..."
$HERMES_BINARY --config $CONFIG_DIR create channel --a-chain neutron-test-1 --b-chain juno-test-3 --a-port transfer --b-port transfer --new-client-connection
sleep 2

echo "Creating channel between neutron and gaia(connection-4)..."
$HERMES_BINARY --config $CONFIG_DIR create channel --a-chain neutron-test-1 --b-chain osmo-test-4 --a-port transfer --b-port transfer --new-client-connection
sleep 2
