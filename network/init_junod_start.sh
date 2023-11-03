#!/bin/bash
set -e

BINARY=${BINARY:-neutrond}
BASE_DIR=./data
CHAINID=${CHAINID:-neutron-test-1}
STAKEDENOM=${STAKEDENOM:-untrn}
IBCATOMDENOM=${IBCATOMDENOM:-uibcatom}
IBCUSDCDENOM=${IBCUSDCDENOM:-uibcusdc}
CHAIN_DIR="$BASE_DIR/$CHAINID"
# unbonding time and voting period,
DURATION=3600s
PREFIX=juno
P2PPORT=${P2PPORT:-26656}
RPCPORT=${RPCPORT:-26657}
RESTPORT=${RESTPORT:-1317}
ROSETTA=${ROSETTA:-8081}

VAL_MNEMONIC_1="clock post desk civil pottery foster expand merit dash seminar song memory figure uniform spice circle try happy obvious trash crime hybrid hood cushion"
VAL_MNEMONIC_2="angry twist harsh drastic left brass behave host shove marriage fall update business leg direct reward object ugly security warm tuna model broccoli choice"
DEMO_MNEMONIC_1="banner spread envelope side kite person disagree path silver will brother under couch edit food venture squirrel civil budget number acquire point work mass"
DEMO_MNEMONIC_2="veteran try aware erosion drink dance decade comic dawn museum release episode original list ability owner size tuition surface ceiling depth seminar capable only"
DEMO_MNEMONIC_3="obscure canal because tomorrow tribe sibling describe satoshi kiwi upgrade bless empty math trend erosion oblige donate label birth chronic hazard ensure wreck shine"
DEMO_MNEMONIC_4="orange shaft abandon find six fluid release picnic library waste inflict velvet physical clerk manual rookie cargo gown vendor museum dove brain runway people"
DEMO_MNEMONIC_5="labor add oven alone pride disease imitate february smooth pudding grain seat slim slice gown matrix citizen extra vessel increase release settle boring chair"
DEMO_MNEMONIC_6="member deal deputy vague embody truck ozone pull unique picture say tool rabbit ripple raise garlic point thunder level clinic toddler avocado knee maze"
DEMO_MNEMONIC_7="tower crazy oblige owner chimney snow blanket sunny clown hotel exit raise circle cage stumble crush quiz scorpion broken door drill blue dance alley"
DEMO_MNEMONIC_8="major sorry fine subject thumb camp vintage jacket valley hold bronze thought crime slow point either cycle supply buzz major style powder effort chief"
DEMO_MNEMONIC_9="corn order odor cart relax practice wrestle gravity ankle category exile surface mule clay message quote cushion possible aspect ensure hazard slow torch repeat"
DEMO_MNEMONIC_10="symptom camera collect dismiss screen wagon club maid math slim awkward joy human inch orbit sing display nice gentle gauge object pride salmon forget"
DEMO_MNEMONIC_11="half sauce cupboard card audit fitness replace entire crack exile audit brave delay exhaust embark like afraid mountain critic custom glimpse load grunt ugly"
DEMO_MNEMONIC_12="region sure orchard robust asset maximum output genre stand hurt dilemma disease accuse truth cargo approve foster pear two great bonus life bracket brief"
DEMO_MNEMONIC_13="miss win girl project sponsor want theme absorb olympic survey axis rate exercise blue reunion know affair velvet verify model crop ticket wave photo"
DEMO_MNEMONIC_14="relax major water toddler side dash danger cliff island denial border aisle pepper poverty scheme camp journey idle act kind pill praise exchange solution"
DEMO_MNEMONIC_15="click help knock drastic tourist cancel mom winner sort keen poem cross book lady front coin steel chef color few just hockey cable diamond"
RLY_MNEMONIC_1="alley afraid soup fall idea toss can goose become valve initial strong forward bright dish figure check leopard decide warfare hub unusual join cart"
RLY_MNEMONIC_2="record gift you once hip style during joke field prize dust unique length more pencil transfer quit train device arrive energy sort steak upset"
RLY_MNEMONIC_3="black frequent sponsor nice claim rally hunt suit parent size stumble expire forest avocado mistake agree trend witness lounge shiver image smoke stool chicken"

# Stop if it is already running
if pgrep -x "$BINARY" >/dev/null; then
    echo "Terminating $BINARY..."
    killall "$BINARY"
fi

echo "Removing previous data..."
rm -rf "$CHAIN_DIR" &> /dev/null

# Add directories for both chains, exit if an error occurs
if ! mkdir -p "$CHAIN_DIR" 2>/dev/null; then
    echo "Failed to create chain folder. Aborting..."
    exit 1
fi

echo "Initializing $CHAINID..."
$BINARY init test --home "$CHAIN_DIR" --chain-id="$CHAINID"



echo "Adding genesis accounts..."
echo "$VAL_MNEMONIC_1" | $BINARY keys add val1 --home "$CHAIN_DIR" --recover --keyring-backend=test
echo "$VAL_MNEMONIC_2" | $BINARY keys add val2 --home "$CHAIN_DIR" --recover --keyring-backend=test
echo "$DEMO_MNEMONIC_1" | $BINARY keys add demowallet1 --home "$CHAIN_DIR" --recover --keyring-backend=test
echo "$DEMO_MNEMONIC_2" | $BINARY keys add demowallet2 --home "$CHAIN_DIR" --recover --keyring-backend=test
echo "$DEMO_MNEMONIC_3" | $BINARY keys add demowallet3 --home "$CHAIN_DIR" --recover --keyring-backend=test
echo "$DEMO_MNEMONIC_4" | $BINARY keys add demowallet4 --home "$CHAIN_DIR" --recover --keyring-backend=test
echo "$DEMO_MNEMONIC_5" | $BINARY keys add demowallet5 --home "$CHAIN_DIR" --recover --keyring-backend=test
echo "$DEMO_MNEMONIC_6" | $BINARY keys add demowallet6 --home "$CHAIN_DIR" --recover --keyring-backend=test
echo "$DEMO_MNEMONIC_7" | $BINARY keys add demowallet7 --home "$CHAIN_DIR" --recover --keyring-backend=test
echo "$DEMO_MNEMONIC_8" | $BINARY keys add demowallet8 --home "$CHAIN_DIR" --recover --keyring-backend=test
echo "$DEMO_MNEMONIC_9" | $BINARY keys add demowallet9 --home "$CHAIN_DIR" --recover --keyring-backend=test
echo "$DEMO_MNEMONIC_10" | $BINARY keys add demowallet10 --home "$CHAIN_DIR" --recover --keyring-backend=test
echo "$DEMO_MNEMONIC_11" | $BINARY keys add demowallet11 --home "$CHAIN_DIR" --recover --keyring-backend=test
echo "$DEMO_MNEMONIC_12" | $BINARY keys add demowallet12 --home "$CHAIN_DIR" --recover --keyring-backend=test
echo "$DEMO_MNEMONIC_13" | $BINARY keys add demowallet13 --home "$CHAIN_DIR" --recover --keyring-backend=test
echo "$DEMO_MNEMONIC_14" | $BINARY keys add demowallet14 --home "$CHAIN_DIR" --recover --keyring-backend=test
echo "$DEMO_MNEMONIC_15" | $BINARY keys add demowallet15 --home "$CHAIN_DIR" --recover --keyring-backend=test
echo "$RLY_MNEMONIC_1" | $BINARY keys add rly1 --home "$CHAIN_DIR" --recover --keyring-backend=test
echo "$RLY_MNEMONIC_2" | $BINARY keys add rly2 --home "$CHAIN_DIR" --recover --keyring-backend=test
echo "$RLY_MNEMONIC_3" | $BINARY keys add rly3 --home "$CHAIN_DIR" --recover --keyring-backend=test

$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show val1 --keyring-backend test -a)" "100000000000000$STAKEDENOM"  --home "$CHAIN_DIR"
$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show val2 --keyring-backend test -a)" "100000000000000$STAKEDENOM"  --home "$CHAIN_DIR"
$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show demowallet1 --keyring-backend test -a)" "100000000000000$STAKEDENOM,100000000000000$IBCATOMDENOM,100000000000000$IBCUSDCDENOM"  --home "$CHAIN_DIR"
$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show demowallet2 --keyring-backend test -a)" "100000000000000$STAKEDENOM,100000000000000$IBCATOMDENOM,100000000000000$IBCUSDCDENOM"  --home "$CHAIN_DIR"
$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show demowallet3 --keyring-backend test -a)" "100000000000000$STAKEDENOM,100000000000000$IBCATOMDENOM,100000000000000$IBCUSDCDENOM"  --home "$CHAIN_DIR"
$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show demowallet4 --keyring-backend test -a)" "100000000000000$STAKEDENOM,100000000000000$IBCATOMDENOM,100000000000000$IBCUSDCDENOM"  --home "$CHAIN_DIR"
$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show demowallet5 --keyring-backend test -a)" "100000000000000$STAKEDENOM,100000000000000$IBCATOMDENOM,100000000000000$IBCUSDCDENOM"  --home "$CHAIN_DIR"
$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show demowallet6 --keyring-backend test -a)" "100000000000000$STAKEDENOM,100000000000000$IBCATOMDENOM,100000000000000$IBCUSDCDENOM"  --home "$CHAIN_DIR"
$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show demowallet7 --keyring-backend test -a)" "100000000000000$STAKEDENOM,100000000000000$IBCATOMDENOM,100000000000000$IBCUSDCDENOM"  --home "$CHAIN_DIR"
$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show demowallet8 --keyring-backend test -a)" "100000000000000$STAKEDENOM,100000000000000$IBCATOMDENOM,100000000000000$IBCUSDCDENOM"  --home "$CHAIN_DIR"
$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show demowallet9 --keyring-backend test -a)" "100000000000000$STAKEDENOM,100000000000000$IBCATOMDENOM,100000000000000$IBCUSDCDENOM"  --home "$CHAIN_DIR"
$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show demowallet10 --keyring-backend test -a)" "100000000000000$STAKEDENOM,100000000000000$IBCATOMDENOM,100000000000000$IBCUSDCDENOM"  --home "$CHAIN_DIR"
$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show demowallet11 --keyring-backend test -a)" "100000000000000$STAKEDENOM,100000000000000$IBCATOMDENOM,100000000000000$IBCUSDCDENOM"  --home "$CHAIN_DIR"
$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show demowallet12 --keyring-backend test -a)" "100000000000000$STAKEDENOM,100000000000000$IBCATOMDENOM,100000000000000$IBCUSDCDENOM"  --home "$CHAIN_DIR"
$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show demowallet13 --keyring-backend test -a)" "100000000000000$STAKEDENOM,100000000000000$IBCATOMDENOM,100000000000000$IBCUSDCDENOM"  --home "$CHAIN_DIR"
$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show demowallet14 --keyring-backend test -a)" "100000000000000$STAKEDENOM,100000000000000$IBCATOMDENOM,100000000000000$IBCUSDCDENOM"  --home "$CHAIN_DIR"
$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show demowallet15 --keyring-backend test -a)" "100000000000000$STAKEDENOM,100000000000000$IBCATOMDENOM,100000000000000$IBCUSDCDENOM"  --home "$CHAIN_DIR"
$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show rly1 --keyring-backend test -a)" "100000000000000$STAKEDENOM"  --home "$CHAIN_DIR"
$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show rly2 --keyring-backend test -a)" "100000000000000$STAKEDENOM"  --home "$CHAIN_DIR"
$BINARY add-genesis-account "$($BINARY --home "$CHAIN_DIR" keys show rly3 --keyring-backend test -a)" "100000000000000$STAKEDENOM"  --home "$CHAIN_DIR"


sed -i -e 's/timeout_commit = "5s"/timeout_commit = "1s"/g' "$CHAIN_DIR/config/config.toml"
sed -i -e 's/timeout_propose = "3s"/timeout_propose = "1s"/g' "$CHAIN_DIR/config/config.toml"
sed -i -e 's/index_all_keys = false/index_all_keys = true/g' "$CHAIN_DIR/config/config.toml"
sed -i -e 's/enable = false/enable = true/g' "$CHAIN_DIR/config/app.toml"
sed -i -e 's/swagger = false/swagger = true/g' "$CHAIN_DIR/config/app.toml"
sed -i -e "s/minimum-gas-prices = \"\"/minimum-gas-prices = \"0.0025$STAKEDENOM,0.0025ibc\/27394FB092D2ECCD56123C74F36E4C1F926001CEADA9CA97EA622B25F41E5EB2\"/g" "$CHAIN_DIR/config/app.toml"
sed -i -e 's/enabled = false/enabled = true/g' "$CHAIN_DIR/config/app.toml"
sed -i -e 's/prometheus-retention-time = 0/prometheus-retention-time = 1000/g' "$CHAIN_DIR/config/app.toml"

sed -i -e 's#"tcp://0.0.0.0:26656"#"tcp://0.0.0.0:'"$P2PPORT"'"#g' "$CHAIN_DIR/config/config.toml"
sed -i -e 's#"tcp://127.0.0.1:26657"#"tcp://0.0.0.0:'"$RPCPORT"'"#g' "$CHAIN_DIR/config/config.toml"
sed -i -e 's#"tcp://0.0.0.0:1317"#"tcp://0.0.0.0:'"$RESTPORT"'"#g' "$CHAIN_DIR/config/app.toml"
sed -i -e 's#":8080"#":'"$ROSETTA_1"'"#g' "$CHAIN_DIR/config/app.toml"

GENESIS_FILE="$CHAIN_DIR/config/genesis.json"
sed -i "s/\"cosmos1/\"juno1/g" "$GENESIS_FILE"

$BINARY --home "$CHAIN_DIR" keys show val1 --keyring-backend test -a
$BINARY --home "$CHAIN_DIR" keys show val2 --keyring-backend test -a
$BINARY --home "$CHAIN_DIR" keys show demowallet1 --keyring-backend test -a
$BINARY --home "$CHAIN_DIR" keys show demowallet2 --keyring-backend test -a
$BINARY --home "$CHAIN_DIR" keys show demowallet3 --keyring-backend test -a
$BINARY --home "$CHAIN_DIR" keys show demowallet4 --keyring-backend test -a
$BINARY --home "$CHAIN_DIR" keys show demowallet5 --keyring-backend test -a
$BINARY --home "$CHAIN_DIR" keys show demowallet6 --keyring-backend test -a
$BINARY --home "$CHAIN_DIR" keys show demowallet7 --keyring-backend test -a
$BINARY --home "$CHAIN_DIR" keys show demowallet8 --keyring-backend test -a
$BINARY --home "$CHAIN_DIR" keys show demowallet9 --keyring-backend test -a
$BINARY --home "$CHAIN_DIR" keys show demowallet10 --keyring-backend test -a
$BINARY --home "$CHAIN_DIR" keys show demowallet11 --keyring-backend test -a
$BINARY --home "$CHAIN_DIR" keys show demowallet12 --keyring-backend test -a
$BINARY --home "$CHAIN_DIR" keys show demowallet13 --keyring-backend test -a
$BINARY --home "$CHAIN_DIR" keys show demowallet14 --keyring-backend test -a
$BINARY --home "$CHAIN_DIR" keys show demowallet15 --keyring-backend test -a
$BINARY --home "$CHAIN_DIR" keys show rly1 --keyring-backend test -a
$BINARY --home "$CHAIN_DIR" keys show rly2 --keyring-backend test -a
$BINARY --home "$CHAIN_DIR" keys show rly3 --keyring-backend test -a


sed -i -e "s/\"denom\": \"stake\",/\"denom\": \"$STAKEDENOM\",/g" "$GENESIS_FILE"
sed -i -e "s/\"mint_denom\": \"stake\",/\"mint_denom\": \"$STAKEDENOM\",/g" "$GENESIS_FILE"
sed -i -e "s/\"bond_denom\": \"stake\"/\"bond_denom\": \"$STAKEDENOM\"/g" "$GENESIS_FILE"

# Set voting period and unbonding time
sed -i "s/\"voting_period\": \"172800s\"/\"voting_period\": \"$DURATION\"/g" "$GENESIS_FILE"
sed -i "s/\"unbonding_time\": \"1814400s\"/\"unbonding_time\": \"$DURATION\"/g" "$GENESIS_FILE"