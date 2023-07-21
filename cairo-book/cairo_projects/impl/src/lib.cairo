use debug::PrintTrait;
#[derive(Copy, Drop)]
struct Rectangle {
    width: u64,
    height: u64,
}

trait RectangleTrait {
    fn area(self: @Rectangle) -> u64;
    fn can_hold(self: @Rectangle, other: @Rectangle) -> bool;
}

impl RectangleImpl of RectangleTrait {
    fn area(self: @Rectangle) -> u64 {
        *self.width * *self.height
    }

    fn can_hold(self: @Rectangle, other: @Rectangle) -> bool {
        (*self.width > *other.width) & (*self.height > *other.height)
    }
}

fn main() {
    let rect1 = Rectangle { width: 30, height: 50,  };
    let rect2 = Rectangle { width: 10, height: 40,  };
    let rect3 = Rectangle { width: 60, height: 45,  };

    'Can rect1 hold rect2?'.print();
    rect1.can_hold(@rect2).print();

    'Can rect1 hold rect3?'.print();
    rect1.can_hold(@rect3).print();
}
