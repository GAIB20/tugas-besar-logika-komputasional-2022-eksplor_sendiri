:- dynamic(unresolvedBankruptcy/1).

declarePendingBankruptcy(Player) :- 
    retractall(unresolvedBankruptcy(_)),
    asserta(unresolvedBankruptcy(Player)).

resolveBankruptcy(Player) :- 
    retractall(unresolvedBankruptcy(Player)).

cashableWorth(Player, Cash) :- % jumlah cash sekarang + cash hasil penjualan semua asset (80%*totalAsset)
  balance(Player, Balance),
  totalAsset(Player, Asset),
  FCash is Balance + 0.8*Asset,
  Cash is round(FCash).

rentAmount(Tile, Owner, Rent) :-
    tileAsset(Tile, PropertyLevel, Owner),
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

payRent(Tile, Payer) :- 
    (tileAsset(Tile, _, Owner),
    Owner \== Payer,
    Owner \== none) -> (
    format('Anda menginjak lahan ~w milik ~w', [Tile, Owner]), nl,
    isAbleToPayRent(Tile, Payer) -> (
        rentAmount(Tile, Owner, Rent),
        addBalance(Owner, Rent),
        subtractBalance(Payer, Rent),
        format('~w telah membayar sewa sebesar ~d kepada ~w', [Payer, Rent, Owner]), nl
    ) ; (
        rentAmount(Tile, _, Rent),
        cashableWorth(Payer, Worth),
        balance(Payer, Balance),
        ((Worth >= Rent) -> (
            write('Wah, moramu kurang! Apakah kamu ingin tetap melanjutkan permainan?'), nl,
            format('Uangmu ~d dan biaya sewa ~d', [Balance, Rent]), nl,
            declarePendingBankruptcy(Payer)
        ) ; (
            write('Wah, moramu kurang!'), nl,
            format('Jumlah mora dari dompet dan penjualan aset ~d dan biaya sewa ~d', [Worth, Rent]), nl,
            write('Sayang sekali, moramu sudah tidak cukup.'), nl,
            setGameOver(Payer)
        ))
    )); doNothing.

writeAssetList(Tile, No) :- 
    tileAsset(Tile, PropertyLevel, _),
    assetValue(Tile, Value),
    SellValue is 0.8*Value,
    SellVal is round(SellValue),
    format('~d. ~w bangunan ~d : ~d', [No, Tile, PropertyLevel, SellVal]), nl.

displayAssets([], _) :- !.

displayAssets([H|T], No) :- 
    writeAssetList(H, No),
    Next is No + 1,
    displayAssets(T, Next).

tidak :-
    unresolvedBankruptcy(Player),
    resolveBankruptcy(Player),
    setGameOver(Player),
    write('Salah satu pemain telah menyatakan bangkrut, sehingga permainan selesai'), nl.

lanjut :-
    unresolvedBankruptcy(Player),
    repeat,
    write('Daftar propertimu:'), nl,
    tileInventory(Player, Inventory),
    displayAssets(Inventory, 0),
    sellTileByIndex(No, Player),
    balance(Player, Balance),
    location(Player, Tile),
    rentAmount(Tile, _, Rent),
    format('Moramu sekarang ~d dan biaya sewa ~d', [Balance, Rent]), nl,
    write('Masukkan nomor aset yang ingin dijual: '),
    read(No),
    (
        isAbleToPayRent(Tile, Player) -> (
            payRent(Tile, Player),
            write('Hore, sewa sudah bisa dibayar!'), nl,
            resolveBankruptcy(Player),
            !
        ) ; (
            write('Mora masih kurang. Silakan pilih properti lain untuk dijual'), nl, fail)
    ).