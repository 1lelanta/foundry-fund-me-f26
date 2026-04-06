-include .env

SEPOLIA_RPC_URL ?= $(SEPOLIA_RPC)
ETHERSCAN_API_KEY ?= $(ETHERESCAN_API_KEY)

build:;forge build

deploy-sepolia:
	@test -n "$(SEPOLIA_RPC_URL)" || (echo "Missing RPC URL: set SEPOLIA_RPC_URL (or SEPOLIA_RPC) in .env" && exit 1)
	@test -n "$(PRIVATE_KEY)" || (echo "Missing PRIVATE_KEY in .env" && exit 1)
	@test -n "$(ETHERSCAN_API_KEY)" || (echo "Missing ETHERSCAN_API_KEY (or ETHERESCAN_API_KEY) in .env" && exit 1)
	forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv