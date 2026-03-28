// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;


import{Script} from "forge-std/Script.sol";

contract HelperConfig is Script{

    NewtorkConfig public activeNetworkConfig;

    struct NewtorkConfig{
        address priceFeed;
    }

    constructor(){
        if(block.chainid == 11155111){
            activeNetworkConfig = getSepoliaEthConfig();
        }
        else{
            activeNetworkConfig = getAnvilEthConfig();
        }
    }

// pure keyword indicates that the function does not read or modify the state of the contract.
// think of it as a function only performing calculations based on its input paramers always the input gives the same output
    function getSepoliaEthConfig(NewtorkConfig memory) public pure returns(NewtorkConfig memory){
        NewtorkConfig memory sepoliaConfig = new NewtorkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return sepoliaConfig;
    }

    function getAnvilEthConfig(NewtorkConfig memory) public pure{

    }
}