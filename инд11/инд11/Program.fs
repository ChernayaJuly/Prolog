// Learn more about F# at http://fsharp.org

open System
open System.Windows.Forms
open System.Drawing


let form = new Form(Text = "Площадь прямоугольника")
let button = new Button(Text = "вычислить площадь",Left=80, Top = 200,Height=30,Width = 100) 
form.Controls.Add(button)
button.Click.Add(fun evArgs -> MessageBox.Show("Площадь прямоугольника = ") |> ignore)

let a_label = new Label(Text = "введите длину", Left=20, Top = 30,Height=30,Width = 100)
form.Controls.Add(a_label)
let a_text = new TextBox(Left=25, Top =30,Height=30,Width = 150)
form.Controls.Add(a_text)

let b_label = new Label(Text = "введите ширину",Left=20, Top = 80,Height=30,Width = 100)
form.Controls.Add(b_label)
let b_text = new TextBox(Left=25, Top = 80,Height=30,Width = 150)
form.Controls.Add(b_text)
ооваомаимолла
Application.Run(form)

[<EntryPoint>]
let main argv =
    0 // return an integer exit code
