
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;



import{Script} from "forge-std/Script.sol";
import {DevOpsTools} from "devops-tools/DevOpsTools.sol";
import {FundMe} from "../src/fundeMe.sol";

contract FundFundMe is Script{

    function FundFundMe(address mostRecentlyDeployed) public{
        vm.startBroadcast();
        FundMe(mostRecentlyDeployed)

    }

    function run() external{
        address mostRecentlyDeployed= DevOpsTools.get_most_recent_deployment("FundMe",block.chainid);
    }

}

