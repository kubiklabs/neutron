#!/bin/bash
set -e

BINARY=${BINARY:-gaiad}
BASE_DIR=./data
CHAINID=${CHAINID:-juno-test-3}
CHAIN_DIR="$BASE_DIR/$CHAINID"

STAKEDENOM=${STAKEDENOM:-ujuno}

echo "Creating and collecting gentx..."
$BINARY gentx val1 "7000000000$STAKEDENOM" --home "$CHAIN_DIR" --chain-id "$CHAINID" --keyring-backend test
$BINARY collect-gentxs --home "$CHAIN_DIR"

# sed -i -e 's/\"allow_messages\":.*/\"allow_messages\": [\"\/cosmos.bank.v1beta1.MsgSend\", \"\/cosmos.staking.v1beta1.MsgDelegate\", \"\/cosmos.staking.v1beta1.MsgUndelegate\"]/g' "$CHAIN_DIR/config/genesis.json"


sed -i -e 's/\"allow_messages\":.*/\"allow_messages\": [\"\/cosmos.bank.v1beta1.MsgSend\", \"\/cosmos.staking.v1beta1.MsgDelegate\", \"\/cosmos.gov.v1beta1.MsgSubmitProposal\"]/g' "$CHAIN_DIR/config/genesis.json"
sed -i "s/cors_allowed_origins = \[\]/cors_allowed_origins = \[\"\*\"\]/" "$CHAIN_DIR/config/config.toml"
sed -i "s/enabled-unsafe-cors = false/enabled-unsafe-cors = true/" "$CHAIN_DIR/config/app.toml"