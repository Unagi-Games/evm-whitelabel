// SPDX-License-Identifier: MIT
// Unagi Contracts v1.0.0 (NFT.sol)
pragma solidity 0.8.25;

import {Multicall} from "@openzeppelin/contracts/utils/Multicall.sol";
import "./NFT.sol";

/**
 * @title NFTLegacyMulticall
 * @dev Implementation of IERC721. NFT is described using the ERC721Metadata extension.
 * See https://github.com/ethereum/EIPs/blob/34a2d1fcdf3185ca39969a7b076409548307b63b/EIPS/eip-721.md#specification
 * @custom:security-contact security@unagi.ch
 */
contract NFTLegacyMulticall is NFT, Multicall {
    constructor(uint256 initialId, string memory name, string memory symbol) NFT(initialId, name, symbol) {}
}
