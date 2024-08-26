// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {HoneyPotPurchaseOnETH} from "../src/HoneyPotPurchaseOnETH.sol";

contract HoneyPotPurchaseOnETHTest is Test {
    HoneyPotPurchaseOnETH internal contractInstance;
    address internal owner;
    address internal treasuryAddress = address(0x123);
    address internal usdtAddress = address(0x456);
    address internal usdcAddress = address(0x789);

    uint256 internal ethPrice = 0.25 ether;
    uint256 internal commissionRate = 10;
    uint256 internal maxPurchaseLimit = 20;
    address address1 = address(1);

    function setUp() public {
        owner = address(this);
        contractInstance = new HoneyPotPurchaseOnETH(usdtAddress, usdcAddress, treasuryAddress);
    }

    function testBuyWithETH() public {
        uint256 quantity = 1;
        uint256 expectedTotalPrice = ethPrice * quantity;

        vm.deal(address1, 1 ether);
        // Test purchase
        vm.prank(address1);
        contractInstance.buyWithETH{value: expectedTotalPrice}(quantity, payable(address(0)));

        // Assert the purchase was recorded
        assertEq(contractInstance.purchases(address1), quantity, "Should record the purchase quantity");
    }

    // Example test case: Test setting ETH price
    function testSetEthPrice() public {
        uint256 newPrice = 1 ether;
        contractInstance.setEthPrice(newPrice);
        uint256 actualPrice = contractInstance.ethPrice();
        assertEq(actualPrice, newPrice);
    }

    function testReferralSystem() public {
        address referrer = address(0x789);
        address buyer = address(0x101);

        // Update referrer for the buyer
        HoneyPotPurchaseOnETH contractUnderTest = new HoneyPotPurchaseOnETH(usdtAddress, usdcAddress, treasuryAddress);
        contractUnderTest.updateReferrer(buyer, referrer);

        // Make a purchase with a referrer
        uint256 quantity = 1;
        uint256 expectedTotalPrice = ethPrice * quantity;
        contractUnderTest.buyWithETH{value: expectedTotalPrice}(quantity, payable(referrer));

        // Assert the referrer received the commission
        uint256 expectedCommission = (expectedTotalPrice * commissionRate) / 100;
        assertEq(referrer.balance, expectedCommission, "Referrer should receive the commission");
    }

    function testOnlyOwnerCanSetEthPrice() public {
        HoneyPotPurchaseOnETH contractUnderTest = new HoneyPotPurchaseOnETH(usdtAddress, usdcAddress, treasuryAddress);
        uint256 newPrice = 1 ether;

        // Test that only owner can set the price
        contractUnderTest.setEthPrice(newPrice);
        assertEq(contractUnderTest.ethPrice(), newPrice, "ETH price should be updated by the owner");
    }

    function testPurchaseLimit() public {
        HoneyPotPurchaseOnETH contractUnderTest = new HoneyPotPurchaseOnETH(usdtAddress, usdcAddress, treasuryAddress);
        uint256 quantity = maxPurchaseLimit + 1;

        // Attempt to buy beyond the limit
        vm.expectRevert("Purchase limit exceeded");
        contractUnderTest.buyWithETH{value: ethPrice * quantity}(quantity, payable(address(0)));
    }

    function testPauseContract() public {
        HoneyPotPurchaseOnETH contractUnderTest = new HoneyPotPurchaseOnETH(usdtAddress, usdcAddress, treasuryAddress);

        // Pause the contract
        contractUnderTest.pause();
        assertEq(contractUnderTest.paused(), true, "Contract should be paused");

        // Test that buying is not allowed when paused
        vm.expectRevert("Contract is paused");
        contractUnderTest.buyWithETH{value: ethPrice}(1, payable(address(0)));

        // Unpause the contract
        contractUnderTest.unpause();
        assertEq(contractUnderTest.paused(), false, "Contract should be unpaused");
    }
}