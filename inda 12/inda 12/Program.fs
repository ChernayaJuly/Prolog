open System

// Ищет сумму в списке лист такую, что она равна target
let findSum target listInput =
    // Перебирает второй элемент. Ниже первый
    let rec findSecond lastH list =
        match list with
        | h::t ->
            if (lastH + h = target) then
                true
            else
                findSecond lastH t
        | [] -> false

    let rec findFirst list =
        match list with
        | h::t ->
            if (findSecond h t) then
                true
            else
                findFirst t
        | [] -> false
    
    match listInput with
    | h::t -> findFirst listInput
    | [] -> false

let buildList listInput =
    let rec buildList_ list currentOut =
        match list with
        | h::t ->
            if (findSum h listInput) then
                buildList_ t (h::currentOut)
            else
                buildList_ t currentOut
        | [] -> currentOut

    buildList_ listInput []


let parseInput (text:string) =
    let rec parse listStr parsedText =
        match listStr with
        | h::t ->
            let number = Convert.ToInt32((string) h)
            parse t (List.append parsedText [number])
        | [] -> parsedText

    parse (List.ofArray (text.Split(' '))) []

[<EntryPoint>]
let main argv =
    Console.WriteLine("Введите элементы списка через пробел. Ввод - окончание ввода.") |> ignore
    Console.Write("==> ") |> ignore
    let input = Console.ReadLine()
    printf "Результат: %A" (buildList (parseInput input))
    0