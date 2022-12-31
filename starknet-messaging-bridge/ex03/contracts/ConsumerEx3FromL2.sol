// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./interfaces/IStarknetCore.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ConsumerEx3FromL2 is Ownable {
    IStarknetCore starknetCore;

    //it's the core contract to handle the messages call
    //command to get the current contract address:
    //starknet get_contract_addresses --network alpha-goerli
    function setStarknetCoreContract(address starknetCore_) external onlyOwner {
        starknetCore = IStarknetCore(starknetCore_);
    }

    //it receives a message from Starknet Core Contract on L2
    function consumeMessage(uint256 l2ContractAddress, uint256 l2_user) public {
        uint256[] memory payload = new uint256[](1);

        payload[0] = l2_user;

        //receives message from L2
        starknetCore.consumeMessageFromL2(l2ContractAddress, payload);
    }
}
