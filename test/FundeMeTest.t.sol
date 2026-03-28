// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {FundMe} from "../src/fundeMe.sol";
import {MockV3Aggregator} from "./mock/MockV3Aggregator.sol";

contract FundeMeTest is Test{

    FundMe fundme;
        MockV3Aggregator mockPriceFeed;

        uint8 private constant DECIMALS = 8;
        int256 private constant INITIAL_PRICE = 2000e8;

    function setUp() external{ 
            mockPriceFeed = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
            fundme  = new FundMe(address(mockPriceFeed));

    }

    function testMinimumDollarIsFive() public{
        assertEq(fundme.MINIMUM_USD(),5e18);

    }
    function testMsgSenderIsOwner() public{
       
        assertEq(fundme.i_owner(),address(this));
    }
    function testPriceFeedVersionIsAccurate() public {
        uint256 version = fundme.getVersion();
        console.log(version);
        assertEq(version, 0);
        
    }


}