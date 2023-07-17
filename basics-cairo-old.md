#### division <br>

it’s weird because it sometimes doesn’t return precise number <br>
for example, sometimes it returns 0.3333333… <br>
in those case that number isn’t in the modular line <br>
it’s even a infinite number that computer can’t represent <br>
to solve that, most language does an approximated number, a rounded number <br>

#### felt

field element <br>
the basic primitive of Cairo <br>
cairo doesn’t have uint types <br>
it’s an integer in the range of -P/e < x < P/2
0 < x < P <br>
any number higher than zero and less than prime number P <br>

#### zero knowledge proof system

proof system with a secret information that the prover knows, but the verifier don’t know, but even that the verifier can verify that information is correct without know the information <br>

#### interactive proof system

it’s allows the prover and the verifier communicates
messages are sent bidirectionally <br>

#### non-interactive proof system

it’s when the communication is only in one direction <br>
it isn’t a system used by Starknet <br>

#### succinct

it’s proof system that allows the verifier to verify very faster without re-execute the program <br>

#### snarks

stands for: succint non-interactive arguments of knowledge <br>

#### starks:

stands for: scalable transparent arguments of knowledge <br>

#### sequencers

sequencers process transactions <br>
they include in a block <br>
it’s like nodes in a PoW <br>
but sequencers don’t have to worry about proofing <br>
they have a complete copy of the state, each one runs an instance of ZKVM (ZK Virtual Machine) <br>
usually machines are much more powerfull than Ethereum node machines (when in a PoW) <br>
there are much less machines than in a PoW <br>
zk can has much less sequencers and still be secure without risk of failures by lack of enough decentralization <br>
so it can have much more advanced machines <br>
ethereum EVM has a very limited gas amount per block to avoid be necessary to have advanced machines
that choice was made to have more decentralization <br>

#### provers (Sharp)

it does a proof generation <br>
the proof is sent to ethereum L1 <br>
there is a verifier contract on ethereum to validate that proof <br>

#### verifier

it’s a smart contract on ethereum to verify the proof generation <br>

#### state diff

it’s the minimum amount of information that’s necessary to know how the state changed <br>
it’s used by provers when generating a proof <br>
so instead of sending the entire blockchain change, it just gets the state diff <br>
the contracts, balances, etc that has changed from the previous state <br>

the data sent to ethereum don’t go to state, it’s sent along with a transaction to the contract inside the calldata field of the transaction <br>
there’s the EIP 4844 proposition to make it more organized, creating a space for that data <br>

#### transaction flow:

client -> sequencer -> Starknet (L2) -> prover (sharp) -> Ethereum L1 <br>

#### finite field arithmetic

a field that contains a set of finite number of elements
can’t contain sub fields <br>

#### compiling

cairo-compile file_name.cairo --output file_name.json <br>
from the compile .json file the “data” part is what it’s sent to the sharp <br>

#### Types

const <br>
short strings <br>
strings <br>
references <br>
local variables <br>
temporary variables <br>
tuples <br>
arrays <br>

#### math operations

only support: <br>
addition <br>
multiplication <br>
check if two values are equal <br>

#### memory

can’t be re-written <br>
it only can be write once <br>
the address of the memory cell can only be determined at the end of the execution <br>

#### segments

it’s the memory area <br>

#### builtins

pre-defined executions that are added to the Cairo CPU
it would be very expensive to be performed in vanilla cairo <br>
ex.: <br>
output <br>
program output <br>
pedersen <br>
pedersen hash <br>
range_check <br>
check that a field element is within a range <br>
ecdsa <br>
verifies ecdsa signatures <br>
bitwise <br>
performs bitwise operations <br>

#### registers

the only value that can be changed: <br>

#### AP

allocation pointer <br>
points to unused memory cell <br>
it points to the next unused cell <br>

#### FP

frame pointer <br>
it points to the start of a function <br>

#### PC

program counter <br>
it counts the current instruction <br>

#### hints

block of python code within a cairo code <br>
in the future other languages will be allowed <br>
they can access memory <br>
it isn’t provable <br>
it isn’t traced <br>

ex.:

```rust
%{
print(“Hello World”)
}%
```

#### tx flow:

NOT_RECEIVED > RECEIVED > PENDING > REJECTED || ACCEPTED_L2 > ACCEPTED_L1 <br>

#### assert <expr0> = <expr1>;

if `<expr0>`` was alaready set, it works as an assert statement, like a require in solidity <br>
in that case, it is like “verify if <expr0> is equal to <expr1> <br>
if <expr0> wasn’t set before, it works like an assignment statement <br>
in that case, it put <expr1> inside <expr0> <br>

values in cairo are immutable, so it can’t change once assigned <br>

#### compile command

```
cairo-compile file_name.cairo --output file_name_compiled.json --abi file_name_abi.json <br>
```

#### declare command

```
starknet declare --contract file_name_compiled.json
```

#### deploy command

starknet deploy --class_hash **class_hash** --inputs **inputs_in_decimal**

#### run command

```cairo-run --program=file_name_compiled.json \
 --print_output --layout=small
```

#### felt

field element <br>
when you don’t specifiy a type of variable/argument <br>

#### public variable

public variables should be declared explicitly with a getter function <br>
ex.:

```
@view
func getOwner{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (owner: felt) {
let (owner) = Ownable.owner();
return (owner=owner);
}
```

#### storage vars

similar to private variables in solidity <br>
they aren’t visible through the ABI <br>

#### mapping

```
// Declaring a mapping called user_counters_storage. For each 'account' key, which is a felt, we store a value which is a felt also.
@storage_var
func user_counters_storage(account: felt) -> (user_counters_storage: felt) {
}
```

#### tempvar

temporary variable <br>

#### alloc_locals

adding that means that revoked variables can still run using alloc <br>
revoked references is when a function revokes a variable changing its value <br>
in most complex cases you might need to create a local variable to resolve it <br>

#### += SIZEOF_LOCALS

it’s like alloc_locals but without a mechanism that automatically resolves revoked references <br>
it needs to be solve manually by copying the value of the revoked reference to a local variable <br>

ex.:

```
func main{output_ptr: felt\*}() {
ap += SIZEOF_LOCALS;
let (x) = foo(10);
local x2 = x; // or local x = x;
let (y) = foo(5);
serialize_word(x2 + y); // or serialize_word(x + y) ,when local x = x
return ();
}
```

`local x = x`: Reference Rebinding which means hat different expressions may be assigned to the same reference. <br>

or short version: <br>

```
func main{output_ptr: felt\*}() {
ap += SIZEOF_LOCALS;
let (local x) = foo(10);
let (y) = foo(5);

serialize_word(x + y);
return ();
}
```

#### code guideline

https://medium.com/nethermind-eth/cairo-coding-guidelines-74eb6f4ee264

#### cairo contracts

runs on Starknet VM
can have state
can comunicate with other Cairo contracts

#### cairo programs

don’t have state
can not interact with other cairo programs
