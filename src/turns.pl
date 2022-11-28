:- dynamic(turn/2).
:- dynamic(remainDice/2).
:- dynamic(rollSum/2).

turn(v, 1).
turn(w, 0).

turnUpdater(P, NT):-
    retractall(turn(P, _)),
    asserta(turn(P, NT)).

remainDice(v, 1) :- !.
remainDice(w, 0) :- !.

remainDiceUpdater(P, NRD):-
    retractall(remainDice(P, _)),
    asserta(remainDice(P, NRD)).

firstTurn(v, 0) :- rollSum(v, Sum), boardLength(BL), Sum >= BL.
firstTurn(v, 1) :- rollSum(v, Sum), boardLength(BL), Sum < BL.
firstTurn(w, 0) :- rollSum(w, Sum), boardLength(BL), Sum >= BL.
firstTurn(w, 1) :- rollSum(w, Sum), boardLength(BL), Sum < BL.

rollSum(v, 0).
rollSum(w, 0).

rollSumUpdater(P, NRS):-
    retractall(rollSum(P, _)),
    asserta(rollSum(P, NRS)).

endTurn :-
    turn(P, 1), !,
    remainDice(P, 0) -> (
        resetDoubleAmount(P),
        unresolvedBankruptcy(P) -> (
            write('Lunasin tuh hutang dulu baru selesaikan giliran!'),
            fail
        ) ; (
            retractall(playerState(P, _)),
            turn(v, T1),
            turn(w, T2),
            (
                (T1 =:= 1 -> (turnUpdater(v, 0), remainDiceUpdater(w, 1)) ; turnUpdater(v, 1)),
                (T2 =:= 1 -> (turnUpdater(w, 0), remainDiceUpdater(v, 1)) ; turnUpdater(w, 1))
            )
        )
    ) ; (
        write('Tidak bisa mengakhiri giliran, anda masih memiliki kesempatan melempar dadu')
    ).

decrementDice(P) :-
    remainDice(P, RD),
    (RD =:= 0 -> (
        doNothing
    ) ; (
        NRD is RD - 1,
        remainDiceUpdater(P, NRD)
    )
    ), !.

incrementDice(P):-
    remainDice(P, RD),
    NRD is RD + 1,
    remainDiceUpdater(P, NRD).

incrementRollSum(P, AddedAmount) :-
    rollSum(P, RS),
    NRS is RS + AddedAmount,
    rollSumUpdater(P, NRS).
