// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./interfaces/IStarknetCore.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ReceiveMessageFromL2 is Ownable {
    IStarknetCore starknetCore;

    uint256 private EvaluatorContractAddress;
    uint256 public Ex02Selector;

    //set evaluator contract
    //it's the core contract to handle the messages call
    //command to get the current contract address:
    //starknet get_contract_addresses --network alpha-goerli
    function setStarknetCoreContract(address starknetCore_) external onlyOwner {
        starknetCore = IStarknetCore(starknetCore_);
    }

    //set evaluator contract
    //it's a L2 contract
    function setEvaluatorContractAddress(
        uint256 _evaluatorContractAddress
    ) external onlyOwner {
        EvaluatorContractAddress = _evaluatorContractAddress;
    }

    //sets selector
    //selector is the selector for the handler to be invoked, it determines what function to call in the corresponding L2 contract
    //the selector can found by passing the function name (ex2 in this case) to https://util.turbofish.co/ or using a script (ex.: python get_selector.py)
    //(selector for ex2 is: 897827374043036985111827446442422621836496526085876968148369565281492581228)
    function setSelector(uint256 _selector) external onlyOwner {
        Ex02Selector = _selector;
    }

    //it sends a message calling sendMessageToL2() from Starknet Core Contract
    function sendFromThisContractToL2(uint256 l2_user) public {
        uint256[] memory payload = new uint256[](1);

        payload[0] = l2_user;

        //send the message to the StarkNet core contract
        //sendMessageToL2() arguments:
        //sendMessageToL2(uint256 to_address, uint256 selector, uint256[] calldata payload)
        //  to_address is the L2 contract address
        //  selector is the selector for the handler to be invoked, it determines what function to call in the corresponding L2 contract
        //  payload
        starknetCore.sendMessageToL2(
            EvaluatorContractAddress,
            Ex02Selector,
            payload
        );
    }
}
