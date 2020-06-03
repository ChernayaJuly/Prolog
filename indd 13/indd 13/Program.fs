open System
open System.Windows.Forms
open System.Drawing

let form = new Form(Text = "списки",Left=1000, Top = 2000,Height=500,Width = 600)
let button = new Button(Text = "вывести",Left=250, Top = 350,Height=30,Width = 100)
form.Controls.Add(button)

let input_label = new Label(Text = "введите список ", Left=80, Top = 80,Height=30,Width = 120)
form.Controls.Add(input_label)
let input_text = new RichTextBox(Left=60, Top =120,Height=180,Width = 140)
//input_text.Text <- "2 3 6 7 8 4 16 11 32"
form.Controls.Add(input_text)

let res_label = new Label(Text = "результат",Left=400, Top = 80,Height=30,Width = 120)
form.Controls.Add(res_label)
let res_text = new RichTextBox(Left=370, Top = 120,Height=180,Width = 140)
form.Controls.Add(res_text)


let parseInput (text:string) =
    let rec parse listStr parsedText =
        match listStr with
        | h::t ->
            let number = Convert.ToInt32((string) h)
            parse t (List.append parsedText [number])
        | [] -> parsedText

    parse (List.ofArray (text.Split(' '))) []


let combinations n L = 
    let rec step left acc L = seq {
        match left, L with
        | 0, _ -> yield acc
        | _, [] -> ()
        | left, h::t ->
            yield! step (left-1) (h::acc) t
            yield! step left acc t
    }

    step n [] L

let f3nd (c, _, _) = c
let s3nd (_, c, _) = c
let t3nd (_, _, c) = c

let s4nd (c, _, _, _) = c
let f4nd (_, c, _, _) = c
let t4nd (_, _, c, _) = c
let fo4nd (_, _, _, c) = c


let workThis _ =
    let parsedInput = parseInput input_text.Text


    let pairs = List.ofSeq (combinations 2 parsedInput) |> List.map (fun x -> ((List.item 0 x), (List.item 1 x)))
    
    let anyPairIsMultipleFor (X:int) =
        match List.tryFindIndex (fun x -> ((fst x) * (snd x) = X)) pairs with
        | Some value -> true
        | None -> false

    let rec getIndexesForList2 list currentIndex acc =
        match list with
        | [] -> acc
        | h::t ->
            if (anyPairIsMultipleFor h) then
                getIndexesForList2 t (currentIndex + 1) (currentIndex::acc)
            else
                getIndexesForList2 t (currentIndex + 1) acc

    let list2 = getIndexesForList2 parsedInput 0 []


    let threes = List.ofSeq (combinations 3 parsedInput) |> List.map (fun x -> ((List.item 0 x), (List.item 1 x), (List.item 2 x)))

    let anyThreeIsSummFor (X:int) =
        match List.tryFindIndex (fun x -> ((f3nd x) + (s3nd x) + (t3nd x) = X)) threes with
        | Some value -> true
        | None -> false

    let rec getIndexesForList3 list currentIndex acc =
        match list with
        | [] -> acc
        | h::t ->
            if (anyThreeIsSummFor h) then
                getIndexesForList3 t (currentIndex + 1) (currentIndex::acc)
            else
                getIndexesForList3 t (currentIndex + 1) acc

    let list3 = getIndexesForList3 parsedInput 0 []

    let fours = List.ofSeq (combinations 4 parsedInput) |> List.map (fun x -> ((List.item 0 x), (List.item 1 x), (List.item 2 x), (List.item 3 x)))

    let anyFourIsDivsFor (X:int) =
        match List.tryFindIndex (fun x -> ( X <> (f4nd x) && X <> (s4nd x) && X <> (t4nd x) && X <> (fo4nd x) && X % (f4nd x) = 0 && X % (s4nd x) = 0 && X % (t4nd x) = 0 && X % (fo4nd x) = 0 )) fours with
        | Some value -> true
        | None -> false

    let rec getIndexesForList4 list currentIndex acc =
        match list with
        | [] -> acc
        | h::t ->
            if (anyFourIsDivsFor h) then
                getIndexesForList4 t (currentIndex + 1) (currentIndex::acc)
            else
                getIndexesForList4 t (currentIndex + 1) acc

    let list4 = getIndexesForList4 parsedInput 0 []

    (list2, list3, list4)

let workThisPrettyOut (l2, l3, l4) =
    let mutable gui_textOut = "List 2 is "

    let _ = List.iter (fun x -> (gui_textOut <- gui_textOut + " "  + x.ToString())) l2
    gui_textOut <- gui_textOut + "\r\nList 3 is "
    let _ = List.iter (fun x -> (gui_textOut <- gui_textOut + " "  + x.ToString())) l3
    gui_textOut <- gui_textOut + "\r\nList 4 is "
    let _ = List.iter (fun x -> (gui_textOut <- gui_textOut + " "  + x.ToString())) l4
    gui_textOut <- gui_textOut + "\r\n"

    res_text.Text<-gui_textOut

button.Click.Add(fun Args -> workThisPrettyOut (workThis 0) |> ignore)

do Application.Run(form)