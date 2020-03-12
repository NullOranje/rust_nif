use rustler::{Encoder, Env, Error, Term};

mod atoms {
    rustler::rustler_atoms! {
        atom ok;
        atom error;
        //atom __true__ = "true";
        //atom __false__ = "false";
    }
}

rustler::rustler_export_nifs! {
    "Elixir.RustNif.RustPrimes",
    [
        ("prime_numbers", 1, prime_numbers, rustler::SchedulerFlags::DirtyCpu)
    ],
    None
}

fn is_prime_number(x: i64) -> bool {
    let end_of_range = x - 1;

    if x == 1 {
        false
    } else {
        !(2..end_of_range).any(|num| x % num == 0)
    }
}

fn prime_numbers<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let is_list: bool = args[0].is_list();

    if !is_list {
        Ok((atoms::error(), "No list supplied").encode(env))
    } else {
        let numbers: Vec<i64> = args[0].decode()?;
        let mut vec = Vec::new();

        for number in numbers {
            if is_prime_number(number) {
                vec.push(number)
            }
        }

        Ok((atoms::ok(), &*vec).encode(env))
    }
}
