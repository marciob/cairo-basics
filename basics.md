### Cairo 1.0 studies

This file contains the studies I did to learn how to use the Cairo 1.0.x.<br>

#### How to see the version

```
cairo-run --version
```

#### use

it's like "impot" <br>
allows to import items, like modules, functions, etc from another scope into the current scope.<br>
in case of modules, it works as a shortcut to access the items inside the module.<br>

ex.:<br>

```rs
// imports the PrintTrait from the debug module
// PrintTrait is a trait that allows to print data
use debug::PrintTrait;

fn main() {
    'Hello, world!'.print();
}
```

ex. of using `use` as a shortcut to access the items inside a module:

```rs
//  it brings Asparagus to the scope, so it can be used in the main function just by typing Asparagus
use backyard::garden::vegetables::Asparagus;

```

#### as

it means "alias".<br>
it allows to create an alias for a module.<br>

ex:

```rs
use array::ArrayTrait as Arr;

fn main() {
    let mut arr = Arr::new(); // ArrayTrait was renamed to Arr
    arr.append(1);
}
```

#### importing multiple items from a module

it's possible to import multiple items from a module.<br>

ex.:

```rs
// Assuming we have a module called `shapes` with the structures `Square`, `Circle`, and `Triangle`.
mod shapes {
    #[derive(Drop)]
    struct Square {
        side: u32
    }

    #[derive(Drop)]
    struct Circle {
        radius: u32
    }

    #[derive(Drop)]
    struct Triangle {
        base: u32,
        height: u32,
    }
}

// We can import the structures `Square`, `Circle`, and `Triangle` from the `shapes` module like this:
use shapes::{Square, Circle, Triangle};

// Now we can directly use `Square`, `Circle`, and `Triangle` in our code.
fn main() {
    let sq = Square { side: 5 };
    let cr = Circle { radius: 3 };
    let tr = Triangle { base: 5, height: 2 };
// ...
}
```

#### indentations

cairo uses 4 spaces for indentation, not tabs.<br>

#### scarb

it's a Cairo package manager.<br>

#### scarb new <project_name>

it creates a new directory with the project name and a cairo.toml file inside it.<br>

it creates: <br>

- Scarb.toml (similar to package.json) <br>
- src folder (src/lib.cairo) <br>

#### scarb build

it compiles the project.<br>

#### mod <module_name>

mod is used to declare a module.<br>
a module is a collection of functions, constants, types, etc.<br>

#### creating a new module or submodule

it's possible to create within the crate root file (lib.cairo) or in a separate file (submodules).<br>

ex. of creating a module in the crate root file (lib.cairo):<br>

```rs
mod my_module {
    // code here
}
```

ex. of creating a module in a separate file (src/vegetables.cairo):<br>

```rs
// vegetables.cairo
// it creates a module called vegetables
mod vegetables {
    // code here
}
```

ex. of using a submodule within the lib.cairo file:<br>

```rs
// it includes the code that it finds in src/garden.cairo
mod garden;

fn main() {
    // ...
}
```

#### nested modules

it's possible to create nested modules.<br>

ex.:

```rs
mod front_of_house {
    mod hosting {
        fn add_to_waitlist() {}

        fn seat_at_table() {}
    }

    mod serving {
        fn take_order() {}

        fn serve_order() {}

        fn take_payment() {}
    }
}
```

in that example it's structured like this:<br>

```rs
restaurant
 └── front_of_house
     ├── hosting
     │   ├── add_to_waitlist
     │   └── seat_at_table
     └── serving
         ├── take_order
         ├── serve_order
         └── take_payment
```

#### cairo-run <file_name>

command to run a cairo program.<br>
if it's a single file, you should use the --single-file flag.<br>

#### mutability

variables in cairo are immutable by default.<br>
to make a variable mutable, you should use the mut keyword.<br>

ex.:<br>

```rs
use debug::PrintTrait;
fn main() {
    let x = 5;
    x.print();

    // this will throw an error
    // because x is immutable by default
    x = 6;
    x.print();
}
```

#### mut

it's a keyword to make a variable mutable.<br>
can not be used with constants.<br>

ex.:

```rs
use debug::PrintTrait;
fn main() {
    // now x is mutable
    let mut x = 5;
    x.print();

    // now it's possible to change the value of x
    x = 6;
    x.print();
}
```

#### constants

it's a variable that can't be changed.<br>
the difference between a constant and mut is that a constant can't be changed, even if it's mutable.<br>
for naming constants, it's a convention to use all caps.<br>
only declared in the global scope.<br>

ex.:

```rs
use debug::PrintTrait;

// this is a constant
// u32 is an unsigned 32-bit integer
const X: u32 = 5;

fn main() {

    X.print();
}
```

#### shadowing

it's when you declare a variable with the same name of another variable in the same scope.<br>
whenever you use the name of the variable, you're referring to the new variable, not the old one.<br>
can not be used with constants.<br>

ex.:

```rs
use debug::PrintTrait;

fn main() {
    let x = 5;
    x.print();  // prints 5

    // this is shadowing
    // now x is a new variable
    let x = 6;
    x.print();  // prints 6
}
```

#### difference between using shadowing and mut

whith shadowing, you can change the type of the variable.<br>
with mut, you can't change the type of the variable.<br>

ex.:

```rs
use debug::PrintTrait;

fn main() {
    let x = 5;
    x.print();  // prints 5

    // this is shadowing
    // now x is a new variable
    let x = "hello";
    x.print();  // prints hello

    // this is mut
    // now x is the same variable
    let mut x = 6;
    x.print();  // prints 6

    // this will throw an error
    // because x is an integer
    x = "hello";
    x.print();
}
```

#### data types

in Cairo there are 2 types of data: <br>

- scalars: they are single values, Cairo has 3 types of scalars, felts, integers and booleans. <br>
- compound: they are made of multiple values or complex structures, like arrays, tuples, etc. <br>

#### felts

it's the default type of a variable in Cairo, which means that if you don't specify the type of a variable, it will be a felt.<br>
stands for field elements.<br>
field elements are elements of a finite field, in Cairo it means the range of 0 <= x < P, where P is a very large prime number currently equal to P = 2^{251} + 17 \* 2^{192}+1 <br>
any number higher than 0 and less than prime number P <br>

#### integers

it's recommended to use integers instead of felts, because of security reasons, against potential vulnerabilities like with overflows.<br>

integers types in Cairo:<br>

- u8: unsigned 8-bit integer, range from 0 to 255.<br>
- u16: unsigned 16-bit integer, range from 0 to 65535.<br>
- u32: unsigned 32-bit integer, range from 0 to 4294967295.<br>
- u64: unsigned 64-bit integer, range from 0 to 18446744073709551615.<br>
- u128: unsigned 128-bit integer, range from 0 to 340282366920938463463374607431768211455.<br>
- u256: unsigned 256-bit integer, range from 0 to 115792089237316195423570985008687907853269984665640564039457584007913129639935.<br>
- usize: it's just an alias for u32. <br>

cairo doesn’t have uint types, which means that all integers are signed.<br>
so you can not have negative values in an integer.<br>

#### booleans

it's a type that can have only 2 values, true or false.<br>

ex.:

```rs
    fn main() {
    let t = true;

    let f: bool = false; // with explicit type annotation

}

```

#### basic operations

Cairo has the basic operations of addition, subtraction, multiplication, division and remainder.<br>
you can not do operations between different types. <br>

ex.:<br>

```rs
fn main() {
    // addition
    let sum = 5_u128 + 10_u128;

    // subtraction
    let difference = 95_u128 - 4_u128;

    // multiplication
    let product = 4_u128 * 30_u128;

    // division
    let quotient = 56_u128 / 32_u128; //result is 1
    let quotient = 64_u128 / 32_u128; //result is 2

    // remainder
    let remainder = 43_u128 % 5_u128; // result is 3
}
```

#### short strings

Cairo doesn't have a string type, but it has a short string type, which are characters stored inside felt252s.<br>
it has a maximum length of 31 characters. <br>

ex.:

```rs
    let my_first_char = 'C';
    let my_first_string = 'Hello world';
```

#### casting with try_into() and into()

it's when you convert a value from one type to another.<br>
it's used when a value is expected to be of a certain type, but it's not.<br>
in cairo it can be converted using try_into() or into().<br>

- #### try_into():<br>

  returns a Option<T>, which you'll need to unwrap to access the new value.<br>
  ex. of use:<br>
  `var.try_into().unwrap()<br>`

- #### into(): <br>
  can be used for casting when success is guaranteed.<br>
  such as when the source type is smaller than the destination type.<br>
  ex. of use:<br>
  `var.into()<br>`

ex. of casting from float to integer in Rust:<br>

```rs
let x = 3.14; // This is a float.
let y = x as i32; // 'as' is used for casting in Rust.
println!("{}", y); // This will print 3.
```

ex. of casting in Cairo:<br>

```rs
use traits::TryInto;
use traits::Into;
use option::OptionTrait;

fn main() {
    let my_felt252 = 10;
    // Since a felt252 might not fit in a u8, we need to unwrap the Option<T> type
    let my_u8: u8 = my_felt252.try_into().unwrap();
    let my_u16: u16 = my_u8.into();
    let my_u32: u32 = my_u16.into();
    let my_u64: u64 = my_u32.into();
    let my_u128: u128 = my_u64.into();
    // As a felt252 is smaller than a u256, we can use the into() method
    let my_u256: u256 = my_felt252.into();
    let my_usize: usize = my_felt252.try_into().unwrap();
    let my_other_felt252: felt252 = my_u8.into();
    let my_third_felt252: felt252 = my_u16.into();
}
```

#### tuples

it's a way to group multiple values into a compound type.<br>
it can have different types.<br>
it has fixed length, which means that once declared, it can't be changed. <br>
it might have or not a name for each value.<br>
it need to be used in the same order that it was declared.<br>

##### how to declare a tuple

```rs
fn main() {
    // this is a tuple called tup that contains 3 elements
    // the first element is a u32
    // the second element is a u64
    // the third element is a bool
    let tup: (u32, u64, bool) = (10, 20, true);
}
```

##### using destructuring to get the values of a tuple

ex.:

```rs
use debug::PrintTrait;
fn main() {
    let tup = (500, 6, true);

    // in this case, x will be 500, y will be 6 and z will be true
    let (x, y, z) = tup;

    // this will print 500
    if y == 6 {
        'y is six!'.print();
    }
}
```

ex. declaring the tuple and destructuring in the same line:

```rs
fn main() {
    let (x, y): (felt252, felt252) = (2, 3);
}
```

#### structs

it's a way to group multiple values into a compound type.<br>
it can have different types.<br>
it needs to have a name for each value.<br>
in this case it's a bit more complex than a tuple.<br>
it doesn't need to be used in the same order that it was declared.<br>
an entire struct can not be printed as a whole, it's necessary to print each value of the struct.<br>

ex.:

```rs
#[derive(Copy, Drop)]
struct User {
    active: bool,
    username: felt252,
    email: felt252,
    sign_in_count: u64,
}

fn main() {
    let user1 = User {
        active: true, username: 'someusername123', email: 'someone@example.com', sign_in_count: 1
    };
}
```

##### getting the values of a struct

ex.:

```rs
user1.email;
```

##### updating the values of a struct

the instance of the struct needs to be mutable.<br>
the entire instance needs to be mutable, it's not possible to make only one field mutable.<br>

ex.:

```rs
#[derive(Copy, Drop)]
struct User {
    active: bool,
    username: felt252,
    email: felt252,
    sign_in_count: u64,
}

fn main() {
    let mut user1 = User {
        active: true, username: 'someusername123', email: 'someone@example.com', sign_in_count: 1
    };
    user1.email = 'anotheremail@example.com';
}
```

##### returning a struct

a struct can be returned from a function.<br>

ex.:

```rs
#[derive(Copy, Drop)]
struct User {
    active: bool,
    username: felt252,
    email: felt252,
    sign_in_count: u64,
}

fn main() {
    fn build_user(email: felt252, username: felt252) -> User {
        // the last expression of this function is the return value
        User { active: true, username: username, email: email, sign_in_count: 1,  }
    }
}
```

#### shorthand for initializing structs

when the name of the variable is the same as the name of the field, it's possible to use the shorthand.<br>

ex.:

```rs
// in this example since the name of the variable is the same as the name of the field, it's possible to use the shorthand
fn build_user_short(email: felt252, username: felt252) -> User {
    // instead of email: email, it's possible to use email, which will be whatever is passed as the email parameter
    // instead of username: username, it's possible to use username, which will be whatever is passed as the username parameter
    User { active: true, username, email, sign_in_count: 1,  }
}
```

#### functions

naming convention: snake case.<br>
ex.:<br>

```rs
use debug::PrintTrait;

fn another_function() {
    'Another function.'.print();
}

fn main() {
    'Hello, world!'.print();
    another_function();
}
```

##### parameters

ex.:

```rs
use debug::PrintTrait;

fn main() {
another_function(5, 6);
}

fn another_function(x: felt252, y: felt252) {
x.print();
y.print();
}

```

#### named parameters

it's allowed to name the parameters of a function.<br>
it's used to make the code more readable.<br>

ex.:

```rs
fn foo(x: u8, y: u8) {}

fn main() {
    let first_arg = 3;
    let second_arg = 4;

    // this could be written like this
    // foo(first_arg, second_arg);
    // but for readability, it preferred to write like this:
    foo(x: first_arg, y: second_arg);
    let x = 1;
    let y = 2;
    foo(:x, :y)
}
```

#### function with return value

when a function has a return value, it's necessary to specify the type of the return value.<br>
the return value is the last expression of the function, without a semicolon.<br>
it might be a good practice to use the return keyword, in this case a semicolon is necessary.<br>
without a semicolon, it's a statement, with a semicolon, it's an expression.<br>
if the last expression of the function (without return key world) is placed with a semicolon, it will throw an error.<br>

ex.:

```rs
// this function returns a u32 value type
fn five() -> u32 {
    5
}
```

ex. with return keyword:

```rs
// this function returns a u32 value type
fn five() -> u32 {
    return 5;
}
```

#### if expression

ex.:

```rs
use debug::PrintTrait;

fn main() {
    let number = 3;

    if number == 12 {
        'number is 12'.print();
    } else if number == 3 {
        'number is 3'.print();
    } else if number - 2 == 1 {
        'number minus 2 is 1'.print();
    } else {
        'number not found'.print();
    }
}
```

#### using if in a let statement

ex.:

```rs
use debug::PrintTrait;

fn main() {
    let condition = true;
    let number = if condition {
        5
    } else {
        6
    };

    if number == 5 {
        'condition was true'.print();
    }
}
```

#### --available-gas

it's a flag used to specify the amount of gas available to the program.<br>
it's used to prevent infinite loops, in those cases it's mandatory to use this flag, otherwise the program will throw an error.<br>

ex.:

```rs
cairo-run src/lib.cairo --available-gas=20000000
```

#### break

it's used to break out of a loop.<br>
ex.:

```rs
use debug::PrintTrait;
fn main() {
    let mut i: usize = 0;
    loop {
        if i > 10 {
            break;
        }
        'again'.print();
        i += 1;
    }
}
```

#### continue

it's used to pause the current loop and continue in the next loop iteration.<br>
ex.:

```rs
use debug::PrintTrait;
fn main() {
    let mut i: usize = 0;
    loop {
        if i > 10 {
            break;
        }
        if i == 5 {
            i += 1;

            // when reach here it will stop the current loop and continue in the next loop iteration
            continue;
        }
        i.print();
        i += 1;
    }
}
```

#### common collections

Cairo1 has 2 types of collections: <br>

- Arrays
- Felt252Dict

#### arrays

in Cairo, arrays are a collection of elements of the same type.<br>
you need to import the array module to use it: array::ArrayTrait.<br>
you can only append elements to the end of the array.<br>
you can only remove elements from the front of the array.<br>

#### creating an array

it's made by calling `ArrayTrait::new()` <br>

ex.:

```rs
use array::ArrayTrait;

fn main() {
    let mut a = ArrayTrait::new();
    a.append(0);
    a.append(1);
    a.append(2);
}
```

ex. of creating an array with a specified type:

```rs
let mut arr = ArrayTrait::<u128>::new();
```

#### updating an array

To add an element to the end of an array, you can use the append() method:<br>

```rs
    a.append(0);
```

#### removing elements from an array

you can only remove elements from the front of the array, using the `pop_front()` method.<br>
`pop_front()` returns an `Option` containing the element removed, or `None` if the array is empty.<br>
since an array is in an immutable memory, actually it doesn't remove the element of the array, it creates a new array starting from the second element of the original array. The original array is still in memory.<b

```rs
use option::OptionTrait;
use array::ArrayTrait;
use debug::PrintTrait;

fn main() {
    let mut a = ArrayTrait::new();
    a.append(10);
    a.append(1);
    a.append(2);

    let first_value = a.pop_front().unwrap();
    first_value.print(); // print '10'
}
```

#### removing elements from an array

to access an element of an array, you can use the `get()` or `at()` methods.<br>
`arr.at()` is similar to `arr[index]` in other languages.<br>

- `at()` returns the element at the specified index, or panics if the index is out of bounds.<br>
- `get()` returns an `Option` containing the element at the specified index, or `None` if the index is out of bounds.<br>

difference between `get()` and `at()`:<br>

- `at()` will panic if the index is out of bounds.<br>
- `get()` will not panic if the index is out of bounds, it will return `None` instead.<br>

ex. with `at()`:

```rs
use array::ArrayTrait;
fn main() {
    let mut a = ArrayTrait::new();
    a.append(0);
    a.append(1);

    // * is the dereference operator
    // it's used to get the value of the pointer instead of the pointer itself
    // in this case, it's used to get the value of the pointer returned by the at() method
    let first = *a.at(0);
    let second = *a.at(1);
}
```

ex. with `get()`:

```rs
use array::ArrayTrait;
use box::BoxTrait;
fn main() -> u128 {
    let mut arr = ArrayTrait::<u128>::new();
    arr.append(100);
    let index_to_access =
        1; // Change this value to see different results, what would happen if the index doesn't exist?
    match arr.get(index_to_access) {
        Option::Some(x) => {
            *x.unbox()
        // Don't worry about * for now, if you are curious see Chapter 3.2 #desnap operator
        // It basically means "transform what get(idx) returned into a real value"
        },
        Option::None(_) => {
            let mut data = ArrayTrait::new();
            data.append('out of bounds');
            panic(data)
        }
    }
}
```

#### len()

it's a method that returns the length of the array.<br>
the return type is a `usize`.<br>

#### is_empty()

it checks if the array is empty.<br>
it's a method that returns a boolean value, true if the array is empty, false if it's not.<br>

#### storing multiple types in an array with enums

ex.:

```rs
use array::ArrayTrait;
use traits::Into;

#[derive(Copy, Drop)]
enum Data {
    Integer: u128,
    Felt: felt252,
    Tuple: (u32, u32),
}

fn main() {
    let mut messages: Array<Data> = ArrayTrait::new();
    messages.append(Data::Integer(100));
    messages.append(Data::Felt('hello world'));
    messages.append(Data::Tuple((10, 30)));
}
```

#### span()

it represents a snapshot of the array.<br>
it provides a safe way to access the array without about modifying the original array.<br>

ex.:

```rs
use array::ArrayTrait;

fn main() {
    let mut array: Array<u8> = ArrayTrait::new();
    array.span();
}
```

#### ownership

each variable in Cairo has an owner.<br>
there can be only 1 owner at a time.<br>
when the owner goes out of scope, the value will be dropped and removed from meory.<br>
an owner of the variable is the scope in which the variable was declared.<br>
the variable is the owner of the value it's holding.<br>

ex.:

```rs
use debug::PrintTrait;

fn main() {
    // main() is the owner of the variable s
    let s = 'hello'; // s is the owner of the value 'hello'
    s.print(); // prints 'hello'
} // s goes out of scope here, and 'hello' is dropped
```

#### ownership in array

ex.:

```rs
use array::ArrayTrait;
// some function created to exemplify the use of an array as a parameter
fn foo(arr: Array<u128>) {}

// some function created to exemplify the use of an array as a parameter
fn bar(arr: Array<u128>) {}

fn main() {
    // an instance of arr is created here
    let mut arr = ArrayTrait::<u128>::new();

    // the arr instance is used for the first time here
    foo(arr);

    // the same arr instance is used for the second time here,
    // it would be a tentative to write to the same memory location twice, which is not allowed in Cairo
    // it will throw an error
    bar(arr);
}

```

#### copy

`#[derive(Copy)]` is used to indicate that a type is safe to be copied.<br>
this is used to avoid the error of trying to use the same instance twice.<br>
Arrays and Dictioanries can not be copied, only custom types that don't contain either of them.<br>

ex.:

```rs
#[derive(Copy, Drop)] // this indicates that the type is safe to be copied
struct Point {
    x: u128,
    y: u128,
}

fn main() {
    // p1 is an instance of Point
    let p1 = Point { x: 5, y: 10 };

    // here when passing p1, actually it's passing a copy of p1
    // the ownership of p1 is not transferred to foo, it remains in main
    // if `#[derive(Copy, Drop)]` was removed, it would throw an error
    foo(p1);

    // here it's another copy of p1
    foo(p1);
}

fn foo(p: Point) { // do something with p
}
```

#### drop

`#[derive(Drop)]` is used to indicate that a type is safe to be dropped or deallocated (kind of transferred to another scope).<br>
it handles the deallocation of the memory, any necessary cleanup.<br>
it doesn't transfer the ownership of the variable, it just deallocates the memory.<br>

ex.:

the following code throws an error because A is used outside of its scope:

```rs
struct A {}

fn main() {
    A {}; // error: Value not dropped.
}
```

the following code doesn't throw an error because A is safe to be used outside of its scope:

```rs
#[derive(Drop)]
struct A {}

fn main() {
    A {}; // Now there is no error.
}
```

#### clone

`clone` is used to create a copy of a value.<br>

ex.:

```rs
use array::ArrayTrait;
use clone::Clone;
use array::ArrayTCloneImpl;
fn main() {
    let arr1 = ArrayTrait::<u128>::new();
    let arr2 = arr1.clone(); // arr2 is a copy of arr1
}
```

### uint automatically has the Copy trait

unsigned integers are automatically copied, so it's not necessary to use `#[derive(Copy)]` for them.<br>

ex.:

```rs
#[derive(Drop)]
struct MyStruct{} // MyStruct is safe to be dropped

fn main() {
    let my_struct = MyStruct{};  // my_struct comes into scope

    takes_ownership(my_struct);     // my_struct's value moves into the function...
                                    // ... and so is no longer valid here

    let x = 5;                 // x comes into scope

    makes_copy(x);                  // x would move into the function,
                                    // but u128 implements Copy, so it is okay to still
                                    // use x afterward

}                                   // Here, x goes out of scope and is dropped.

fn takes_ownership(some_struct: MyStruct) { // some_struct comes into scope
} // Here, some_struct goes out of scope and `drop` is called.

fn makes_copy(some_uinteger: u128) { // some_uinteger comes into scope
} // Here, some_integer goes out of scope and is dropped.
```

#### return values transfer ownership

when a value is returned from a function, it transfers the ownership of the value to the location where the function was called.<br>

ex.:

```rs
#[derive(Drop)]
struct A {}

fn main() {
    let a1 = gives_ownership();           // gives_ownership moves its return
                                          // value into a1

    let a2 = A {};                        // a2 comes into scope

    let a3 = takes_and_gives_back(a2);    // a2 is moved into
                                          // takes_and_gives_back, which also
                                          // moves its return value into a3

} // Here, a3 goes out of scope and is dropped. a2 was moved, so nothing
  // happens. a1 goes out of scope and is dropped.

fn gives_ownership() -> A {               // gives_ownership will move its
                                          // return value into the function
                                          // that calls it

    let some_a = A {};                    // some_a comes into scope

    some_a                                // some_a is returned and
                                          // moves ownership to the calling
                                          // function
}

// This function takes an instance some_a of A and returns it
fn takes_and_gives_back(some_a: A) -> A { // some_a comes into
                                          // scope

    some_a                               // some_a is returned and moves
                                         // ownership to the calling
                                         // function
}
```

#### snapshot @

it's a way of getting an immutable view of a value at a certain point in time.<br>
it allows ongoing use without transferring ownership.<br>
it's only possible to use snaphot with types that implement it, such as ArrayTrait.<br>
it uses @ to indicate that it's a snapshot.<br>
it doesn't transfer ownership of the value, it just creates a snapshot of the value.<br>
when functions have snapshots as parameters instead of the actual values, we won’t need to return the values in order to give back ownership of the original value, because we never had it.<br>

ex.:

```rs
use array::ArrayTrait;
use debug::PrintTrait;

fn main() {
    let mut arr1 = ArrayTrait::<u128>::new();
    let first_snapshot = @arr1; // Take a snapshot of `arr1` at this point in time
    arr1.append(1); // Mutate `arr1` by appending a value
    let first_length = calculate_length(
        first_snapshot
    ); // Calculate the length of the array when the snapshot was taken
    let second_length = calculate_length(@arr1); // Calculate the current length of the array
    first_length.print();
    second_length.print();
}

fn calculate_length(arr: @Array<u128>) -> usize {
    arr.len()
}
```

#### \*

besides being used to multiply, it's also used to convert snapshots into their original values, as long as the value is copiable (which isn't the case for arrays)<br>

ex.:

```rs
use debug::PrintTrait;

#[derive(Copy, Drop)]
struct Rectangle {
    height: u64,
    width: u64,
}

fn main() {
    let rec = Rectangle { height: 3, width: 10 };
    let area = calculate_area(@rec);
    area.print();
}

fn calculate_area(rec: @Rectangle) -> u64 {
    // As rec is a snapshot to a Rectangle, its fields are also snapshots of the fields types.
    // We need to transform the snapshots back into values using the desnap operator `*`.
    // This is only possible if the type is copyable, which is the case for u64.
    // Here, `*` is used for both multiplying the height and width and for desnapping the snapshots.
    *rec.height * *rec.width
}
```

#### snapshot values can not be modified, by default

the following code throws an error because the snapshot value can not be modified:

```rs
#[derive(Copy, Drop)]
struct Rectangle {
    height: u64,
    width: u64,
}

fn main() {
    let rec = Rectangle { height: 3, width: 10 };
    flip(@rec);
}

fn flip(rec: @Rectangle) {
    let temp = rec.height;
    rec.height = rec.width;
    rec.width = temp;
}
```

#### snapshot values can be modified using the `mut` and `ref` keyword

the `ref` keyword means reference, it's used to indicate that the value is a reference to the original value and can be modified.<br>
eventual value returned doesn't transfer ownership.<br>

ex.:

```rs
use debug::PrintTrait;
#[derive(Copy, Drop)]
struct Rectangle {
    height: u64,
    width: u64,
}

fn main() {
    let mut rec = Rectangle { height: 3, width: 10 };
    flip(ref rec);
    rec.height.print();
    rec.width.print();
}

fn flip(ref rec: Rectangle) {
    let temp = rec.height;
    rec.height = rec.width;
    rec.width = temp;
}
```

#### when to use snapshot or reference

- snapshot: when you want to use the value without modifying it.<br>
- reference: when you want to use the value and modify it.<br>

#### trait

traits are a way to group methods that can be used on various types.<br>
traits are similar to interfaces in other languages <br>
a trait doesn't have a function body, it only has the function signature.<br>
traits are used to define shared behavior in an abstract way <br>
the trait is later one implemented by a type.<br>
when we attach a trait to a type, is like we are attaching methods to be used by that type anytime.<br>
a trait is defined in PascalCase.<br>

ex. of creating a trait:

```rs

// this is a trait called RectangleTrait
// it has a function signature called area that returns a u64
// just that, functions in a trait don't have a function body, they are called methods
// the self parameter is a reference to the instance that is implementing the trait
trait RectangleTrait {
    fn area(self: @Rectangle) -> u64;
}

```

#### impl

impl is used to implement a trait for a type.<br>
each struct can have multiple impl blocks.<br>

ex. of implementing a trait in a type:

```rs

// this implements a trait called RectangleTrait for a type called RectangleTrait
// the name of the impl isn't used anywhere, it's just naming for readability and organization
// the self parameter is a reference to the instance that is implementing the trait
impl RectangleImpl of RectangleTrait {
    fn area(self: @Rectangle) -> u64 {
        (*self.width) * (*self.height)
    }
}
```

ex. of the full code:

```rs
use debug::PrintTrait;
#[derive(Copy, Drop)]
struct Rectangle {
    width: u64,
    height: u64,
}

trait RectangleTrait {
    fn area(self: @Rectangle) -> u64;
}

impl RectangleImpl of RectangleTrait {
    fn area(self: @Rectangle) -> u64 {
        (*self.width) * (*self.height)
    }
}

fn main() {
    let rect1 = Rectangle { width: 30, height: 50,  };


    rect1.area().print();
}
```

#### acessing a method from a trait

ex. of calling a method from the type that implements the trait:

```rs
struct Dog{}

trait MakeSound{
  fn bark(self: @Dog);
  // ...
}

fn main(){
  let dog = Dog{};

  dog.bark();
}
```

ex. of calling a method from a trait:

```rs
trait RectangleTrait {
    fn square(size: u64) -> Rectangle;
}

fn main() {
    // this calls the method square from the trait RectangleTrait
    let square = RectangleTrait::square(3);
}
```

#### self

self is a reference to the instance that is implementing the trait.<br>

ex.:

```rs
struct Rectangle {
    height: u64,
    width: u64,
}

#[generate_trait]
impl RectangleGeometry of RectangleGeometryTrait {
    fn boundary(self: Rectangle) -> u64 {
        2 * (self.height + self.width)
    }
    fn area(self: Rectangle) -> u64 {
        self.height * self.width
    }
}

fn main() {
    let rect = Rectangle { height: 5, width: 10 }; // Rectangle instantiation

    // First way, as a method on the struct instance
    let area1 = rect.area();
    // Second way, from the implementation
    let area2 = RectangleGeometry::area(rect);
    // Third way, from the trait
    let area3 = ShapeGeometry::area(rect);

    // `area1` has same value as `area2` and `area3`
    area1.print();
    area2.print();
    area3.print();
}

```

#### trait without a declaration #[generate_trait]

it's possible to create a trait without a declaration, by simply using the `#[generate_trait]` attribute.<br>
the implementation name needs to have a Trait suffix.<br>

ex.:

```rs
struct Rectangle {
    height: u64,
    width: u64,
}

#[generate_trait]
impl RectangleGeometry of RectangleGeometryTrait {
    fn boundary(self: Rectangle) -> u64 {
        2 * (self.height + self.width)
    }
    fn area(self: Rectangle) -> u64 {
        self.height * self.width
    }
}
```

#### enum

it's a way to group multiple values (variant).<br>
each variant has a type, differently from other languages.<br>
the name convention is to use PascalCase for each variant.<br>

ex.:

```rs
#[derive(Drop)]
enum Direction {
    North: (),
    East: (),
    South: (),
    West: (),
}
```

#### enum with custom types

it's possible to create enums with variants with different types.<br>
you can even use a struct or enum as a variant.<br>

ex.:

```rs
#[derive(Drop)]
enum Message {
    Quit: (), // it has no data associated with it
    Echo: felt252, // it's a single felt252
    Move: (u128, u128), // it's a tuple with 2 u128
}
```

#### enums with traits

you can implement traits for enums.<br>

ex.:

```rs
trait Processing {
    fn process(self: Message);
}

impl ProcessingImpl of Processing {
    fn process(self: Message) {
        match self {
            Message::Quit(()) => {
                'quitting'.print();
            },
            Message::Echo(value) => {
                value.print();
            },
            Message::Move((x, y)) => {
                'moving'.print();
            },
        }
    }
}
```

how that would be used:

```rs
    let msg: Message = Message::Quit(());
    msg.process();
```

#### Option

it's a enum that is implemented in Cairo.<br>
it needs to import the option module to use it: `option::OptionTrait`.<br>
it represents an optional value, that can be either Some or None.<br>
an Option can be either those 2 values:<br>

- `Some: T` : it contains a value of type T <br>
- `None: ()` : it doesn't contain a value <br>

ex.:

```rs
use option::OptionTrait;

enum Option<T> {
    Some: T,
    None: (),
}
```

#### match

it's a way to compare a value and execute code for the first match.<br>
each match line is called an arm.<br>
the `=>` indicates what code to execute when there is a match.<br>
the order of the arms must be in the same order of the variants of the enum.<br>
if the code is a bit large it's possible to use `{}` to create a block of code.<br>
match needs to be exhaustive, it means that it needs to have a match for each possible value of the type, otherwise it will throw an error. So doesn't matter if it's an enum or an Option, it needs to have a match for each variant.<br>

ex.:

```rs
enum Coin {
    Penny: (),
    Nickel: (),
    Dime: (),
    Quarter: (),
}

fn value_in_cents(coin: Coin) -> felt252 {
    match coin {
        Coin::Penny(_) => 1,
        Coin::Nickel(_) => 5,
        Coin::Dime(_) => 10,
        Coin::Quarter(_) => 25,
    }
}
```

ex. of using `{}` to create a block of code:

```rs
fn value_in_cents(coin: Coin) -> felt252 {
    match coin {
        Coin::Penny(_) => {
            ('Lucky penny!').print();
            1
        },
        Coin::Nickel(_) => 5,
        Coin::Dime(_) => 10,
        Coin::Quarter(_) => 25,
    }
}
```

#### match with enum variants

ex.:

```rs
#[derive(Drop)]
enum UsState {
    Alabama: (),
    Alaska: (),
}

#[derive(Drop)]
// in this example, only Quarter is a variant with a value
enum Coin {
    Penny: (),
    Nickel: (),
    Dime: (),
    Quarter: (UsState, ),
}

// this implementation is necessary to print the enum UsState
impl UsStatePrintImpl of PrintTrait<UsState> {
    fn print(self: UsState) {
        match self {
            UsState::Alabama(_) => ('Alabama').print(),
            UsState::Alaska(_) => ('Alaska').print(),
        }
    }
}

// within this function we are using a match with an enum variant that has a value
fn value_in_cents(coin: Coin) -> felt252 {
    match coin {
        Coin::Penny(_) => 1,
        Coin::Nickel(_) => 5,
        Coin::Dime(_) => 10,
        // in this variant, we use a variable called state to get the value of the variant Coin::Quarter
        // when a coin matches Coin::Quarter, the value of the variant is assigned to the variable state
        Coin::Quarter(state) => {
            state.print();
            25
        },
    }
}
```

#### printing an enum

to print an enum, it's necessary to implement the trait PrintTrait for the enum.<br>

ex.:

```rs
impl UsStatePrintImpl of PrintTrait<UsState> {
    fn print(self: UsState) {
        match self {
            UsState::Alabama(_) => ('Alabama').print(),
            UsState::Alaska(_) => ('Alaska').print(),
        }
    }
}
```

#### match with Option

it's possible to use match with Option.<br>
the match arm needs to have the same order of the Option trait.<br>
it matches if there is a value or not.<br>

ex.:

```rs
use option::OptionTrait;
use debug::PrintTrait;

fn plus_one(x: Option<u8>) -> Option<u8> {
    // this matches if there is a value or not
    // if there is a value, it adds 1 to the value
    // if there is no value, it returns None
    // the matches uses the same order of the Option trait
    match x {
        Option::Some(val) => Option::Some(val + 1),
        Option::None(_) => Option::None(()),
    }
}

fn main() {
    let five: Option<u8> = Option::Some(5);
    let six: Option<u8> = plus_one(five);
    six.unwrap().print();
    let none = plus_one(Option::None(()));
    none.unwrap().print();
}
```

#### crates

it's a way to organize code.<br>
it's a tree of modules, it' has a root directory and a root module.<br>
crate is the smallest amount of code that Cairo can compile.<br>

#### cairo package

it's a bunch of crates created with Scarb.toml that define how to build those crates.<br>

#### creating a package with Scarb

`scarb new <package_name>`<br>

this will create a new package named `<package_name>` with the following structure:<br>

```rs
my_package/
├── Scarb.toml // it's the package manager, it's like a package.json in javascript
└── src // it's where all cairo files for the package will be stored
    └── lib.cairo // it's the default root module of the crate
```

#### paths

in Cairo a path is used to locate a module.<br>
it could be a relative path or an absolute path.<br>

- absolute path:<br>
  the path starts from the crate root. <br>
  ex.:

```rs
    restaurant::front_of_house::hosting::add_to_waitlist();
```

- relative path:<br>
  the path starts from the current module.<br>
  ex.:
  ```rs
  front_of_house::hosting::add_to_waitlist();
  ```

#### super

it's used to go to the parent of the current module.<br>
it's used to go to one scope above.<br>
it's like using `..` in the terminal.<br>

ex.:

```rs
fn deliver_order() {}

mod back_of_house {
    fn fix_incorrect_order() {
        cook_order();
        // here it's using super to go scope above where deliver_order is defined
        super::deliver_order();
    }

    fn cook_order() {}
}
```

#### generic type <T>

it's a way to define a type that can be used in multiple types.<br>
it can be used when defining a function, struct, enum, etc.<br>

ex.:

```rs

use array::ArrayTrait;

// Specify generic type T between the angulars
// it's a function that returns an Array of type T
// it compares two arrays and returns the largest one
// actually the following code will throw an error because it didn't implement the drop trait, but it's just to exemplify the use of generic types, the correct signature should be:
// fn largest_list<T, impl TDrop: Drop<T>>(l1: Array<T>, l2: Array<T>) -> Array<T> {
fn largest_list<T>(l1: Array<T>, l2: Array<T>) -> Array<T> {
    if l1.len() > l2.len() {
        l1
    } else {
        l2
    }
}

fn main() {
    let mut l1 = ArrayTrait::new();
    let mut l2 = ArrayTrait::new();

    l1.append(1);
    l1.append(2);

    l2.append(3);
    l2.append(4);
    l2.append(5);

    // There is no need to specify the concrete type of T because
    // it is inferred by the compiler
    let l3 = largest_list(l1, l2);
}
```

#### PartialOrd

the PartialOrd is a trait that is implemented in Cairo to compare values.<br>

ex.:

```rs
use array::ArrayTrait;

// Given a list of T get the smallest one.
// The PartialOrd trait implements comparison operations for T
fn smallest_element<T, impl TPartialOrd: PartialOrd<T>>(list: @Array<T>) -> T {
    // This represents the smallest element through the iteration
    // Notice that we use the desnap (*) operator
    let mut smallest = *list[0];

    // The index we will use to move through the list
    let mut index = 1;

    // Iterate through the whole list storing the smallest
    loop {
        if index >= list.len() {
            break smallest;
        }
        if *list[index] < smallest {
            smallest = *list[index];
        }
        index = index + 1;
    }
}

fn main() {
    let mut list: Array<u8> = ArrayTrait::new();
    list.append(5);
    list.append(3);
    list.append(10);

    // We need to specify that we are passing a snapshot of `list` as an argument
    let s = smallest_element(@list);
    assert(s == 3, 0);
}
```

#### tests

tests are functions created to test real code (non-test code). <br>
within the test function usually it assert if the result is the expected one.<br>
for while, to run a test it is necessary to use cairo_project.toml. (while Scarb not implement that)<br>

#### creating a test function

for creating a test function, it's necessary to use the `#[test]` attribute in the line above the function.<br>
in the same file non-test code can also exist, so it's mandatory to use the `#[test]` attribute to indicate that the function is a test.<br>

ex.:<br>

```rs
    #[test]
    fn it_works() {
        let result = 2 + 2;
        assert(result == 4, 'result is not 4');
    }

```

content of cairo_project.toml:

```rs
[crate_roots]
adder = "src"
```

#### cairo_project.toml

it's a configuration file for vanilla Cairo project (not initiated with Scarb).<br>
it's required to run cairo-test.<br>

#### running a test

for running a test, it's necessary to use the `cairo-test` command.<br>
it will run all tests in the project.<br>

ex. of result when running a test:

```rs
// example of a test result
$ cairo-test .
running 1 tests // it tells how many tests are running
test adder::lib::tests::it_works ... ok // it_works is the name of the test function, and ok means that it passed
test result: ok. 1 passed; 0 failed; 0 ignored; 0 filtered out; // it's a summary of the test
```

ex. of a test that fails:

```rs
// the test function
    #[test]
    fn another() {
        let result = 2 + 2;
        assert(result == 6, 'Make this test fail');
    }
```

```rs
// the result of running the test
$ cairo-test .
running 2 tests
test adder::lib::tests::exploration ... ok
test adder::lib::tests::another ... fail
failures:
    adder::lib::tests::another - panicked with [1725643816656041371866211894343434536761780588 ('Make this test fail'), ].
Error: test result: FAILED. 1 passed; 1 failed; 0 ignored
```

#### running a specific test function

ex.:

```rs
cairo-test . -f test_name
```

#### assert

it's a function that checks if the result is the expected one.<br>
if the result is not the expected one, it will throw an error.<br>
the text after the comma is the error message.<br>
when it fails it will panic and show the error message.<br>
it's used in tests.<br>

ex.:

```rs
    #[test]
    fn it_works() {
        let result = 2 + 2;
        assert(result == 4, 'result is not 4');
    }
```

#### should_panic

it's a function that checks if the code is handling the erros correctly.<br>
it's used with `#[should_panic]` code bellow the `#[test]` attribute and above the function.<br>

ex. of code:

```rs
use array::ArrayTrait;

#[derive(Copy, Drop)]
struct Guess {
    value: u64,
}

trait GuessTrait {
    fn new(value: u64) -> Guess;
}

impl GuessImpl of GuessTrait {
    fn new(value: u64) -> Guess {
        if value < 1 || value > 100 {
            let mut data = ArrayTrait::new();
            data.append('Guess must be >= 1 and <= 100');
            panic(data);
        }
        Guess { value }
    }
}

#[cfg(test)]
mod tests {
    use super::Guess;
    use super::GuessTrait;

    #[test]
    #[should_panic]
    fn greater_than_100() {
        GuessTrait::new(200);
    }
}

```

```rs
// the result of running the test
$ cairo-test .
running 1 tests
test adder::lib::tests::greater_than_100 ... ok
test result: ok. 1 passed; 0 failed; 0 ignored; 0 filtered out;
```

#### #[ignore]

` #[ignore]` is used to ignore a test.<br>

ex.:

```rs
#[cfg(test)]
mod tests {
   #[test]
   fn it_works() {
       let result = 2 + 2;
       assert(result == 4, 'result is not 4');
   }

   #[test]
   #[ignore]
   fn expensive_test() { // code that takes an hour to run
   }
}
```

#### #[cfg(test)]

it's used when you wanna indicate that a code only should be compiled when running tests.<br>
cfg stands for configuration, so it's like saying "only run this when it's called by test".<br>

ex.:

```rs
#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        let result = 2 + 2;
        assert(result == 4, 'result is not 4');
    }
}

```

#### macro

macros are like shortcut in Cairo.<br>
they are called `inline_macros`. <br>
there are 2 types of macros in Cairo:<br>

- `array![]` : it's used to create an array.<br>
- `consteval_int!()`: it's used to enforce that an operation is done at compile time.<br>

`array![]`:<br>

creating an array without `array!`:<br>

```rs
    let mut arr = ArrayTrait::new();
    arr.append(1);
    arr.append(2);
    arr.append(3);
    arr.append(4);
    arr.append(5);
```

creating an array with `array!`:<br>

```rs
    let mut arr = array![1, 2, 3, 4, 5];
```

`consteval_int!`:<br>

example of using `consteval_int`:<br>

```rs
const a: felt252 = consteval_int!(2 * 2 * 2);
```

the compiler will interpret the code above as:<br>

```rs
const a: felt252 = 8;
```
