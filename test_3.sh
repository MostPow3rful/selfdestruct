source .env

NONCE=$(cast nonce $DEPLOYER_ADDRESS --rpc-url $RPC_URL)

CALCULATE_CONTRACT_A_ADDRESS=$(node calculate.js $DEPLOYER_ADDRESS $(expr $NONCE + 1))

echo "$(tput setaf 1)""Address Of Contract [A] Is Going To Be => "$(tput setaf 4)"[$CALCULATE_CONTRACT_A_ADDRESS]""$(tput sgr0)"

CONTRACT_E_ADDRESS=$(forge create src/contracts.sol:E --private-key $PRIVATE_KEY --value 10ether --gas-limit 10000000 --rpc-url $RPC_URL --constructor-args $CALCULATE_CONTRACT_A_ADDRESS | grep "Deployed to" | tr ': ' '\n' | grep -I "0x")

echo "$(tput setaf 1)""Address Of Contract [E] Is => "$(tput setaf 4)"[$CONTRACT_E_ADDRESS]""$(tput sgr0)"

CONTRACT_A_ADDRESS=$(forge create src/contracts.sol:A --private-key $PRIVATE_KEY --rpc-url $RPC_URL | grep "Deployed to" | tr ': ' '\n' | grep -I "0x")

echo "$(tput setaf 1)""Address Of Contract [A] Is => "$(tput setaf 4)"[$CONTRACT_A_ADDRESS]""$(tput sgr0)"

echo "$(tput setaf 1)""Balance Of Contract [E] Is => "$(tput setaf 2)"[$(cast balance $CONTRACT_E_ADDRESS --rpc-url $RPC_URL) wei]""$(tput sgr0)"
echo "$(tput setaf 1)""Balance Of Contract [A] Is => "$(tput setaf 2)"[$(cast balance $CONTRACT_A_ADDRESS --rpc-url $RPC_URL) wei]""$(tput sgr0)"

echo "$(tput setaf 1)""Checking The Contract [E] Is Available OR Not :""$(tput sgr0)"
cast call $CONTRACT_E_ADDRESS "isAvailable()(bool)" --rpc-url $RPC_URL
