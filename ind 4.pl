list([H|_],H).
list([_|T],E):-list(T,E).


ind4:-People=[_,_,_],
                     list(People,[aladar,_,_]),
                     list(People,[bela,_,_]),
                     list(People,[balash,_,_]),
                     list(People,[_,aptekar,_]),
                     list(People,[_,buchgalter,_]),
                     list(People,[_,agronom,_]),
                     list(People,[_,_,budapesht]),
                     list(People,[_,_,bekeshchab]),
                     list(People,[_,_,asod]),

                    not(list(People,[balash,aptekar,_])),
                    not(list(People,[balash,_,budapesht])),

                    ((list(People,[aladar,agronom,asod]),
                      list(People,[bela,buchgalter,budapesht]));

                     (list(People,[aladar,agronom,asod]),
                     list(People,[bela,buchgalter,bekeshchab]));

                     (list(People,[aladar,agronom,asod]),
                     list(People,[balash,buchgalter,budapesht]));

                     (list(People,[aladar,agronom,asod]),
                     list(People,[balash,buchgalter,bekeshchab]));

                     (list(People,[aladar,aptekar,asod]),
                     list(People,[balash,buchgalter,bekeshchab]));

                     (list(People,[aladar,aptekar,asod]),
                     list(People,[balash,buchgalter,budapesht]));

                     (list(People,[aladar,aptekar,asod]),
                     list(People,[bela,buchgalter,bekeshchab]));

                     (list(People,[aladar,aptekar,asod]),
                     list(People,[bela,buchgalter,budapesht]))),
 write(People),nl,!.



