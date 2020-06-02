open System

let lala = 64000

let min_pow x n m =
    let rec min_pow1 acc m1 x n m =
        if (acc > x) then acc
        else if (m1 < m) then min_pow1 (acc*n) (m1 + 1) x n m
             else lala

    let rec min_pow2 acc x n m =
        if (n > 1) then
            let cur_numb = min_pow1 (n*n) 2 x n m
            if (cur_numb < acc) then min_pow2 cur_numb x (n-1) m
            else min_pow2 acc x (n-1) m
        else acc
    min_pow2 lala x n m

let iz9 n m =
    let rec iz9_ (x: int) n m =
        Console.WriteLine("{0} ", x) |> ignore
        let next_x = min_pow x n m
        if (next_x = lala) then 0
        else iz9_ next_x n m
    iz9_ 4 n m

[<EntryPoint>]
let main argv =
    iz9 3 3 |> ignore
    0 // return an integer exit code
