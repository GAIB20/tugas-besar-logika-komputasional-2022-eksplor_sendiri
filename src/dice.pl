:- dynamic(doubleAmount/2).

doubleAmountUpdater(P, NS):-
    retractall(doubleAmount(P, _)),
    asserta(doubleAmount(P, NS)).

incrementDoubleAmount(P) :-
    doubleAmount(P, DA),
    NDA is DA + 1,
    doubleAmountUpdater(P, NDA).

resetDoubleAmount(P) :-
    doubleAmountUpdater(P, 0).

randomDice(Res) :-
    randomize,
    get_seed(M),
    Res is (M mod 6) + 1.

rollDices(Res1, Res2, Double):-
    randomDice(Res1),
    randomDice(Res2),
    write('Dadu 1: '),
    write(Res1), write('.'), nl,
    write('Dadu 2: '),
    write(Res2), write('.'), nl,
    (Res1 \== Res2 -> Double is 0 ; Double is 1).

doubleAmount(v, 0).
doubleAmount(w, 0).

throwDiceCheck(P, CanThrow):-
    isMinigame(0),
    unresolvedBankruptcy(P) -> (
        write('Lunasin tuh hutang dulu baru lempar dadu!'),
        CanThrow is 0
    ) ; (
        turn(P, 1),
        remainDice(P, RD),
        (RD > 0 -> CanThrow is 1 ; write('Anda tidak punya kesempatan roll dice lagi. Segera end turn.'), CanThrow is 0)
    ).

throwDice :- !,
    isPlaying(1),
    throwDiceCheck(P, 1),
    board(Board),
    location(P, PosI),
    indexOf(Board, PosI, IIn),
    throwDiceW(Double),
    (
        Double =:= 1 -> (
            doNothing
        ) ; (decrementDice(P)
        )
    ),
    location(P, Pos),
    indexOf(Board, Pos, IA),
    ((IIn >= IA, isPJailed(P, 0)) -> (
        addBalance(P, 4000),
        nl,
        write('Anda telah melewati go sehingga 4000 Mora telah diberikan'), nl
        ) ; (
            doNothing
    )),
    (
    (Pos == tx1 ; Pos == tx2) -> (
        payTax(P)
    ) ; (
        (Pos == cc1 ; Pos == cc2 ; Pos == cc3) -> (
            drawchancecard(P) 
        ) ; (
            (Pos \== jl, Pos \== go, Pos \== wt, Pos \== fp) -> (
                payRent(Pos, P)
                ) ; (
                    doNothing
                )
        )
    )
    ),
    (isPJailed(P, 0) -> (
        map
        ) ; (
        doNothing
        )
    ),
    !.

% Karena setelah lempar dadu pemain masih bisa jual aset, masih harus bayar sewa, dll, logika untuk pergantian turn bukan di sini, tapi di throwDice. 
% Logika untuk masuk penjara setelah 3 kali double ada di sini
% Ini wrapper.
throwDiceW(Double) :- 
    turn(PMoving, 1),
    write('Sekarang adalah giliran pemain '),
    write(PMoving), write('.'), nl,
    (isPJailed(PMoving, 1) -> throwDiceJail(PMoving, Double) ; throwDiceFree(PMoving, Double)),
    (\+ playerState(P, diceThrown) -> stateChanger(P, diceThrown) ; doNothing),
    !.

throwDiceJail(P, Double) :-
    incrementTurnInJail(P),
    rollDices(Res1, Res2, Double),
    turnInJail(P, TJ),
    Res is Res1 + Res2,
    incrementRollSum(P, Res),
    remainDiceUpdater(P, 0),
    (Double =:= 1 -> (
        getUnjailed(P), 
        write('Selamat, anda telah bebas dari penjara'),
        movePlayerStep(P, Res)
        ) ; (
            TJ =:= 3 -> (
                write('Telah ada di penjara dalam 3 turn, anda otomatis bebas'),
                movePlayerStep(P, Res)
            ) ; (
                write('Gagal mendapat double, masih dipenjara')
            )
        )
    ).


throwDiceFree(P, Double) :-
    rollDices(Res1, Res2, Double),
    Res is Res1 + Res2,
    incrementRollSum(P, Res),
    (Double =:= 1 -> (
        write('Double! '), 
        incrementDoubleAmount(P)
        ) ; (
            doNothing
        )
    ),
    (doubleAmount(P, 3) -> (
        getJailed(P), 
        resetDoubleAmount(P), 
        write('Anda masuk penjara karena mendapat Double 3 kali berturut-turut')
    ) ; (
        write('Anda maju sebanyak '),
        write(Res),
        write(' langkah.'),
        nl, 
        movePlayerStep(P, Res)
    )
    ), !.
    


