// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import "forge-std/Test.sol";
import "../src/ABIEncoder.sol";

/**
 * @title ABIEncoderTest
 * @notice Comprehensive tests targeting 100% coverage for ABIEncoderDemo
 */
contract ABIEncoderTest is Test {
    ABIEncoder private encoder;

    /// @dev Deploy a fresh contract before each test
    function setUp() external {
        encoder = new ABIEncoder();
    }

    /// @dev Pool id must be invariant to token ordering (tokens are sorted internally)
    function test_createPoolIdentifier_SameForBothTokenOrders() external view {
        address tokenA = address(0x1000);
        address tokenB = address(0x2000);
        uint24 fee = 300;

        bytes32 idAB = encoder.createPoolIdentifier(tokenA, tokenB, fee);
        bytes32 idBA = encoder.createPoolIdentifier(tokenB, tokenA, fee);

        assertEq(idAB, idBA, "Tokens are not correctly sorted");
    }
}
