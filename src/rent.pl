:- dynamic(unresolvedBankruptcy/1).
:- dynamic(unresolvableBankruptcy/1).

declarePendingBankruptcy(Player) :- 
    retractall(unresolvedBankruptcy(_)),
    asserta(unresolvedBankruptcy(Player)).

resolveBankruptcy(Player) :- 
    retractall(unresolvedBankruptcy(Player)).

declarePermanentBankruptcy(Player) :- 
    retractall(unresolvableBankruptcy(_)),
    asserta(unresolvableBankruptcy(Player)).

cashableWorth(Player, Cash) :- % jumlah cash sekarang + cash hasil penjualan semua asset (80%*totalAsset)
  balance(Player, Balance),
  totalAsset(Player, Asset),
  Cash is Balance + 0.8*Asset.

isTileOwnedBy(Tile, Player) :- 
    tileOwner(Tile, Owner),
    Owner =:= Player.

rentAmount(Tile, Owner, Rent) :-
    tileOwner(Tile, Owner),
    tileAsset(Tile, PropertyLevel),
    propertyRent(Tile, PropertyLevel, BaseRent),
    completeSet(Owner, Tile, Res),
    (
        (Res == 1 -> Rent is BaseRent*2);
        (Rent is BaseRent)
    ).

isAbleToPayRent(Tile, Player) :- % pastikan tile sudah dimiliki oleh player lawan. Periksa dengan relasi isTileOwnedBy
    rentAmount(Tile, _, Rent),
    balance(Player, Balance),
    Balance >= Rent.

payRent(Tile, Payer) :- % pastikan player bisa bayar rent. Periksa dengan relasi isAbleToPayRent
    isAbleToPayRent(Tile, Payer) -> (
        rentAmount(Tile, Owner, Rent),
        addBalance(Owner, Rent),
        subtractBalance(Payer, Rent)
    ) ; (
        rentAmount(Tile, _, Rent),
        cashableWorth(Payer, Worth),
        balance(Payer, Balance),
        (Worth >= Rent) -> (
            write('Wah, moramu kurang! Apakah kamu ingin tetap melanjutkan permainan?'), nl,
            format('Uangmu ~d dan biaya sewa ~d', [Balance, Rent]), nl,
            declarePendingBankruptcy(Payer)
        ) ; (
            declarePermanentBankruptcy(Payer),
            write('Sayang sekali, moramu sudah tidak cukup. Selamat tinggal :)'), nl
        )
    ).

writeAssetList(Tile, No) :- 
    tileAsset(Tile, PropertyLevel),
    format('~d. ~w bangunan ~d : ', [No, Tile, PropertyLevel]), nl.

displayAssets([], _) :- !.

displayAssets([H|T], No) :- 
    writeAssetList(H, No),
    Next is No + 1,
    displayAssets(T, Next).

tidak :-
    unresolvedBankruptcy(Player),
    resolveBankruptcy(Player),
    declarePermanentBankruptcy(Player), % Permainan selesai. Reset ???
    write('Salah satu pemain telah menyatakan bangkrut, sehingga permainan selesai'), nl.

lanjut :-
    unresolvedBankruptcy(Player),
    repeat,
    write('Daftar propertimu:'), nl,
    tileInventory(Player, Inventory),
    displayAssets(Inventory, 1),
    read(No),
    sellTileByIndex(No, Player),
    balance(Player, Balance),
    location(Player, Tile),
    rentAmount(Tile, _, Rent),
    format('Moramu sekarang ~d dan biaya sewa ~d', [Balance, Rent]), nl,
    (
        isAbleToPayRent(Player) -> (
            payRent(Tile, Player),
            write('Hore, sewa sudah bisa dibayar!'), nl,
            resolveBankruptcy(Player),
            !
        ) ; (
            write('Mora masih kurang. Silakan pilih properti lain untuk dijual'), nl, fail)
    ).