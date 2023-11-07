#!/bin/bash
set -e

# Load shell variables
. ./network/hermes/variables.sh

### Sleep is needed otherwise the relayer crashes when trying to init
sleep 1

### Restore Keys
# $HERMES_BINARY --config ./network/hermes/config.toml keys add --key-name testkey_1 --chain neutron-test-1 --mnemonic-file <(echo "alley afraid soup fall idea toss can goose become valve initial strong forward bright dish figure check leopard decide warfare hub unusual join cart")
# sleep 5

# $HERMES_BINARY --config ./network/hermes/config.toml keys add --key-name testkey_2 --chain neutron-test-1 --mnemonic-file <(echo "black frequent sponsor nice claim rally hunt suit parent size stumble expire forest avocado mistake agree trend witness lounge shiver image smoke stool chicken")
# sleep 5

# $HERMES_BINARY --config ./network/hermes/config.toml keys add --key-name testkey_3 --chain gaia-test-2 --mnemonic-file <(echo "record gift you once hip style during joke field prize dust unique length more pencil transfer quit train device arrive energy sort steak upset")
# sleep 5

# $HERMES_BINARY --config ./network/hermes/config.toml keys add --key-name testkey_4 --chain juno-test-3 --mnemonic-file <(echo "click help knock drastic tourist cancel mom winner sort keen poem cross book lady front coin steel chef color few just hockey cable diamond")
# sleep 5

$HERMES_BINARY tx ft-transfer --denom uatom --receiver neutron1m9l358xunhhwds0568za49mzhvuxx9ux8xafx2 --key-name testkey_3 --dst-chain neutron-test-1 --src-chain gaia-test-2 --src-port transfer --src-channel channel-0 --amount 30000000000000
sleep 2

$HERMES_BINARY tx ft-transfer --denom ujuno --receiver neutron1m9l358xunhhwds0568za49mzhvuxx9ux8xafx2 --key-name testkey_4 --dst-chain neutron-test-1 --src-chain juno-test-3 --src-port transfer --src-channel channel-1 --amount 40000000000000
sleep 2

$HERMES_BINARY tx ft-transfer --denom uosmo --receiver neutron1m9l358xunhhwds0568za49mzhvuxx9ux8xafx2 --key-name testkey_5 --dst-chain neutron-test-1 --src-chain osmo-test-4 --src-port transfer --src-channel channel-2 --amount 50000000000000
sleep 2

#  hermes tx ft-transfer [OPTIONS] --dst-chain <DST_CHAIN_ID> --src-chain <SRC_CHAIN_ID> --src-port <SRC_PORT_ID> --src-channel <SRC_CHANNEL_ID> --amount <AMOUNT>