#!/bin/bash
set -e

# Load shell variables
. ./network/hermesj/variables.sh

### Sleep is needed otherwise the relayer crashes when trying to init
sleep 1

### Restore Keys
$HERMES_BINARY --config ./network/hermesj/config.toml keys delete --chain neutron-test-1 --all
$HERMES_BINARY --config ./network/hermesj/config.toml keys add --key-name testkey_1 --chain neutron-test-1 --mnemonic-file <(echo "alley afraid soup fall idea toss can goose become valve initial strong forward bright dish figure check leopard decide warfare hub unusual join cart")
sleep 5

$HERMES_BINARY --config ./network/hermesj/config.toml keys delete --chain juno-test-3 --all
$HERMES_BINARY --config ./network/hermesj/config.toml keys add --key-name testkey_3 --chain juno-test-3 --mnemonic-file <(echo "black frequent sponsor nice claim rally hunt suit parent size stumble expire forest avocado mistake agree trend witness lounge shiver image smoke stool chicken")
sleep 5