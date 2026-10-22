// SPDX-License-Identifier: MIT
pragma solidity 0.8.38;

/**
 * @title abi-encoder
 * @author jdresdev
 * @dev Shows different uses of abi.encodePacked in DeFi protocols
 */
contract ABIEncoder {
    // Events to show the codification
    event DataEncoded(bytes32 indexed hash, bytes encodedData);
    event PoolIdentifier(bytes32 indexed poolId, address token, uint256 rate);
    event UserPositionEncoded(
        bytes32 indexed positionId,
        address user,
        uint256 amount
    );

    /**
     * @dev Encodes the pool parameters
     * @param tokenA First pool token
     * @param tokenB Second pool token
     * @param fee pool fee
     * @return poolId identifier (unique for this pool)
     */
    function createPoolIdentifier(
        address tokenA,
        address tokenB,
        uint24 fee
    ) external pure returns (bytes32 poolId) {
        // We order the tokens
        (address token0, address token1) = tokenA < tokenB
            ? (tokenA, tokenB)
            : (tokenB, tokenA);

        // Use of ABI.ENCODEPACKED: Create unique pool identifier
        poolId = keccak256(abi.encodePacked(token0, token1, fee));
    }

    /**
     * @dev Encodes data for a trading position
     * @param user User address
     * @param tokenIn Input token
     * @param tokenOut Output token
     * @param amountIn Input amount
     * @param minAmountOut Minimum output amount
     * @return positionId Position identifier
     * @return encodedData Encoded position data
     */
    function encodeTradingPosition(
        address user,
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 minAmountOut
    ) external view returns (bytes32 positionId, bytes memory encodedData) {
        // Encode the position data
        encodedData = abi.encodePacked(user, tokenIn, tokenOut, amountIn, minAmountOut, block.timestamp);
    }
}
