// Write a contract on L2 that will send a message to L1 MessagingNft contract and trigger createNftFromL2 contract
// Your function should be called create_l1_nft_message

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.starknet.common.messages import send_message_to_l1

// MessagingNft contract on L1
const l1_contract_address = 0x6DD77805FD35c91EF6b2624Ba538Ed920b8d0b4E;

// this function send a message to a L1 contract
// l1_user is the Ethereum L1 user address (EOA)
// l1_user is passed as argument in this function to indicate the L1 Ethereum user address
// l1_user EOA will call createNftFromL2 function from MessagingNft contract on L1
// l1_user will be passed as argument of ex1a function on Evaluator contract on L2
@external
func create_l1_nft_message{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    l1_user : felt
) {
    // creating payload
    let (message_payload_: felt*) = alloc();
    assert message_payload_[0] = l1_user;

    // sending the message
    send_message_to_l1(to_address=l1_contract_address, payload_size=1, payload=message_payload_);

    return ();
}
