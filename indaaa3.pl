% длина списка
listLen(List, Len) :-
	listLen(List, 0, Len).

listLen([], CurrentLen, Len) :-
	Len = CurrentLen.

listLen([H|T], CurrentLen, Len) :-
	CurrentLenUpd is CurrentLen + 1,
	listLen(T, CurrentLenUpd, Len).

% получение элемента по индексу. нумерация с 0
getByIndex(List, Index, Result) :-
	getByIndex(List, 0, Index, Result), !.

getByIndex([H|T], CurLen, Index, Result) :-
	CurLen = Index,
	Result = H, !.

getByIndex([_|T], CurLen, Index, Result) :-
	not(CurLen = Index),
	CurLenUpd is CurLen + 1,
	getByIndex(T, CurLenUpd, Index, Result), !.

% повторяет ключ до заданной длины. например, расширяем ключ "key"
% до длины 10: keykeykeyk
repeatKeyAtTextLen(Key, ToLen, Out) :-
	listLen(Key, KeyLen),
	ToLen < KeyLen,% некуда дополнять
	Out = Key, !.

repeatKeyAtTextLen(Key, ToLen, Out) :-
	listLen(Key, KeyLen),
	not(ToLen < KeyLen),

	repeatKeyAtTextLen_(Key, KeyLen, KeyLen, ToLen, Key, Out).

repeatKeyAtTextLen_(_, _, CurrentLen, ToLen, CurrentKeyRep, Out) :-
	CurrentLen = ToLen, Out = CurrentKeyRep, !.

repeatKeyAtTextLen_(Key, KeyLenMem, CurrentLen, ToLen, CurrentKeyRep, Out) :-
	not(CurrentLen = ToLen),
	Index is CurrentLen mod KeyLenMem,
	CurrentLenUpd is CurrentLen + 1,
	getByIndex(Key, Index, Char),
	append(CurrentKeyRep, [Char], CurrentKeyRepUpd),
	repeatKeyAtTextLen_(Key, KeyLenMem, CurrentLenUpd, ToLen, CurrentKeyRepUpd, Out).


%считываем входные данные
vegenere(FilePath, Result) :-
	see(FilePath),
	read_list_str(Lines),
	seen,

	appendText(Lines, LinesProcessed),
	write('Loaded text: '), nl,
	write_str(LinesProcessed),

	read_str(Key, KeyLen, Flag),

	listLen(LinesProcessed, LoadedTextLen),
	repeatKeyAtTextLen(Key, LoadedTextLen, RepeatedKey),
	vegenereCode(LinesProcessed, RepeatedKey, Result),
	write('Coded text: '), nl, write_str(Result), !.

% тут шифруем
vegenereCode(Text, Key, CodedText) :-
	listLen(Text, TextLen),
	vegenereCode(Text, Key, [], CodedText), !.

vegenereCode([], Key, CodedText, Out) :-
	Out = CodedText, !.

vegenereCode([TextH|TextT], [KeyH|KeyT], CodedText, Out) :-
	97 =< TextH, %TextH от a до z

	TextCharN is TextH - 97, % немного читемости путем ввода переменных
	KeyCharN is KeyH - 97,
	CodedCharN is (TextCharN + KeyCharN + 1) mod 26,
	CodedChar is CodedCharN + 97,

	append(CodedText, [CodedChar], CodedTextUpd),
	vegenereCode(TextT, KeyT, CodedTextUpd, Out), !.

vegenereCode([TextH|TextT], Key, CodedText, Out) :-
	97 > TextH, % TextH  есть пробел или новая строка

	append(CodedText, [TextH], CodedTextUpd),
	vegenereCode(TextT, Key, CodedTextUpd, Out), !.

vegenereCode([], _, CodedText, Out) :-
	Out = CodedText, !.
