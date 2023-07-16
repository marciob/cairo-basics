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
