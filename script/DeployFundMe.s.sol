
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import{Script} from "forge-std/Script.sol";
import {FundMe} from "../src/fundeMe.sol";

contract DeployFundMe is Script{
    address private constant SEPOLIA_PRICE_FEED = 0x694AA1769357215DE4FAC081bf1f309aDC325306;

    function run() external{
        vm.startBroadcast();
        FundMe fundme = new FundMe(SEPOLIA_PRICE_FEED);
        vm.stopBroadcast();
    }
}
