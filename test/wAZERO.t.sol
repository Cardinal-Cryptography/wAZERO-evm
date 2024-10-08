// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {WAZERO} from "../src/wAZERO.sol";

contract wAZEROTest is Test {
    error InsufficientBalance();
    error AzeroTransferFailed();
    error InsufficientAllowance();

    WAZERO public wazero;

    function setUp() public {
        wazero = new WAZERO();
        vm.startPrank(address(1));
        vm.deal(address(1), 1 ether);
    }

    function test_InitialSupply() public view {
        assertEq(wazero.totalSupply(), 0);
    }

    function test_Deposit() public {
        wazero.deposit{value: 1000}();
        assertEq(wazero.balanceOf(address(1)), 1000);
        assertEq(wazero.totalSupply(), 1000);
    }

    function test_Withdraw() public {
        wazero.deposit{value: 1000}();
        wazero.withdraw(500);
        assertEq(wazero.balanceOf(address(1)), 500);
        assertEq(wazero.totalSupply(), 500);
    }

    function test_WithdrawNotEnoughTokens() public {
        wazero.deposit{value: 1000}();
        vm.expectRevert(InsufficientBalance.selector);
        wazero.withdraw(1500);
    }

    function test_Transfer() public {
        wazero.deposit{value: 1000}();
        wazero.transfer(address(2), 500);
        assertEq(wazero.balanceOf(address(1)), 500);
        assertEq(wazero.balanceOf(address(2)), 500);
        assertEq(wazero.totalSupply(), 1000);
    }

    function test_TransferNotEnoughTokens() public {
        wazero.deposit{value: 1000}();
        vm.expectRevert(InsufficientBalance.selector);
        wazero.transfer(address(2), 1500);
    }

    function test_TransferFrom() public {
        wazero.deposit{value: 1000}();
        wazero.approve(address(2), 500);
        vm.startPrank(address(2));
        wazero.transferFrom(address(1), address(3), 500);
        assertEq(wazero.balanceOf(address(3)), 500);
        assertEq(wazero.totalSupply(), 1000);
    }

    function test_TransferFromNotEnoughTokens() public {
        wazero.deposit{value: 1000}();
        wazero.approve(address(2), 2000);
        vm.startPrank(address(2));
        vm.expectRevert(InsufficientBalance.selector);
        wazero.transferFrom(address(1), address(3), 1500);
    }

    function test_TransferFromNotEnoughAllowance() public {
        wazero.deposit{value: 1000}();
        wazero.approve(address(2), 500);
        vm.startPrank(address(2));
        vm.expectRevert(InsufficientAllowance.selector);
        wazero.transferFrom(address(1), address(3), 600);
    }

    function test_InfiniteApprove() public {
        wazero.deposit{value: 1000}();
        wazero.approve(address(2), type(uint256).max);
        assertEq(wazero.allowance(address(1), address(2)), type(uint256).max);

        vm.startPrank(address(2));
        wazero.transferFrom(address(1), address(3), 500);

        assertEq(wazero.balanceOf(address(3)), 500);
        assertEq(wazero.allowance(address(1), address(2)), type(uint256).max);
    }
}
