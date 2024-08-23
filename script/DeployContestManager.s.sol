// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {ContestManager} from "../src/ContestManager.sol";
import {Script, console} from "lib/forge-std/src/Script.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";

contract DeployContestManager is Script {
    ContestManager public contestManager;

    function run() external returns (address) {
        ContestManager conMan = new ContestManager();
        console.log("Contest Manager Address 2: ", address(conMan));
        console.log("Deployer Address: ", address(this));
        return (address(conMan));
    }
}
