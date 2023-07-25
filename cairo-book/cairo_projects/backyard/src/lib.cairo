// it tells the compiler to bring Asparagus type into scope, so it can be used in the main function
use garden::vegetables::Asparagus;

// it tells the compiler to include a module named garden from another file in src/garden.cairo
mod garden;

fn main() {
    let Asparagus = Asparagus {};
}

// it is creating a new module named my_module
mod my_module {
// code defining the my_module module goes here
}
