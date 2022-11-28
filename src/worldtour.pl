worldTour :- isPlaying(0), !, fail.

worldTour:-
    turn(Player, 1),
    \+ location(Player, wt), !, 
    write('Stormterror hanya ada di tile World Tour'), fail.

worldTour:-
    turn(Player, 1),
    playerState(Player, diceThrown), !,
    write('Maaf kamu hanya bisa menaiki Stormterror digiliran selanjutnya'), fail.

worldTour:-
    write('Kamu akan dibawa keliling dunia di punggung Stormterror, dibantu oleh Venti ?'), nl,
    write('Tetapi kamu harus membelikan Venti sejumlah minuman seharga 5000 mora.'), nl,
    write('1. Siapa takut'), nl,
    write('2. Mora ku sedikit :<'), nl,
    repeat,
    write('Masukkan input: '),
    read(Input),
    (
        (Input =:= 1) -> (
            turn(Player, 1),
            balance(Player, Balance),
            (
                (Balance >= 5000) -> (
                    worldTourAccepted, !
                ) ; (
                    write('Mora kamu tidak cukup untuk membeli minuman di dawn winery'), !
                )
            )
        ) ; (
            (
                (Input =:= 2) -> (
                    write('Yah, Venti sedih karena keputusanmu :<'), !
                ) ; (
                    write('Coba masukan kembali masukan yang valid'), nl, fail
                )
            )
        )
    ).

worldTourAccepted:-
    write('Pilih tile tempat Stormterror mendarat'), nl,
    board(Board),
    repeat,
    write('Masukkan tile: '),
    read(Input),
    (
        (isElmt(Board, Input, 1)) -> (
            (
                (Input == wt) -> (
                    write('Stormterror tidak ingin mendarat di tempat yang sama'), nl, fail
                ) ; (
                    format('Pegangan erat, kamu akan dibawa ke tile ~w', [Input]), nl,
                    worldTourTravel(Input)
                )
            )
        ) ; (
            write('Maaf masukan tile kurang tepat'), nl,
            write('Ingat untuk menuliskan nama tile dengan lowercase'), nl, fail
        )
    ).

worldTourTravel(Pos):-
    turn(Player, 1),
    board(Board),
    movePlayerTo(Player, Pos),
    indexOf(Board, Pos, IA),
    ((24 > IA) -> (
        addBalance(Player, 4000),
        nl,
        write('Anda telah melewati go sehingga 4000 Mora telah diberikan'), nl
        ) ; (
            doNothing
    )),
    (
    (Pos == tx1 ; Pos == tx2) -> (
        payTax(Player)
    ) ; (
        (Pos == cc1 ; Pos == cc2 ; Pos == cc3) -> (
            drawchancecard(Player) 
        ) ; (
            (Pos \== jl, Pos \== go, Pos \== wt, Pos \== fp) -> (
                payRent(Pos, Player)
                ) ; (
                    doNothing
                )
        )
    )
    ),
    !.

