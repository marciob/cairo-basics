### Cairo 1.0 studies

This file contains the studies I did to learn how to use the Cairo 1.0.x.<br>

#### How to see the version

```
cairo-run --version
```

#### use

it's like "impot" <br>
allows to import items, like modules, functions, etc from another scope into the current scope.<br>

ex.:<br>

```rs
// imports the PrintTrait from the debug module
// PrintTrait is a trait that allows to print data
use debug::PrintTrait;

fn main() {
    'Hello, world!'.print();
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

Option
