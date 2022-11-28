:- dynamic(tileAsset/3).
:- dynamic(tileInventory/2).


tileInventory(v, []).
tileInventory(w, []).
% Status aset di tiap tile
% -2 : tile tidak bertuan
% -1 : tile sedang di-mortgage
% 0 : tile tidak ada properti apapun tapi ada yang punya
% 1-3 : tile punya bangunan sejumlah itu
% 4 : tile punya landmark
tileAsset(a1,-2, none).
tileAsset(a2,-2, none).
tileAsset(a3,-2, none).
tileAsset(b1,-2, none).
tileAsset(b2,-2, none).
tileAsset(b3,-2, none).
tileAsset(c1,-2, none).
tileAsset(c2,-2, none).
tileAsset(c3,-2, none).
tileAsset(d1,-2, none).
tileAsset(d2,-2, none).
tileAsset(d3,-2, none).
tileAsset(e1,-2, none).
tileAsset(e2,-2, none).
tileAsset(e3,-2, none).
tileAsset(f1,-2, none).
tileAsset(f2,-2, none).
tileAsset(f3,-2, none).
tileAsset(g1,-2, none).
tileAsset(g2,-2, none).
tileAsset(g3,-2, none).
tileAsset(h1,-2, none).
tileAsset(h2,-2, none).

colorGroup(brown, [a1, a2, a3]).
colorGroup(cyan, [b1, b2, b3]).
colorGroup(magenta, [c1, c2, c3]).
colorGroup(orange, [d1, d2, d3]).
colorGroup(red, [e1, e2, e3]).
colorGroup(yellow, [f1, f2, f3]).
colorGroup(green, [g1, g2, g3]).
colorGroup(blue, [h1, h2]).

tileAssetUpdater(Tile, NS, NO):-
    retractall(tileAsset(Tile, _, _)),
    asserta(tileAsset(Tile, NS, NO)).

tileInventoryUpdater(P, NewInventory):-
    retractall(tileInventory(P, _)),
    asserta(tileInventory(P, NewInventory)).

initTileAsset([]) :- !.
initTileAsset([H|T]) :-
    tileAssetUpdater(H, -2, none),
    initTileAsset(T).

initAsset :-
    boardAsset(BoardAsset),
    initTileAsset(BoardAsset),
    tileInventoryUpdater(v, []),
    tileInventoryUpdater(w, []).

inventoryAppender(P, NewTile):-
    tileInventory(P, Inventory),
    insertElmtLast(Inventory, NewTile, NewInventory),
    tileInventoryUpdater(P, NewInventory).

inventoryDeleter(P, NewTile):-
    tileInventory(P, Inventory),
    deleteElmt(Inventory, NewTile, NewInventory),
    tileInventoryUpdater(P, NewInventory).

% Groupname adalah nama dari grup warna Tile
colorGroupOfTile(Tile, GroupName, Res) :-
    colorGroup(GroupName, TileList),
    isElmt(TileList, Tile, Res), !.

% TileList adalah list tile dari grup warna Tile
tileListOfTile(Tile, TileList, Res) :-
    colorGroup(_, TileList),
    isElmt(TileList, Tile, Res), !.

% Res adalah apakah P memiliki set komplit dari grup warna Tile
completeSet(P, Tile, Res):-
    colorGroupOfTile(Tile, GroupName, 1),
    colorGroup(GroupName, TileList),
    tileInventory(P, Inventory),
    isSublist(TileList, Inventory, Res), !.

% Menghasilkan status aset yang sesuai
assetStatusWriter(PropStat) :-
    PropStat >= 1, PropStat =< 3,
    format('Bangunan ~w', [PropStat]), !.

assetStatusWriter(-2) :-
    write('Tanah tak bertuan'), !.

assetStatusWriter(-1) :-
    write('Hipotek'), !.

assetStatusWriter(0) :-
    write('Tanah'), !.

assetStatusWriter(4) :-
    write('Landmark'), !.

% Cek dasar apakah pemain bisa me-mortgage atau menebus mortgage tile
canRedeemBasicCheck(P, Tile, Res) :-
    (turn(P, 1),
    tileInventory(P, Inventory),
    isElmt(Tile,Inventory, 1)) -> Res is 1 ; Res is 0, !.

% Cek dasar apakah pemain bisa membeli properti di sebuah tile
canBuyBasicCheck(P, Tile, Res):-
    turn(P, 1) -> (
        (\+ location(P, Tile), \+ location(P, go)) -> (
            write('Anda tidak berada di tile yang tepat'), !
            ) ; ((
            tileInventory(P, Inventory),
            isElmt(Inventory, Tile, 1)) -> (
                Res is 1, !
            ) ; (
                Res is 0, write('Anda tidak memiliki tile yang bersangkutan'), !
            ))
        ) ; (
            write('Bukan giliran anda!'), !
        ).

% Take over tile orang
acquireTile :- !,
    turn(P, 1),
    playerState(P, diceThrown),
    location(P, Tile),
    tileAsset(Tile, Level, Owner),
    (\+(Owner = none), \+(Level =:= 4)) -> (
        balance(P, Bal),
        propertyPrices(Tile, Prices),
        getElmt(Prices, Level, Price),
        Bal >= 2 * Price -> 
            (AP is 2 * Price,
            subtractBalance(P, AP),
            addBalance(Owner, AP),
            inventoryAppender(P, Tile),
            inventoryDeleter(Owner, Tile),
            tileAssetUpdater(Tile, Level, P),
            write('Berhasil akuisisi properti'), nl
        ) ; (
            write('Mora anda tidak cukup dasar miskin!')
        )
    ) ; (
        write('Bangunan tidak memenuhi kriteria akuisisi')
    ).

% Membeli Tile
buyTile(P, Tile):-
    turn(P, 1) -> (
        (\+ location(P, Tile), \+ location(P, go)) -> (
            write('Anda tidak berada di tile yang tepat'), !
            ) ; (
                balance(P, Bal),
                tileAsset(Tile, TileAsset, _),
                TileAsset =:= -2 -> (
                    propertyPrices(Tile, Prices),
                    getElmt(Prices, 0, Price),
                    Bal >= Price -> (
                        subtractBalance(P, Price),
                        inventoryAppender(P, Tile),
                        tileAssetUpdater(Tile, 0, P),
                        write('Berhasil membeli tile'), nl
                    ) ; (
                        write('Mora anda tidak cukup dasar miskin!')
                    )
                ) ; (
                    write('Bukan tanah tak bertuan!')
                )
            )
        ) ; (
            write('Bukan giliran anda!'), !
        ).

% Membeli rumah pada sebuah tile
buyAset(P, Tile, r):-
    canBuyBasicCheck(P, Tile, 1),
    tileAsset(Tile, TileAsset, P),
    TileAsset < 3, TileAsset >= 0 -> 
        propertyPrices(Tile, Prices),
        balance(P, Bal),
        TA2 is TileAsset + 1,
        getElmt(Prices, TA2, Price),
        Bal >= Price -> (
            subtractBalance(P, Price),
            tileAssetUpdater(Tile, TA2, P),
            format('Bangunan ~d berhasil dibeli', [TA2]),
            nl
        ) ; (
            write('Mora anda tidak cukup dasar miskin!'))
    ; (
        write('Bangunannya sudah maksimal ada 3')
    ).

% Membeli hotel pada sebuah tile
buyAset(P, Tile, l):-
    canBuyBasicCheck(P, Tile, 1),
    firstTurn(P, 0) -> (
        tileAsset(Tile, TileAsset, P),
        TileAsset =:= 3 -> (
            balance(P, Bal),
            propertyPrices(Tile, Prices),
            TA2 is TileAsset + 1,
            getElmt(Prices, TA2, Price),
            Bal >= Price -> (
                subtractBalance(P, Price),
                tileAssetUpdater(Tile, TA2, P),
                write('Landmark berhasil dibeli'),
                nl
            ) ; (
                write('Mora anda tidak cukup dasar miskin!')
            )
        ) ; (
            write('Anda harus memiliki 3 bangunan terlebih dahulu.')
        )
    ) ; (
        write('Anda tidak bisa membeli landmark di turn pertama')
    ).

% Menjual utuh tile
sellAset(P, Tile, t):- 
    canRedeemBasicCheck(P, Tile, 1),
    tileAsset(Tile, TileAsset, P),
    TileAsset =:= 0,
    NTA is -2,
    propertyPrices(Tile, Prices),
    getElmt(Prices, 0, Price),
    addBalance(P, Price),
    tileAssetUpdater(Tile, NTA).

% Menjual rumah pada sebuah tile
sellAset(P, Tile, r):-
    canBuyBasicCheck(P, Tile, 1),
    tileAsset(Tile, TileAsset, P),
    TileAsset < 4, TileAsset > 0,
    propertyPrices(Tile, Prices),
    getElmt(Prices, TileAsset, Price),
    SPrice is Price / 2,
    addBalance(P, SPrice),
    NTA is TileAsset - 1,
    tileAssetUpdater(Tile, NTA).

% Menjual hotel pada sebuah tile
sellAset(P, Tile, l):-
    canBuyBasicCheck(P, Tile, 1),
    tileAsset(Tile, TileAsset, P),
    TileAsset =:= 4,
    propertyPrices(Tile, Prices),
    getElmt(Prices, TileAsset, Price),
    SPrice is Price / 2,
    addBalance(P, SPrice),
    NTA is TileAsset - 1,
    tileAssetUpdater(Tile, NTA).

assetValue(Tile, Value) :-
    tileAsset(Tile, Level, _),
    propertyPrices(Tile, Prices),
    sumUntil(Prices, Level, Value).

assetCounter([], CurrentVal, CurrentVal).
assetCounter([H|T], CurrentVal, Result) :-
    assetValue(H, Value),
    Newval is CurrentVal + Value,
    assetCounter(T, Newval, Result).

totalAsset(Player, Amount) :- 
    tileInventory(Player, Inventory),
    assetCounter(Inventory, 0, Amount).

sellTileByIndex(Index, Player) :- % Jual keseluruhan asset beserta bangunannya
    tileInventory(Player, Inventory),
    getElmt(Inventory, Index, Tile),
    tileAsset(Tile, _, Player),
    assetValue(Tile, Value),
    SellValue is 0.8*Value,
    deleteAt(Inventory, Index, NewInventory),
    tileInventoryUpdater(Player, NewInventory),
    tileAssetUpdater(Tile, -2, none), % update jadi tidak bertuan
    addBalance(Player, SellValue).
