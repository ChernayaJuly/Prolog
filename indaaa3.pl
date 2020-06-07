% ����� ������
listLen(List, Len) :-
	listLen(List, 0, Len).

listLen([], CurrentLen, Len) :-
	Len = CurrentLen.

listLen([H|T], CurrentLen, Len) :-
	CurrentLenUpd is CurrentLen + 1,
	listLen(T, CurrentLenUpd, Len).

% ��������� �������� �� �������. ��������� � 0
getByIndex(List, Index, Result) :-
	getByIndex(List, 0, Index, Result), !.

getByIndex([H|T], CurLen, Index, Result) :-
	CurLen = Index,
	Result = H, !.

getByIndex([_|T], CurLen, Index, Result) :-
	not(CurLen = Index),
	CurLenUpd is CurLen + 1,
	getByIndex(T, CurLenUpd, Index, Result), !.

% ��������� ���� �� �������� �����. ��������, ��������� ���� "key"
% �� ����� 10: keykeykeyk
repeatKeyAtTextLen(Key, ToLen, Out) :-
	listLen(Key, KeyLen),
	ToLen < KeyLen,% ������ ���������
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


%��������� ������� ������
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

% ��� �������
vegenereCode(Text, Key, CodedText) :-
	listLen(Text, TextLen),
	vegenereCode(Text, Key, [], CodedText), !.

vegenereCode([], Key, CodedText, Out) :-
	Out = CodedText, !.

vegenereCode([TextH|TextT], [KeyH|KeyT], CodedText, Out) :-
	97 =< TextH, %TextH �� a �� z

	TextCharN is TextH - 97, % ������� ��������� ����� ����� ����������
	KeyCharN is KeyH - 97,
	CodedCharN is (TextCharN + KeyCharN + 1) mod 26,
	CodedChar is CodedCharN + 97,

	append(CodedText, [CodedChar], CodedTextUpd),
	vegenereCode(TextT, KeyT, CodedTextUpd, Out), !.

vegenereCode([TextH|TextT], Key, CodedText, Out) :-
	97 > TextH, % TextH  ���� ������ ��� ����� ������

	append(CodedText, [TextH], CodedTextUpd),
	vegenereCode(TextT, Key, CodedTextUpd, Out), !.

vegenereCode([], _, CodedText, Out) :-
	Out = CodedText, !.
