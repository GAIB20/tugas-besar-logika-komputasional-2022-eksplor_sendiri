board([go, a1, a2, a3, cc1, b1, b2, b3, jl, c1, c2, c3, tx1, d1, d2, d3, fp, e1, e2, e3, cc2, f1, f2, f3, wt, g1, g2, g3, tx2, cc3, h1, h2]).
boardLength(32).
boardAsset([a1, a2, a3, b1, b2, b3, c1, c2, c3, d1, d2, d3, e1, e2, e3, f1, f2, f3, g1, g2, g3, h1, h2]).
boardAssetLength(23).
isProperty(Location) :- boardAsset(BoardAsset), isElmt(BoardAsset, Location, 1).

% go
showLocNameNDesc(go) :- write('\nNama Lokasi\t\t: Starfell Lake\n'),
  write('Deskripsi Lokasi\t: Tempat awal mula perjalanan\n\n').

% jl
showLocNameNDesc(jl) :- write('\nNama Lokasi\t\t: Confinement Room\n'),
  write('Deskripsi Lokasi\t: Tempat renungan\n\n').

% cc1
showLocNameNDesc(cc1) :- write('\nNama Lokasi\t\t: Anemo Archon Statue\n'),
  write('Deskripsi Lokasi\t: Raihlah kesempatan untuk mendapatkan hadiah\n\n').

% tx1
showLocNameNDesc(tx1) :- write('\nNama Lokasi\t\t: Northland Bank\n'),
  write('Deskripsi Lokasi\t: Fatui menghadang! Anda diharuskan untuk membayar pajak\n\n').

% fp
showLocNameNDesc(fp) :- write('\nNama Lokasi\t\t: Void Sphere Portal\n'),
  write('Deskripsi Lokasi\t: Anda tidak akan bisa berdiam diri di sini dan langsung diteleportasikan ke tempat lain\n\n').

% cc2
showLocNameNDesc(cc2) :- write('\nNama Lokasi\t\t: Golden House\n'),
  write('Deskripsi Lokasi\t: Carilah harta tersembunyi. Apa yang akan anda temukan di sana?\n\n').

% wt
showLocNameNDesc(wt) :- write('\nNama Lokasi\t\t: Teleport Waypoint\n'),
  write('Deskripsi Lokasi\t: Artifak yang bisa memindahkan anda ke tempat mana saja\n\n').

% tx2
showLocNameNDesc(tx2) :- write('\nNama Lokasi\t\t: Sabzeruz Festival\n'),
  write('Deskripsi Lokasi\t: Anda terjebak dengan tarian Nilou! Sebagian uang anda habis untuk mensponsori festival\n\n').

% cc3
showLocNameNDesc(cc3) :- write('\nNama Lokasi\t\t: Akademiya\n'),
  write('Deskripsi Lokasi\t: Anda berkunjung ke Akademiya. Harta apa yang akan anda temukan di sana?\n\n').

/* a1 */
showLocNameNDesc(a1) :- write('\nNama Lokasi\t\t: Mondstadt\n'),
  write('Deskripsi Lokasi\t: Pusat wilayah Mondstadt\n\n').

/* a2 */
showLocNameNDesc(a2) :- write('\nNama Lokasi\t\t: Dawn Winery\n'),
  write('Deskripsi Lokasi\t: Wilayah pembuat wine\n\n').

/* a3 */
showLocNameNDesc(a3) :- write('\nNama Lokasi\t\t: Springvale\n'),
  write('Deskripsi Lokasi\t: Desa pemburu\n\n').

/* b1 */
showLocNameNDesc(b1) :- write('\nNama Lokasi\t\t: Stormterror s Lair\n'),
  write('Deskripsi Lokasi\t: Sarang naga\n\n').

/* b2 */
showLocNameNDesc(b2) :- write('\nNama Lokasi\t\t: Wolvendom\n'),
  write('Deskripsi Lokasi\t: Makam arwah serigala\n\n').

/* b3 */
showLocNameNDesc(b3) :- write('\nNama Lokasi\t\t: Dragonspine\n'),
  write('Deskripsi Lokasi\t: Wilayah bersalju\n\n').

/* c1 */
showLocNameNDesc(c1) :- write('\nNama Lokasi\t\t: Qingce Village\n'),
  write('Deskripsi Lokasi\t: Tempat pensiun orang tua\n\n').

/* c2 */
showLocNameNDesc(c2) :- write('\nNama Lokasi\t\t: Wangshu Inn\n'),
  write('Deskripsi Lokasi\t: Tempat pemberhentian pedagang\n\n').

/* c3 */
showLocNameNDesc(c3) :- write('\nNama Lokasi\t\t: Liyue Harbor\n'),
  write('Deskripsi Lokasi\t: Pusat wilayah Liyue\n\n').

/* d1 */
showLocNameNDesc(d1) :- write('\nNama Lokasi\t\t: Jade Chamber\n'),
  write('Deskripsi Lokasi\t: Istana Ningguang\n\n').

/* d2 */
showLocNameNDesc(d2) :- write('\nNama Lokasi\t\t: The Chasm\n'),
  write('Deskripsi Lokasi\t: Wilayah penambangan\n\n').

/* d3 */
showLocNameNDesc(d3) :- write('\nNama Lokasi\t\t: Qingyun Peak\n'),
  write('Deskripsi Lokasi\t: Rumahnya para adeptus\n\n').

/* e1 */
showLocNameNDesc(e1) :- write('\nNama Lokasi\t\t: Inazuma City\n'),
  write('Deskripsi Lokasi\t: Pusat wilayah Inazuma\n\n').

/* e2 */
showLocNameNDesc(e2) :- write('\nNama Lokasi\t\t: Ritou\n'),
  write('Deskripsi Lokasi\t: Pelabuhan Inazuma\n\n').

/* e3 */
showLocNameNDesc(e3) :- write('\nNama Lokasi\t\t: Kamisato Estate\n'),
  write('Deskripsi Lokasi\t: Perumahan Kamisato\n\n').

/* f1 */
showLocNameNDesc(f1) :- write('\nNama Lokasi\t\t: Grand Narukami Shrine\n'),
  write('Deskripsi Lokasi\t: Kuil penjaga pohon sakura keramat\n\n').

/* f2 */
showLocNameNDesc(f2) :- write('\nNama Lokasi\t\t: Kujou Encampment\n'),
  write('Deskripsi Lokasi\t: Benteng Kujou\n\n').

/* f3 */
showLocNameNDesc(f3) :- write('\nNama Lokasi\t\t: Sangonomiya Shrine\n'),
  write('Deskripsi Lokasi\t: Markas tentara perlawanan\n\n').

/* g1 */
showLocNameNDesc(g1) :- write('\nNama Lokasi\t\t: Gandharva Ville\n'),
  write('Deskripsi Lokasi\t: Desa penjaga hutan\n\n').

/* g2 */
showLocNameNDesc(g2) :- write('\nNama Lokasi\t\t: Sumeru City\n'),
  write('Deskripsi Lokasi\t: Pusat wilayah Sumeru\n\n').

/* g3 */
showLocNameNDesc(g3) :- write('\nNama Lokasi\t\t: Port Osmos\n'),
  write('Deskripsi Lokasi\t: Pelabuhan pusat Sumeru\n\n').

/* h1 */
showLocNameNDesc(h1) :- write('\nNama Lokasi\t\t: Caravan Ribat\n'),
  write('Deskripsi Lokasi\t: Pembatas sumeru dengan wilayah padang pasir\n\n').

/* h2 */
showLocNameNDesc(h2) :- write('\nNama Lokasi\t\t: Aaru Village\n'),
  write('Deskripsi Lokasi\t: Wilayah pengikut Raja Scarlet dan tempat pembuangan pelajar Sumeru\n\n').

propertyPrices(a1, Prices) :- Prices = [400, 1000, 1500, 2000, 3000].
propertyPrices(a2, Prices) :- Prices = [400, 1000, 1500, 2000, 3000].
propertyPrices(a3, Prices) :- Prices = [400, 1000, 1500, 2000, 3000].
propertyPrices(b1, Prices) :- Prices = [600, 1200, 2000, 2500, 4000].
propertyPrices(b2, Prices) :- Prices = [600, 1200, 2000, 2500, 4000].
propertyPrices(b3, Prices) :- Prices = [600, 1200, 2000, 2500, 4000].
propertyPrices(c1, Prices) :- Prices = [800, 1500, 2500, 3000, 5000].
propertyPrices(c2, Prices) :- Prices = [800, 1500, 2500, 3000, 5000].
propertyPrices(c3, Prices) :- Prices = [800, 1500, 2500, 3000, 5000].
propertyPrices(d1, Prices) :- Prices = [1000, 2000, 3000, 4000, 6000].
propertyPrices(d2, Prices) :- Prices = [1000, 2000, 3000, 4000, 6000].
propertyPrices(d3, Prices) :- Prices = [1000, 2000, 3000, 4000, 6000].
propertyPrices(e1, Prices) :- Prices = [1500, 2500, 3500, 5000, 7000].
propertyPrices(e2, Prices) :- Prices = [1500, 2500, 3500, 5000, 7000].
propertyPrices(e3, Prices) :- Prices = [1500, 2500, 3500, 5000, 7000].
propertyPrices(f1, Prices) :- Prices = [2000, 3000, 4000, 6000, 8000].
propertyPrices(f2, Prices) :- Prices = [2000, 3000, 4000, 6000, 8000].
propertyPrices(f3, Prices) :- Prices = [2000, 3000, 4000, 6000, 8000].
propertyPrices(g1, Prices) :- Prices = [2500, 3500, 5000, 7000, 9000].
propertyPrices(g2, Prices) :- Prices = [2500, 3500, 5000, 7000, 9000].
propertyPrices(g3, Prices) :- Prices = [2500, 3500, 5000, 7000, 9000].
propertyPrices(h1, Prices) :- Prices = [2500, 4000, 6000, 8000, 10000].
propertyPrices(h2, Prices) :- Prices = [2500, 4000, 6000, 8000, 10000].

propertyRents(a1, Prices) :- Prices = [70, 150, 350, 600, 1000].
propertyRents(a2, Prices) :- Prices = [70, 150, 350, 600, 1000].
propertyRents(a3, Prices) :- Prices = [70, 150, 350, 600, 1000].
propertyRents(b1, Prices) :- Prices = [80, 200, 400, 700, 1200].
propertyRents(b2, Prices) :- Prices = [80, 200, 400, 700, 1200].
propertyRents(b3, Prices) :- Prices = [80, 200, 400, 700, 1200].
propertyRents(c1, Prices) :- Prices = [90, 200, 450, 750, 1400].
propertyRents(c2, Prices) :- Prices = [90, 200, 450, 750, 1400].
propertyRents(c3, Prices) :- Prices = [90, 200, 450, 750, 1400].
propertyRents(d1, Prices) :- Prices = [100, 350, 500, 850, 1600].
propertyRents(d2, Prices) :- Prices = [100, 350, 500, 850, 1600].
propertyRents(d3, Prices) :- Prices = [100, 350, 500, 850, 1600].
propertyRents(e1, Prices) :- Prices = [200, 400, 600, 1000, 1800].
propertyRents(e2, Prices) :- Prices = [200, 400, 600, 1000, 1800].
propertyRents(e3, Prices) :- Prices = [200, 400, 600, 1000, 1800].
propertyRents(f1, Prices) :- Prices = [250, 500, 700, 1200, 2000].
propertyRents(f2, Prices) :- Prices = [250, 500, 700, 1200, 2000].
propertyRents(f3, Prices) :- Prices = [250, 500, 700, 1200, 2000].
propertyRents(g1, Prices) :- Prices = [300, 600, 800, 1400, 2500].
propertyRents(g2, Prices) :- Prices = [300, 600, 800, 1400, 2500].
propertyRents(g3, Prices) :- Prices = [300, 600, 800, 1400, 2500].
propertyRents(h1, Prices) :- Prices = [400, 750, 1000, 1500, 3000].
propertyRents(h2, Prices) :- Prices = [400, 750, 1000, 1500, 3000].

/* Get property and rent price based on location and property */
propertyPrice(Location, Property, Price) :- propertyPrices(Location, Prices), getElmt(Prices, Property, Price). 
propertyRent(Location, Property, Price) :- propertyRents(Location, Prices), getElmt(Prices, Property, Price). 


/* Get acquisition price based on location and property */
acquisitionPrice(Location, Property, Price) :- 
  Property = 4 -> 
    Price is -1 ; 
    propertyPrices(Location, Prices), sumUntil(Prices, Property, Sum), Price is Sum * 2.

doNothing.

showPropertyStatus(Location) :- 
  isProperty(Location) ->
  tileAsset(Location, PropStat, Owner),
  write('Kepemilikan\t\t: '),
  (PropStat == -2 -> 
    write('Tidak ada') ; 
    format('Player ~w', [Owner]), nl,
    propertyRent(Location, PropStat, RentCost),
    format('Biaya Sewa Saat Ini\t: ~d', [RentCost]), nl, 
    acquisitionPrice(Location, PropStat, AcCost),
    (AcCost \= -1 -> 
      format('Biaya Akuisisi\t\t: ~d', [AcCost]) ; 
      doNothing
    ), nl,
    write('Tingkatan Properti\t: '),
    assetStatusWriter(PropStat)
  ) ; format('\n~w bukan merupakan properti yang valid! Silahkan masukkan properti yang tepat.\n', [Location]), fail.

checkLocationDetail(Location) :- 
  isPlaying(1),
  showLocNameNDesc(Location) -> 
  showPropertyStatus(Location) ; format('\n~w bukan merupakan lokasi yang valid! Silahkan masukkan lokasi yang tepat.\n', [Location]), fail.

checkPropertyDetail(Location) :-
  isPlaying(1), 
  isProperty(Location) -> 
  showLocNameNDesc(Location), 
  propertyPrices(Location, [PTanah, PBangunan1, PBangunan2, PBangunan3, PLandmark]),
  format('Harga Tanah\t\t: ~d', [PTanah]), nl,
  format('Harga Bangunan 1\t: ~d', [PBangunan1]), nl,
  format('Harga Bangunan 2\t: ~d', [PBangunan2]), nl,
  format('Harga Bangunan 3\t: ~d', [PBangunan3]), nl,
  format('Harga Landmark\t\t: ~d', [PLandmark]), nl, nl,
  propertyRents(Location, [RTanah, RBangunan1, RBangunan2, RBangunan3, RLandmark]),  
  format('Biaya Sewa Tanah\t: ~d', [RTanah]), nl,
  format('Biaya Sewa Bangunan 1\t: ~d', [RBangunan1]), nl,
  format('Biaya Sewa Bangunan 2\t: ~d', [RBangunan2]), nl,
  format('Biaya Sewa Bangunan 3\t: ~d', [RBangunan3]), nl,
  format('Biaya Sewa Landmark\t: ~d', [RLandmark])
  ; format('\n~w bukan merupakan properti yang valid! Silahkan masukkan properti yang tepat.\n', [Location]), fail.


writeLocationStatus(Location) :- 
  write('  '), 
  tileAsset(Location, PropStat, Player),
  ((PropStat \== -2) -> 
  (write(Player), 
    (PropStat = -1 -> 
      write('H') ; 
      write(PropStat)
    )
  ) ; 
    write('  ')),
  write(' ').

writePlayerTerm(Location, Player) :-
  location(Player, Location) -> format(' ~w ', [Player]) ; write('   ').

writePlayerLocationLeft(Location) :- 
  writePlayerTerm(Location, v),
  writePlayerTerm(Location, w).

writePlayerLocationRight(Location) :-
  writePlayerTerm(Location, w),
  writePlayerTerm(Location, v).

writePlayerLocationUpBottom(Location, Player) :-
  write(' '), writePlayerTerm(Location, Player), write(' ').

map :- 
  isPlaying(1),
  write('           '), writePlayerLocationUpBottom(fp, v), writePlayerLocationUpBottom(e1, v), writePlayerLocationUpBottom(e2, v), 
  writePlayerLocationUpBottom(e3, v), writePlayerLocationUpBottom(cc2, v), writePlayerLocationUpBottom(f1, v), 
  writePlayerLocationUpBottom(f2, v), writePlayerLocationUpBottom(f3, v), writePlayerLocationUpBottom(wt, v), nl,
  write('           '), writePlayerLocationUpBottom(fp, w), writePlayerLocationUpBottom(e1, w), writePlayerLocationUpBottom(e2, w), 
  writePlayerLocationUpBottom(e3, w), writePlayerLocationUpBottom(cc2, w), writePlayerLocationUpBottom(f1, w), 
  writePlayerLocationUpBottom(f2, w), writePlayerLocationUpBottom(f3, w), writePlayerLocationUpBottom(wt, w), nl,
  write('                '), writeLocationStatus(e1), writeLocationStatus(e2), writeLocationStatus(e3),
  write('     '), writeLocationStatus(f1), writeLocationStatus(f2), writeLocationStatus(f3), nl,
  write('           ----------------------------------------------'), nl,
  write('           | FP | E1 | E2 | E3 | CC | F1 | F2 | F3 | WT |'), nl,
  write('           |----|----------------------------------|----|'), nl,
  writePlayerLocationLeft(d3), writeLocationStatus(d3), 
    write('| D3 |                                  | G1 |'), 
  writeLocationStatus(g1), writePlayerLocationRight(g1), nl,
  write('           |----|                                  |----|'), nl,
  writePlayerLocationLeft(d2), writeLocationStatus(d2), 
    write('| D2 |                                  | G2 |'), 
  writeLocationStatus(g2), writePlayerLocationRight(g2), nl,
  write('           |----|                                  |----|'), nl,
  writePlayerLocationLeft(d1), writeLocationStatus(d1), 
    write('| D1 |                                  | G3 |'), 
    writeLocationStatus(g3), writePlayerLocationRight(g3), nl,
  write('           |----|          E K S P L O R           |----|'), nl,
  writePlayerLocationLeft(tx1), 
    write('     | TX |                                  | TX |     '), 
  writePlayerLocationRight(tx2), nl,
  write('           |----|          S E N D I R I           |----|'), nl,
  writePlayerLocationLeft(c3), writeLocationStatus(c3), 
    write('| C3 |                                  | CC |     '), 
  writePlayerLocationRight(cc3), nl,
  write('           |----|                                  |----|'), nl,
  writePlayerLocationLeft(c2), writeLocationStatus(c2), 
    write('| C2 |                                  | H1 |'), 
  writeLocationStatus(h1), writePlayerLocationRight(h1), nl,
  write('           |----|                                  |----|'), nl,
  writePlayerLocationLeft(c1), writeLocationStatus(c1), 
    write('| C1 |                                  | H2 |'), 
  writeLocationStatus(h2), writePlayerLocationRight(h2), nl,
  write('           |----|----------------------------------|----|'), nl,
  write('           | JL | B3 | B2 | B1 | CC | A3 | A2 | A1 | GO |'), nl,
  write('           ----------------------------------------------'), nl,
  write('                '), writeLocationStatus(b3), writeLocationStatus(b2), writeLocationStatus(b1),
  write('     '), writeLocationStatus(a3), writeLocationStatus(a2), writeLocationStatus(a1), nl, 
  write('           '), writePlayerLocationUpBottom(jl, w), writePlayerLocationUpBottom(b3, w), writePlayerLocationUpBottom(b2, w), 
  writePlayerLocationUpBottom(b1, w), writePlayerLocationUpBottom(cc1, w), writePlayerLocationUpBottom(a3, w), 
  writePlayerLocationUpBottom(a2, w), writePlayerLocationUpBottom(a1, w), writePlayerLocationUpBottom(go, w), nl,
  write('           '), writePlayerLocationUpBottom(jl, v), writePlayerLocationUpBottom(b3, v), writePlayerLocationUpBottom(b2, v), 
  writePlayerLocationUpBottom(b1, v), writePlayerLocationUpBottom(cc1, v), writePlayerLocationUpBottom(a3, v), 
  writePlayerLocationUpBottom(a2, v), writePlayerLocationUpBottom(a1, v), writePlayerLocationUpBottom(go, v), nl.
