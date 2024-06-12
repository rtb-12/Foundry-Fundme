// SPDX-License-Identifier: MIT License

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelpConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
    HelpConfig helpConfig = new HelpConfig();
    address priceFeed = helpConfig.networkConfig();
    vm.startBroadcast();
    FundMe fundMe = new  FundMe(priceFeed);
    vm.stopBroadcast();
    return fundMe;
    }
}
