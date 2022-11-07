// code from https://www.youtube.com/watch?v=jcrAq71WwSM&lc=Ugwl_ykvDPkHBTDVlAp4AaABAg

%builtins output

from starkware.cairo.common.serialize import serialize_word

func main{output_ptr : felt*}():
    const p = (2 ** 251 + 17 * 2 ** 192 + 1)    // it's the big prime
    const half_p = (2 ** 250 + 8 * 2 ** 192 + 2 ** 191) // it's half of the big prime, precisally it's p - 1 / 2, so it's the biggest number in a positive range
    //                                                     those are modular arithmetic, like a circle of numbers, so it's expected to the latest positive number to be at the half position

    serialize_word(p) // it returns 0 at this code because,
                    //it happens because in a modular arithmetic (circle of numbers) the largest number ends at the same point that the initial number (0) starts

    serialize_word(half_p - 2)
    serialize_word(half_p - 1)
    serialize_word(half_p)
    serialize_word(half_p + 1)
    serialize_word(half_p + 2)
    serialize_word(half_p + 3)

    serialize_word(1 / 2) // it returns the largest negative number, 
        //it makes sense because in a modular arithmetic (circle of numbers) reading the number back it starts with -1,
        //then going all the way to the latest negative number, it will be at the half of the circle,
        //so 1 / 2 goes to there
    serialize_word(1 / 3) // it returns a number in a positive range near, becuase in a modular arithmetic it goes futher the negative numbers,
                        // to better understand you can think of it like multipling by 3.33333 to get near the 1 number again
    serialize_word(1 / 4)
    serialize_word(1 / 5)

    // those all returns 1,
    // it's to proof that doing the inverse path (multipling to those numbers to do the modular path back) it will come back to 1
    serialize_word(1 / 2 * 2)
    serialize_word(1 / 2 * 3)
    serialize_word(1 / 2 * 4)
    serialize_word(1 / 2 * 5)

    return ()
end
