list([H|_],H).
list([_|T],E):-list(T,E).


ind4:-People=[_,_,_],
                     list(People,[aladar,_,_]),
                     list(People,[bel,_,_]),
                     list(People,[balash,_,_]),
                     list(People,[_,aptekar,_]),
                     list(People,[_,buchgalter,_]),
                     list(People,[_,agronom,_]),
                     list(People,[_,_,budapesht]),
                     list(People,[_,_,bekeshchab]),
                     list(People,[_,_,asod]),

                     not(list(People,[balash,aptekar,_])),
                     not(list(People,[balash,_,budapesht])),
                     not(list(People,[balash,_,asod])),
                     not(list(People,[aladar,buchgalter,_])),

