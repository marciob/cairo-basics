fn fib(a: felt252, b: felt252, n: felt252) -> felt252 {
    match n {
        0 => a,
        _ => fib(b, a + b, n - 1),
    }
}

#[test]
fn it_works() {
    let result = 2 + 2;
    assert(result == 4, 'result is not 4');
}

#[test]
fn exploration() {
    let result = 2 + 2;
    assert(result == 4, 'result is not 4');
}

#[test]
fn another() {
    let result = 2 + 2;
    assert(result == 6, 'Make this test fail');
}
