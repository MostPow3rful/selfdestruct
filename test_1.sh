source .env

NONCE=$(cast nonce $DEPLOYER_ADDRESS --rpc-url $RPC_URL)

CALCULATE_CONTRACT_B_ADDRESS=$(node calculate.js $DEPLOYER_ADDRESS $(expr $NONCE + 2))

echo "$(tput setaf 1)""Address Of Contract [B] Is Going To Be => "$(tput setaf 4)"[$CALCULATE_CONTRACT_B_ADDRESS]""$(tput sgr0)"

CONTRACT_A_ADDRESS=$(forge create src/contracts.sol:A --private-key $PRIVATE_KEY --value 10ether --gas-limit 10000000 --rpc-url $RPC_URL | grep "Deployed to" | tr ': ' '\n' | grep -I "0x")

echo "$(tput setaf 1)""Address Of Contract [A] Is => "$(tput setaf 4)"[$CONTRACT_A_ADDRESS]""$(tput sgr0)"

echo "$(tput setaf 1)""Balance Of Contract [A] Before calling selfdestruct() => "$(tput setaf 2)"[$(cast balance $CONTRACT_A_ADDRESS --rpc-url $RPC_URL) wei]""$(tput sgr0)"

echo "$(tput setaf 1)""Calling Function In Contract [A] => "$(tput setaf 6)"[start(B)]""$(tput sgr0)"

cast send $CONTRACT_A_ADDRESS "start(address)" $CALCULATE_CONTRACT_B_ADDRESS --private-key $PRIVATE_KEY --rpc-url $RPC_URL &>/dev/null

echo "$(tput setaf 1)""Balance Of Contract [A] After calling selfdestruct() => "$(tput setaf 2)"[$(cast balance $CONTRACT_A_ADDRESS --rpc-url $RPC_URL) wei]""$(tput sgr0)"

CONTRACT_B_ADDRESS=$(forge create src/contracts.sol:B --private-key $PRIVATE_KEY --rpc-url $RPC_URL | grep "Deployed to" | tr ': ' '\n' | grep -I "0x")

echo "$(tput setaf 1)""Address Of Contract [B] Is => "$(tput setaf 4)"[$CONTRACT_B_ADDRESS]""$(tput sgr0)"

echo "$(tput setaf 1)""Balance Of Contract [B] Is => "$(tput setaf 2)"[$(cast balance $CONTRACT_B_ADDRESS --rpc-url $RPC_URL) wei]""$(tput sgr0)"

