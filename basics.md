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
it has fixed length, which means that once declared, it can't be changed. <br>

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
it's used to prevent infinite loops.<br>

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
