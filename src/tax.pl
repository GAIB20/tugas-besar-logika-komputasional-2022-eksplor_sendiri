:- dynamic(taxPayer/1).

% Apakah player dalam kondisi wajib pajak
playerState(taxPayer). 

% Berapa pajak yang player harus bayar
taxAmount(Player, Amount) :-
    netWorth(Player, Net),
    Amount is (Net * 0.1).

% Apakah player bisa bayar pajak langsung
isAbleToPayTax(Player) :-
    taxAmount(Player, Amount),
    balance(Player, Cash),
    Cash >= Amount.

% Command untuk player bayar pajak
payTax(Player) :-
    playerState(taxPayer),
    taxAmount(Player, Amount),
    isAbleToPayTax(Player) -> (
        subtractBalance(Player, Amount),
        playerState(normal)
    ) ; (
        write('Balance kamu tidak cukup, jual salah satu dari propertimu untuk membayar'), nl,
        unresolvedBankruptcy(Player),
        repeat,
        write('Daftar propertimu:'), nl,
        tileInventory(Player, Inventory),
        displayAssets(Inventory, 1),
        write('Pilih nomor properti yang ingin dijual '),
        read(Nomor),
        sellTileByIndex(Nomor, Player),
        balance(Player, Balance),
        location(Player, Tile),
        format('Uangmu sekarang ~d dan besar pajak ~s', [Balance, Amount]), nl,
        (
            isAbleToPayTax(Player) -> (
                payTax(Tile, Player),
                write('Hore, sewa sudah bisa dibayar!'), nl,
                resolveBankruptcy(Player),
                !
            ) ;
            (write('Uang masih kurang. Silakan pilih properti lain untuk dijual'), nl, fail)
        )
    ).