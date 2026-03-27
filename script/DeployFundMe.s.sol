
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import{Script} from "forge-std/Script.sol";
import {FundMe} from "../src/fundeMe.sol";

contract DeployFundMe is Script{
    function run() external{
        vm.startBroadcast();
        FundMe fundme = new FundMe();
        vm.stopBroadcast();
    }
}
