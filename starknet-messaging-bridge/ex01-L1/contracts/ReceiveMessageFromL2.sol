// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./interfaces/IStarknetCore.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ReceiveMessageFromL2 is Ownable {
    IStarknetCore starknetCore;

    uint256 private EvaluatorContractAddress;

    function setEvaluatorContractAddress(uint256 _evaluatorContractAddress)
        external
        onlyOwner
    {
        EvaluatorContractAddress = _evaluatorContractAddress;
    }

    function sendFromThisContractToL2() public {
        //send the message to the StarkNet core contract
        //sendMessageToL2() arguments:
        //sendMessageToL2(uint256 to_address, uint256 selector, uint256[] calldata payload)
        //  to_address is the L2 contract address
        //  selector is the selector for the handler to be invoked
        //  payload
        starknetCore.sendMessageToL2(
            EvaluatorContractAddress,
            CLAIM_SELECTOR,
            sender_payload
        );
    }
}
