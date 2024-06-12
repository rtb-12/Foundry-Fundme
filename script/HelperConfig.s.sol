// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.19;

import {MockV3Aggregator} from "test/mock/MockV3Aggregator.sol";
import {Script} from "forge-std/Script.sol";

contract HelpConfig is Script {

    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    struct NetworkConfig {
        address priceFeed;
    }

    NetworkConfig public networkConfig;

    constructor (){
        if(block.chainid == 11155111){
            networkConfig = getSepoliaEthConfig();
        } else {
            networkConfig = getOrCreateAnvilEthConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory _networkConfig= NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });

        return _networkConfig;
    } 

    function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory) {
        if(networkConfig.priceFeed != address(0)){
            return networkConfig;
        }
       vm.startBroadcast();
       MockV3Aggregator mockPriceFeed = new MockV3Aggregator(DECIMALS,INITIAL_PRICE);
       vm.stopBroadcast();

         NetworkConfig memory _networkConfig= NetworkConfig({
                priceFeed: address(mockPriceFeed)
          });
    
          return _networkConfig;

    }
    
}