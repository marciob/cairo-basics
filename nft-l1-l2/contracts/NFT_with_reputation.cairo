%lang starknet

from openzeppelin.token.erc721.ERC721_Mintable_Burnable import constructor

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.messages import send_message_to_l1

const L1_CONTRACT_ADDRESS = (
    L1_MESSAGING_CONTRACT)
const MESSAGE_REP_DOWN = 0

# A mapping from a nftId (L1 Ethereum address) to their reputation.
@storage_var
func reputation(nftId : felt) -> (res : felt):
end

@view
func get_rep{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    nftId : felt
) -> (reputation : felt):
    let (res) = reputation.read(nftId=nftId)
    return (res)
end

@external
func rep_up{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    nftId : felt, points : felt
):
    let (res) = reputation.read(nftId=nftId)
    reputation.write(nftId, res + points)
    return ()
end

@external
func rep_down{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    nftId : felt, points : felt
):

    let (res) = reputation.read(nftId=nftId)
    tempvar new_reputation = res - points

    # Update the new reputation.
    reputation.write(nftId, new_reputation)

    # Send the rep down message.
    let (message_payload : felt*) = alloc()
    assert message_payload[0] = MESSAGE_REP_DOWN
    assert message_payload[1] = nftId
    assert message_payload[2] = points
    send_message_to_l1(to_address=L1_CONTRACT_ADDRESS, payload_size=3, payload=message_payload)

    return ()
end

@l1_handler
func repUp{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    from_address : felt, nftId : felt, points : felt
):
    # Make sure the message was sent by the intended L1 contract.
    assert from_address = L1_CONTRACT_ADDRESS

    # Read the current reputation.
    let (res) = reputation.read(nftId=nftId)

    # Compute and update the new reputation.
    tempvar new_reputation = res + points
    reputation.write(nftId, new_reputation)

    return ()
end
