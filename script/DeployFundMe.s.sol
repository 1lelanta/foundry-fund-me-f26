
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import{Script} from "forge-std/Script.sol";
import {FundMe} from "../src/fundeMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script{
    

    function run() external{
        HelperConfig HelperConfig = new HelperConfig();
        address ethUsdPriceFeed = HelperConfig.activeNetworkConfig();
        vm.startBroadcast();
        FundMe fundme = new FundMe(SEPOLIA_PRICE_FEED);
        vm.stopBroadcast();
    }
}
