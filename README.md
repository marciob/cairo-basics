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
