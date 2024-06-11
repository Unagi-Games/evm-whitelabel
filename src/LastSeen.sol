// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

/**
 * @title LastSeen
 * @dev Allow to track when a wallet was seen for the last time.
 * @custom:security-contact security@unagi.ch
 */
contract LastSeen {
    // (wallet => last seen) mapping of last seen timestamps
    mapping(address => uint256) private _lastSeens;

    constructor() {}

    function visit() external {
        _lastSeens[msg.sender] = block.timestamp;

        emit Seen(msg.sender);
    }

    function getLastSeen(address wallet) external view returns (uint256) {
        return _lastSeens[wallet];
    }

    event Seen(address wallet);
}
