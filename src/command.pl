:- dynamic(playerState/2).
:- dynamic(isPlaying/1).

isPlaying(0).

start :- 
  retract(isPlaying(0)),
  asserta(isPlaying(1)),
  jailUpdater(v, 0),
  jailUpdater(w, 0),
  turnInJailUpdater(v, 0),
  turnInJailUpdater(w, 0),
  doubleAmountUpdater(v, 0),
  doubleAmountUpdater(w, 0),
  retractall(balance(v, _)),
  asserta(balance(v, 20000)),
  retractall(balance(w, _)),
  asserta(balance(w, 20000)),
  movePlayerTo(v, go),
  movePlayerTo(w, go),
  retractall(cardInventory(v, _)),
  asserta(cardInventory(v, [])),
  retractall(cardInventory(w, _)),
  asserta(cardInventory(w, [])),
  retractall(unresolvedBankruptcy(_)),
  turnUpdater(v, 1),
  turnUpdater(w, 0),
  remainDiceUpdater(v, 1),
  remainDiceUpdater(w, 0),
  initAsset,
  retractall(playerState(_, _)),
  retractall(guessSuccess(_)),
  asserta(guessSuccess(0)),
  retractall(isMinigame(_)),
  asserta(isMinigame(0)),
  rollSumUpdater(v, 0),
  rollSumUpdater(w, 0),
  write(' __        __         _                                       _               _____                                  _   '), nl,
  write(' \\ \\      / /   ___  | |   ___    ___    _ __ ___     ___    | |_    ___     |_   _|   ___  __   __  _   _    __ _  | |_ '), nl,
  write('  \\ \\ /\\ / /   / _ \\ | |  / __|  / _ \\  | \'_ ` _ \\   / _ \\   | __|  / _ \\      | |    / _ \\ \\ \\ / / | | | |  / _` | | __|'), nl,
  write('   \\ V  V /   |  __/ | | | (__  | (_) | | | | | | | |  __/   | |_  | (_) |     | |   |  __/  \\ V /  | |_| | | (_| | | |_ '), nl,
  write('    \\_/\\_/     \\___| |_|  \\___|  \\___/  |_| |_| |_|  \\___|    \\__|  \\___/      |_|    \\___|   \\_/    \\__, |  \\__,_|  \\__|'), nl,
  write('                                                                                                     |___/               '), nl.

setGameOver(Loser) :-
  isPlaying(1),
  player(Winner),
  Winner \== Loser,
  !,
  retract(isPlaying(_)),
  asserta(isPlaying(0)),
  write('   _____                                 ____                        '), nl,
  write('  / ____|                               / __ \\                       '), nl,
  write(' | |  __    __ _   _ __ ___     ___    | |  | | __   __   ___   _ __ '), nl,
  write(' | | |_ |  / _` | | \'_ ` _ \\   / _ \\   | |  | | \\ \\ / /  / _ \\ | \'__|'), nl,
  write(' | |__| | | (_| | | | | | | | |  __/   | |__| |  \\ V /  |  __/ | |   '), nl,
  write('  \\_____|  \\__,_| |_| |_| |_|  \\___|    \\____/    \\_/    \\___| |_|   '), nl, nl,
  write('This realm is no home for a princess...'),nl, nl,
  format('Pemain ~w menang. Pemain ~w kalah.', [Winner, Loser]), nl,
  write('Lakukan perintah start untuk memulai kembali permainan.'), nl.


stateChanger(Player, NewState):-
    retractall(playerState(Player, _)),
    asserta(playerState(Player, NewState)).

mora:-
    isPlaying(1),
    turn(Player, 1),
    balance(Player, Balance),
    format('Mora: ~d', [Balance]), !.

getParam(Param, X):-
    Param == tanah, 
    X is 0, !.

getParam(Param, X):-
    Param == bangunan1, 
    X is 1, !.

getParam(Param, X):-
    Param == bangunan2, 
    X is 2, !.

getParam(Param, X):-
    Param == bangunan3, 
    X is 3, !.

getParam(Param, X):-
    Param == landmark, 
    X is 4, !.

getParam(_, _):-
    fail.

buy(_) :- isPlaying(0), !, fail.

buy(Param):-
    \+ getParam(Param, _), !, write('Pastikan parameter dari buy merupakan salah satu dari "tanah", "bangunan1", "bangunan2", "bangunan3", atau "landmark".'), fail.

buy(_):-
    turn(Player, 1),
    \+ playerState(Player, diceThrown), !, write('Lempar dadu terlebih dahulu'), fail.

buy(Param):-
    turn(Player, 1),
    location(Player, Tile),
    (
        (Tile == go) -> (
            buyGoInit(Param)
        ) ; (
            \+ isProperty(Tile), !, write('Pastikan berada di tile properti atau GO untuk membangun'), fail
        )
    ).

buy(Param):-
    turn(Player, 1),
    location(Player, Tile),
    tileAsset(Tile, State, Owner),
    balance(Player, Balance),
    getParam(Param, X),
    (
    Owner \== Player -> (
        Owner \== none -> (
            write('Gunakan command acquisition'), !
        ) ; (
            X =:= 0 -> (
                buyTile(Player, Tile), !
            ) ; (
                X =:= 4 -> (
                    write('Anda harus mempunyai 3 bangunan terlebih dahulu'), !
                ) ; (
                    propertyPrices(Tile, Prices), 
                    sumUntil(Prices, X, Sum),
                    Sum > Balance -> (
                        write('Uang anda tidak mencukupi'), !
                    ) ; (
                        buyTile(Player, Tile),
                        repeat,
                        buyAset(Player, Tile, r),
                        tileAsset(Tile, X, Player), !
                    ) 
                )
            )
        )
    ) ; (
        getParam(Param, X),
        tileAsset(Tile, State, Owner),
        (
        (X =< State) -> (
            write('Anda sudah memiliki tile ataupun bangunan dengan jumlah tersebut'), !
        ) ; (
            X =:= 4 -> (
                State =:= 3 -> (
                    buyAset(Player, Tile, l), !
                ) ; (
                    write('Anda harus mempunyai 3 bangunan terlebih dahulu'), !
                )
            ) ; (
                propertyPrices(Tile, Prices), 
                sumUntil(Prices, X, Sum),
                sumUntil(Prices, State, SumOwned), !,
                ((Sum - SumOwned) > Balance) -> (
                    write('Mora anda tidak mencukupi'), !
                ) ; (
                    repeat,
                    buyAset(Player, Tile, r),
                    tileAsset(Tile, X, Player)
                ) 
            )
        )
        )
    )
    ).

buyGoInit(Param):-
    write('Kamu bertemu Alice sang penyihir di tile GO, dan dia menawarka\nkamu untuk build di tile properti yang sudah kamu punya'), nl,
    repeat,
    write('Masukan tile properti yang ingin dibangun oleh Alice: '),
    read(Tile),
    (
        isProperty(Tile) -> (
            buyGo(Param, Tile)
        ) ; (
            write('Masukan nama tile properti yang valid'), nl,
            write('Ingat nama tile memakai lowercase'), nl, fail
        )
    ).
    
    

buyGo(Param, Tile):-
    turn(Player, 1),
    tileAsset(Tile, State, Owner),
    balance(Player, Balance),
    getParam(Param, X),
    (
    Owner \== Player -> (
        Owner \== none -> (
            write('Kamu tidak bisa mengakuisisi dari tile GO'), !
        ) ; (
            write('Kamu tidak bisa membeli tile dari tile GO'), !
        )
    ) ; (
        getParam(Param, X),
        tileAsset(Tile, State, Owner),
        (
        (X =< State) -> (
            write('Anda sudah memiliki tile ataupun bangunan dengan jumlah tersebut'), !
        ) ; (
            X =:= 4 -> (
                State =:= 3 -> (
                    buyAset(Player, Tile, l), !
                ) ; (
                    write('Anda harus mempunyai 3 bangunan terlebih dahulu'), !
                )
            ) ; (
                propertyPrices(Tile, Prices), 
                sumUntil(Prices, X, Sum),
                sumUntil(Prices, State, SumOwned), !,
                ((Sum - SumOwned) > Balance) -> (
                    write('Mora anda tidak mencukupi'), !
                ) ; (
                    repeat,
                    buyAset(Player, Tile, r),
                    tileAsset(Tile, X, Player)
                ) 
            )
        )
        )
    )
    ).