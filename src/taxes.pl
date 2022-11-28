% Berapa pajak yang player harus bayar
taxAmount(Player, Amount) :-
    netWorth(Player, Net),
    SubAmount is (Net * 0.05),
    Amount is round(SubAmount).

% Apakah player bisa bayar pajak langsung
isAbleToPayTax(Player) :-
    taxAmount(Player, Amount),
    balance(Player, Cash),
    Cash >= Amount.

% Command untuk player bayar pajak
payTax(Player) :-
    taxAmount(Player, Amount),
    format('Kamu datang ke rumah Yanfei untuk membayar pajak sebesar 5 persen dari kekayaanmu, yaitu sebesar ~d mora.', [Amount]), nl,
    (
    isAbleToPayTax(Player) -> (
        subtractBalance(Player, Amount)
    ) ; (
        write('Mora kamu tidak cukup, tapi kamu tetap semangat untuk membayar pajak demi kelangsungan kota Liyue.\nYanfei menawarkan untuk membeli propertimu agar kamu bisa membayar pajak.'), nl,
        repeat,
        write('Daftar propertimu yang bisa dijual ke yanfei'), nl,
        tileInventory(Player, Inventory),
        displayAssets(Inventory, 1),
        write('Pilih nomor properti yang ingin dijual '),
        read(Nomor),
        Index is Nomor - 1, 
        sellTileByIndex(Index, Player),
        balance(Player, Balance),
        format('Moramu sekarang ~d dan besar pajak ~d', [Balance, Amount]), nl,
        (
            isAbleToPayTax(Player) -> (
                subtractBalance(Player, Amount),
                write('Hore, sewa sudah bisa dibayar!'), nl,
                !
            ) ; (
                write('Moramu masih kurang. Silakan pilih properti lain untuk dijual'), nl, fail
            )
        )
    )
    ),
    write('Yanfei sudah menerima moramu dengan senang hati, sisa uangmu adalah:'), nl,
    mora.