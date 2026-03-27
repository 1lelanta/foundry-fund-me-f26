// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {FundMe} from "../src/fundeMe.sol";

contract FundeMeTest is Test{

    FundMe fundme;
    function setUp() external{ 
      fundme  = new FundMe();

    }

    function testMinimumDollarIsFive() public{
        assertEq(fundme.MINIMUM_USD(),5e18);

    }
    function testMsgSenderIsOwner() public{
       
        assertEq(fundme.i_owner(),address(this));
    }


}