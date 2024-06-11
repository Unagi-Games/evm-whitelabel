// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "forge-std/Script.sol";
import {LastSeen} from "@/LastSeen.sol";

contract DeployLastSeen is Script {
    function run() external {
        vm.startBroadcast();
        new LastSeen();
        vm.stopBroadcast();
    }
}
