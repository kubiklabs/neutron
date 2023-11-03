#!/bin/bash

# Load shell variables
. ./network/hermesj/variables.sh

# Start the hermes relayer in multi-paths mode
echo "Starting hermes relayer..."
$HERMES_BINARY --config $CONFIG_DIR start