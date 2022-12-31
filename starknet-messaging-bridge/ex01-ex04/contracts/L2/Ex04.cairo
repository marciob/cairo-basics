// Write a L2 contract that is able to receive a message from ex4 of L1 Evaluator
// You can name your function however you like, since you provide the function selector as a parameter on L1

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.starknet.common.messages import send_message_to_l1


const l1_evaluator_address = 0x8055d587A447AE186d1589F7AAaF90CaCCc30179;

@storage_var
func l1_assigned_var_storage() -> (assigned_var : felt){
}

@view
func l1_assigned_var{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (assigned_var : felt){
    let (assigned_var) = l1_assigned_var_storage.read();
    return (assigned_var,);
}

//handler to receive L1 message
//the function can have any name, since you provide the function selector as a parameter on L1
@l1_handler
func ex4{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    from_address : felt, rand_value : felt
){
    // Check L1 sender
    with_attr error_message("Message was not sent by the official L1 contract"){
        assert from_address = l1_evaluator_address;
    }
    // write value in the storage
    l1_assigned_var_storage.write(rand_value);
    return ();
}
