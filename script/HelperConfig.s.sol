// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;


import{Script} from "forge-std/Script.sol";

contract HelperConfig is Script{

    struct NewtorkConfig{
        address priceFeed;
    }

// pure keyword indicates that the function does not read or modify the state of the contract.
// think of it as a function only performing calculations based on its input paramers always the input gives the same output
    function getSepoliaEthConfig(NewtorkConfig memory) public pure {

    }

    function getAnvilEthConfig(NewtorkConfig memory) public pure{

    }
}