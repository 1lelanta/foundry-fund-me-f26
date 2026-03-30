// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../src/fundeMe.sol";
import {MockV3Aggregator} from "./mock/MockV3Aggregator.sol";

contract FundeMeTest is Test{

    FundMe fundme;
    MockV3Aggregator mockPriceFeed;

    uint8 private constant DECIMALS = 8;
    int256 private constant INITIAL_PRICE = 2000e8;
    uint256 private constant SEND_VALUE = 0.1 ether;
    uint256 private constant STARTING_BALANCE = 10 ether;
    address private constant USER = address(1);

    function setUp() external {
        mockPriceFeed = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
        fundme = new FundMe(address(mockPriceFeed));
        vm.deal(USER, STARTING_BALANCE);
    }

    function testMinimumDollarIsFive() public view {
        assertEq(fundme.MINIMUM_USD(), 5e18);
    }

    function testMsgSenderIsOwner() public view {
        assertEq(fundme.i_owner(), address(this));
    }

    function testPriceFeedVersionIsAccurate() public view {
        uint256 version = fundme.getVersion();
        assertEq(version, 0);
    }

    function testFundFailWithoutEnoughEth() public {
        vm.expectRevert();
        fundme.fund();
    }

    function testFundUpdatesFundedDataStructure() public {
        vm.prank(USER);
        fundme.fund{value: SEND_VALUE}();

        uint256 amountFunded = fundme.addressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE);
    }

    function testAddsFunderToArrayOfFunders() public {
        vm.prank(USER);
        fundme.fund{value: SEND_VALUE}();

        address funder = fundme.funders(0);
        assertEq(funder, USER);
    }

    modifier funded() {
        vm.prank(USER);
        fundme.fund{value: SEND_VALUE}();
        _;
    }

    function testOnlyOwnerCanWithdraw() public funded {
        vm.prank(USER);
        vm.expectRevert(NotOwner.selector);
        fundme.withdraw();
    }

    function testWithdrawWithASingleFunder() public funded {
        uint256 startingOwnerBalance = fundme.i_owner().balance;
        uint256 startingFundMeBalance = address(fundme).balance;

        vm.prank(fundme.i_owner());
        fundme.withdraw();

        uint256 endingOwnerBalance = fundme.i_owner().balance;
        uint256 endingFundMeBalance = address(fundme).balance;

        assertEq(endingFundMeBalance, 0);
        assertEq(endingOwnerBalance, startingOwnerBalance + startingFundMeBalance);
    }

    function testWithdrawFromMultipleFunders() public funded {
        uint160 numberOfFunders = 10;
        for (uint160 i = 2; i < numberOfFunders; i++) {
            hoax(address(i), STARTING_BALANCE);
            fundme.fund{value: SEND_VALUE}();
        }

        uint256 startingOwnerBalance = fundme.i_owner().balance;
        uint256 startingFundMeBalance = address(fundme).balance;

        vm.prank(fundme.i_owner());
        fundme.withdraw();

        assertEq(address(fundme).balance, 0);
        assertEq(fundme.i_owner().balance, startingOwnerBalance + startingFundMeBalance);
    }

}