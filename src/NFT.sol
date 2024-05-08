// SPDX-License-Identifier: MIT
// Unagi Contracts v1.0.0 (NFT.sol)
pragma solidity 0.8.25;

import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @title NFT
 * @dev Implementation of IERC721. NFT is described using the ERC721Metadata extension.
 * See https://github.com/ethereum/EIPs/blob/34a2d1fcdf3185ca39969a7b076409548307b63b/EIPS/eip-721.md#specification
 * @custom:security-contact security@unagi.ch
 */
contract NFT is ERC721URIStorage, AccessControl, Pausable {
    bytes32 public constant MINT_ROLE = keccak256("MINT_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    // Counter for token ID
    uint256 private _tokenIds;

    // Base URI
    string private _baseURIValue;

    /**
     * @dev Create NFT contract.
     */
    constructor(uint256 initialId, string memory name, string memory symbol) ERC721(name, symbol) {
        _tokenIds = initialId;

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINT_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721URIStorage, AccessControl)
        returns (bool)
    {
        return ERC721.supportsInterface(interfaceId) || AccessControl.supportsInterface(interfaceId);
    }

    /**
     * @dev Pause token transfers.
     *
     * Requirements:
     *
     * - Caller must have role PAUSER_ROLE.
     */
    function pause() external onlyRole(PAUSER_ROLE) {
        _pause();
    }

    /**
     * @dev Unpause token transfers.
     *
     * Requirements:
     *
     * - Caller must have role PAUSER_ROLE.
     */
    function unpause() external onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    /**
     * @dev Allow to mint a new NFT.
     *
     * Requirements:
     *
     * - Caller must have role MINT_ROLE.
     */
    function safeMint(address to, string memory ipfsMedataURI) public onlyRole(MINT_ROLE) {
        _tokenIds++;
        _safeMint(to, _tokenIds);
        _setTokenURI(_tokenIds, ipfsMedataURI);
    }

    /**
     * @dev Allow to batch mint new NFTs.
     *
     * Requirements:
     *
     * - Caller must have role MINT_ROLE.
     */
    function batchSafeMint(address[] memory to, string[] memory ipfsMedataURI) public onlyRole(MINT_ROLE) {
        require(to.length == ipfsMedataURI.length, "to and ipfsMedataURI array length must match");

        uint256 length = to.length;
        for (uint256 i = 0; i < length;) {
            safeMint(to[i], ipfsMedataURI[i]);
            unchecked {
                ++i;
            }
        }
    }

    /**
     * @dev Allow to set base URI.
     *
     * Requirements:
     *
     * - Caller must have role DEFAULT_ADMIN_ROLE.
     */
    function setBaseURI(string memory baseURIValue) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _baseURIValue = baseURIValue;
    }

    /**
     * @dev Base URI for computing {tokenURI}.
     */
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseURIValue;
    }
}
