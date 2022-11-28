/* Percentage chance dari chance card */
/*
+ childe 4% (2/50)
- tax 8% (4/50)
+ prize 8% (4/50)
- zonk 4% (3/50)
+ getout 6% (3/50)
- gotojail 8% (4/50)
- backthreestep 6% (3/50)
+ threestep 6% (3/50)
+ birthday 8% (4/50)
- zonkyanfei 6% (3/50)
- meteor 2% (1/50)
+ pass 6% (3/50)
- paimon 6% (3/50)
- brokenteleport 6% (3/50)
+ teleportcard 6% (3/50)
- sedekahcard 4% (2/50)
+ bribezhonglicard 2% (1/50)
+ minigamecard 4% (2/50)
total - : 50%
total + : 50%
*/
choice(0, bribezhonglicard).
choice(1, childe).
choice(2, tax).
choice(3, tax).
choice(4, tax).
choice(5, tax).
choice(6, prize).
choice(7, prize).
choice(8, prize).
choice(9, prize).
choice(10, zonk).
choice(11, zonk).
choice(12, zonk).
choice(13, getout).
choice(14, getout).
choice(15, getout).
choice(16, gotojail).
choice(17, gotojail).
choice(18, gotojail).
choice(19, gotojail).
choice(20, backthreestep).
choice(21, backthreestep).
choice(22, backthreestep).
choice(23, threestep).
choice(24, threestep).
choice(25, threestep).
choice(26, birthday).
choice(27, birthday).
choice(28, birthday).
choice(29, birthday).
choice(30, minigamecard).
choice(31, zonkyanfei).
choice(32, zonkyanfei).
choice(33, zonkyanfei).
choice(34, meteor).
choice(35, pass).
choice(36, pass).
choice(37, pass).
choice(38, minigamecard).
choice(39, paimon).
choice(40, paimon).
choice(41, paimon).
choice(42, brokenteleport).
choice(43, brokenteleport).
choice(44, brokenteleport).
choice(45, teleportcard).
choice(46, teleportcard).
choice(47, teleportcard).
choice(48, sedekahcard).
choice(49, sedekahcard).

/* Ini fungsi yang di call saat di petak chancecard */
drawchancecard(P) :-
    randomize,
    get_seed(M),
    N is M mod 50,
    choice(N, Card),
    chancecard(Card, P).



chancecard(tax, Player) :- kartupajak(Player).
chancecard(prize, Player) :- kartuhadiah(Player).
chancecard(zonk, Player) :- kartuzonk(Player).
chancecard(getout, Player) :- getkeluarpenjara(Player).
chancecard(gotojail, Player) :- pergikepenjara(Player).
chancecard(backthreestep, Player) :- mundurTigaLangkah(Player).
chancecard(threestep, Player) :- majuTigaLangkah(Player).
chancecard(birthday, Player) :- ulangTahun(Player).
chancecard(zonkyanfei, Player) :- kartuyanfei(Player).
chancecard(meteor, _) :- meteorZhongli.
chancecard(pass, Player) :- passgo(Player).
chancecard(paimon, Player) :- kartupaimon(Player).
chancecard(childe, Player) :- kartuchilde(Player).
chancecard(brokenteleport, Player) :- brokenteleport(Player).
chancecard(teleportcard, Player) :- teleport(Player).
chancecard(sedekahcard, Player) :- sedekah(Player). 
chancecard(bribezhonglicard, Player) :- getbribeZhongli(Player).
chancecard(minigamecard, _) :- minigame.


kartupajak(P) :-
    write('\nAnda mendapatkan kartu pajak!\n'),
    moveToNearestTax(P),
    write('\nYanFei menyadari kamu lupa membayar pajak bulan kemarin, kamu harus pergi ke rumah YanFei lalu membayar pajak.\n'),
    payTax(P).

kartuhadiah(P) :-
    write('\nAnda mendapatkan kartu hadiah!\n'),
    randomize,
    get_seed(M),
    A is M mod 2000,
    B is A * 5,
    format('~nAnda diangkat menjadi anak asuh Ningguang! Mora Anda bertambah sebesar : ~w~n', [B]),
    addBalance(P, B).

kartuzonk(P) :-
    write('\nAnda mendapatkan kartu zonk!\n'),
    randomize,
    get_seed(M),
    A is M mod 2000,
    C is A * 2,
    format('~nFatui datang ke safehousemu! Kamu kehilangan Mora sebesar : ~w~n', [C]),
    subtractBalance(P, C).

getkeluarpenjara(P) :-
    write('\nAnda mendapatkan kartu keluar penjara!\n'),
    insertToInventory(P, getout),   
    write('\nKamu diperbolehkan memanggil Xiao untuk keluar penjara,gunakan commang xiaoHelp untuk menggunakan kartu ini\n'), !.

/* Ini bisa di call oleh user */
xiaoHelp :-
    isPlaying(1),
    turn(P, 1),
    cardInventory(P, Inventory),
    isElmt(Inventory, getout, Ans),
    Ans =:= 1, !,
    usekeluarpenjara(P, Inventory).

usekeluarpenjara(P, _) :-
    isPJailed(P, X), 
    X =:= 1, !,
    deleteFromInventory(P, getout),
    getUnjailed(P),
    write('\nKamu memanggil Xiao! Kamu dapat keluar dari penjara.\n'), !.

pergikepenjara(P) :-
    write('\nAnda mendapatkan kartu masuk penjara!\n'),
    write('\nANGKAT TANGAN!! Anda masuk ke penjara!\n'),
    getJailed(P),
    endTurn.

mundurTigaLangkah(P) :-
    write('\nAnda mendapatkan kartu mundur tiga langkah!\n'),
    write('\nKamu kejatuhan tombak Xiao! Mundur 3 langkah, 1 2 3, DOR!\n'),
    movePlayerStep(P, -3),
    location(P, Pos),
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
    ).

majuTigaLangkah(P) :-
    write('\nAnda mendapatkan kartu maju tiga langkah!\n'),
    write('\nKamu didorong ushi, maju 3 langkah\n'),
    movePlayerStep(P, 3),
    location(P, Pos),
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
    ).

ulangTahun(P) :-
    write('\nAnda mendapatkan kartu ulang tahun!\n'),
    write('\nOTANJOUBI OMEDETOU! Semua player membayar Anda sebesar 500, yang tidak bayar akan dipukul oleh Itto\n'),
    bayarKeP(P, 500).

bayarKeP(P, Amount) :-
    player(X),
    X \= P,
    addBalance(P, 500),
    subtractBalance(X, Amount).

kartuyanfei(P) :-
    write('\nAnda mendapatkan kartu yanfei!\n'),
    randomize,
    get_seed(M),
    A is M mod 1000,
    B is A * (-1),
    format('~nYanFei menyadari Anda melakukan penggelapan pajak! Anda didenda sebesar : ~w~n', [A]),
    addBalance(P, B).

meteorZhongli :-
    write('\nAnda mendapatkan kartu meteor zhongli!\n'),
    randomize,
    get_seed(M),
    boardAssetLength(Length),
    A is M mod Length,
    boardAsset(Board),
    getElmt(Board, A, Tile),
    tileAsset(Tile, State, Player),
    format('~nTile ~w terkena meteor zhongli! semua bangunan di tile tersebut kandas :(~n', [Tile]),
    updateKandas(Tile, State, Player).

updateKandas(Tile, -2, Player) :-
    tileAssetUpdater(Tile, -2, Player), !.

updateKandas(Tile, -1, Player) :-
    tileAssetUpdater(Tile, -1, Player), !.

updateKandas(Tile, _, Player) :-
    tileAssetUpdater(Tile, 0, Player), !.

passgo(Player) :-
    addBalance(Player, 5000),
    movePlayerTo(Player, go).

kartupaimon(P) :-
    write('\nAnda mendapatkan kartu paimon!\n'),
    randomize,
    get_seed(M),
    A is M mod 500,
    B is A * (-1),
    format('~nPaimon kabur! Dia bermain dan menghabiskan Mora Anda sebesar : ~w~n', [A]),
    addBalance(P, B).

kartuchilde(P) :-
    write('\nAnda mendapatkan kartu childe!\n'),
    randomize,
    get_seed(M),
    A is M mod 800,
    format('~nAnda diajak jalan-jalan oleh Childe! Anda diberi Mora sebesar : ~w~n', [A]),
    addBalance(P, A).

brokenTeleportWaypoint(P) :-
    write('\nAnda mendapatkan kartu broken teleport!\n'),
    randomize,
    get_seed(M),
    boardLength(Length),
    board(Board),
    A is M mod Length,
    getElmt(Board, A, Tile),
    format('~nTeleport waypoint yang Anda gunakan rusak! Anda diteleport ke tile ~w~n', [Tile]),
    movePlayerTo(P, Tile).

teleport(P) :-
    /* Teleport kalau teleport nya lewatin GO ga dapet uang ya! */
    write('\nAnda mendapatkan kartu teleport!\n'),
    write('\nMasukkan indeks teleport (input diakhiri titik) : '),
    read(Index),
    boardLength(Length),
    board(Board),
    Idx is Index mod Length,
    getElmt(Board, Idx, Tile),
    format('~nWhoosh! Anda diteleport ke tile ~w~n', [Tile]),
    write('\nNote : teleport tidak mendapatkan Mora! \nJika indeks lebih dari panjang board, akan di mod dengan panjang board! \n'),
    movePlayerTo(P, Tile),
    location(P, Pos),
    (
    (Pos == tx1 ; Pos == tx2) -> (
        payTax(P)
    ) ; (
        (Pos == cc1 ; Pos == cc2 ; Pos == cc3) -> (
            doNothing 
        ) ; (
            (Pos \== jl, Pos \== go, Pos \== wt, Pos \== fp) -> (
                payRent(Pos, P)
                ) ; (
                    doNothing
                )
        )
    )
    ).

sedekah(P) :-
    write('\nAnda mendapatkan kartu sedekah!\n'),
    balanceMin(PMin),
    PMin == P,
    write('\nAnda diminta bersedekah oleh Barbara, tapi Anda yang termiskin, jadi Barbara kasihan dan memberimu sedekah 500 Mora\n'),
    addBalance(P, 500), !.

sedekah(P) :-
    write('\nAnda mendapatkan kartu sedekah!\n'),
    balanceMin(PMin),
    format('~nAnda diminta bersedekah oleh Barbara, Anda bersedekah ke player ~w sebesar 500~n', [PMin]),
    addBalance(PMin, 500),
    addBalance(P, -500), !.


balanceMin(PlayerMin) :-
  balance(PlayerMin, Bal),
  \+ (balance(Other, BalO), Other \= PlayerMin, Bal > BalO), !.

getbribeZhongli(P) :-
    write('\nAnda mendapatkan kartu suap zhongli!\n'),
    write('\nKamu mendapatkan 5 toren osmanthus wine!\nkamu bisa menggunakan ini ditambah dengan 7000 Mora untuk menyuap Zhongli mengirimkan meteor dengan command suapZhongli\n'),
    insertToInventory(P, bribezhonglicard), !.

/* Fungsi ini bisa dipanggil oleh pemain */
suapZhongli :-
    isPlaying(1),
    turn(P, 1),
    cardInventory(P, Inventory),
    isElmt(Inventory, bribezhonglicard, Ans),
    Ans =:= 1, !,
    deleteFromInventory(P, bribezhonglicard),
    balance(P, Bal),
    Bal >= 7000, !,
    write('\nKamu membayar 7000 Mora\n'),
    addBalance(P, -7000),
    write('\nMasukkan indeks kota yang ingin dijatuhi meteor (diakhiri titik) : '),
    read(Index),
    boardLength(Length),
    board(Board),
    Idx is Index mod Length,
    getElmt(Board, Idx, Tile),
    format('~nTile ~w terkena meteor zhongli! semua bangunan di tile tersebut kandas :(~n', [Tile]),
    tileAsset(Tile, State, P),
    updateKandas(Tile, State, P).

minigame :-
    write('\nAnda mendapatkan kartu minigame!\n'),
    startMinigame.