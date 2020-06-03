open System
open System.Windows.Forms
open System.Collections.Generic

let form = new Form(Text = "списки",Left=1000, Top = 2000,Height=500,Width = 600)

let input_label = new Label(Text = "введите список пробел", Left=80, Top = 80,Height=30,Width = 120)
form.Controls.Add(input_label)
let input_text = new RichTextBox(Left=60, Top =120,Height=180,Width = 140)
input_text.Text <- "Dictionary, please be accepted by the Buggod!"
form.Controls.Add(input_text)

let res_label = new Label(Text = "результат",Left=400, Top = 80,Height=30,Width = 120)
form.Controls.Add(res_label)
let res_text = new RichTextBox(Left=370, Top = 120,Height=180,Width = 140)
form.Controls.Add(res_text)

let nextChar ch = (char ((int ch) + 1)) 


let isLetter (x:char) =
    x >= 'A' && x <= 'Z' || x >= 'a' && x <= 'z'

let toLowerCase (x:char) =
    if (x >= 'A' && x <= 'Z') then
        let alphPos = (int x) - (int 'A')  
        char (int ('a') + alphPos)
    else
        x

let prettyDictOutput (dict : Dictionary<'A, 'B>) =
    let mutable gui_out_str = ""
    let rec outCharInfo (ch:char) =
        if (ch < 'z') then
            if (dict.ContainsKey(ch)) then
                gui_out_str <- gui_out_str + ch.ToString() + " counted " + dict.[ch].ToString() + " times\r\n"
                outCharInfo (nextChar ch)
            else
                outCharInfo (nextChar ch)
        else
            0
    outCharInfo 'a' |> ignore
    res_text.Text <- gui_out_str

let countLettersWithDict _ =
    let source = input_text.Text |> Seq.toList
    let dict = new Dictionary<char, int>()
    source |> List.map (fun x -> if dict.ContainsKey(toLowerCase x) && (isLetter x) then dict.[toLowerCase x] <- dict.[toLowerCase x] + 1 else if ((isLetter x)) then dict.Add(toLowerCase x, 1)) |> ignore
    prettyDictOutput dict

let button = new Button(Text = "вывести",Left=250, Top = 350,Height=30,Width = 100)
button.Click.Add(fun _ -> countLettersWithDict 5)
form.Controls.Add(button)

do countLettersWithDict 5
do Application.Run(form)