getElmt([], _, _) :- fail.
getElmt([X|_], I, R) :- I is 0, !, R = X.
getElmt([_|Y], I, R) :- I1 is I - 1, getElmt(Y, I1, R).

insertElmtLast([], X, [X]).
insertElmtLast([H | T], X, List) :-
    insertElmtLast(T, X, A),
    List = [H | A].

deleteAt([_ | T], 0, T).
deleteAt([H | T], Index, List) :-
    I is Index - 1,
    deleteAt(T, I, A),
    List = [H | A].

deleteElmt(ListAwal, Elmt, ListAkhir) :-
    indexOf(ListAwal, Elmt, Idx),
    deleteAt(ListAwal, Idx, ListAkhir).

isElmt([X | _], X, 1).
isElmt([_ | T], Elmt, Answer) :-
    isElmt(T, Elmt, A),
    Answer is A.

setElmt([], _, _, _) :- fail.
setElmt(_, I, _, _) :- I < 0, fail.
setElmt([_|Y], I, V, R) :- I is 0, !, R = [V|Y].
setElmt([X|Y], I, V, R) :- I1 is I - 1, setElmt(Y, I1, V, R1), R = [X|R1].

indexOf([], _, _) :- fail.
indexOf([X|_], El, R) :- X = El, !, R is 0.
indexOf([_|Y], El, R) :- indexOf(Y, El, R2), R is R2 + 1.

sumUntil([], _, 0) :- !.
sumUntil([X|_], 0, X) :- !.
sumUntil([X|Y], IndexUntil, Res) :- IndexNext is IndexUntil - 1, sumUntil(Y, IndexNext, Res2), Res is Res2 + X.

isSublist([H|T], ParentTile, Res) :-
    isElmt(ParentTile, H, 1), isSublist(T, ParentTile, 1) -> (
        Res is 1
    ) ; (
        Res is 0
    ).

isSublist([], _, 1).
