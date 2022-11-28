player(v).
player(w).

:- dynamic(location/2).
:- dynamic(cardInventory/2).
:- dynamic(balance/2).

cardlist([tax, prize, zonk, getout, gotojail, backthreestep, threestep, birthday, zonkyanfei, meteor, pass, paimon, childe, brokenteleport, teleportcard, sedekahcard, bribezhonglicard, minigamecard]).

location(v, go).
location(w, go).

balance(v, 20000).
balance(w, 20000).

cardInventory(v, []).
cardInventory(w, []).


addBalance(Player, Amount) :-
  player(Player),
  (
    (float(Amount)) -> (
      Rounded is round(Amount)
    ) ; (
      Rounded is Amount
    )
  ),
  balance(Player, X),
  NewX is X + Rounded,
  retract(balance(Player, _)),
  asserta(balance(Player,NewX)).

subtractBalance(Player, Amount) :-
  player(Player),
  (
    (float(Amount)) -> (
      Rounded is round(Amount)
    ) ; (
      Rounded is Amount
    )
  ),
  balance(Player, X),
  NewX is X - Rounded,
  retract(balance(Player, _)),
  asserta(balance(Player,NewX)).

netWorth(Player, Net) :-
  isPlaying(1),
  player(Player),
  balance(Player, Balance),
  totalAsset(Player, Asset), % ada di aset.pl
  Net is Balance + Asset, !.

movePlayerTo(Player, Location) :- retract(location(Player, _)), asserta(location(Player, Location)).

movePlayerStep(Player, Step) :- 
  retract(location(Player, Prev)), 
  board(Board), boardLength(BoardLen), 
  indexOf(Board, Prev, IPrev), INext is (IPrev + Step) mod BoardLen,
  getElmt(Board, INext, Next),
  asserta(location(Player, Next)).

insertToInventory(Player, Card) :-
  isCardValid(Card, Ans),
  Ans =:= 1,
  retract(cardInventory(Player, Inventory)),
  insertElmtLast(Inventory, Card, A),
  asserta(cardInventory(Player, A)), !.

deleteFromInventory(Player, Card) :-
  cardInventory(Player, Inv),
  isCardValid(Card, AnsOne),
  AnsOne =:= 1, !,
  isElmt(Inv, Card, AnsTwo),
  AnsTwo =:= 1, !,
  retract(cardInventory(Player, Inventory)),
  deleteElmt(Inventory, Card, A),
  asserta(cardInventory(Player, A)).

showInventory(Player) :-
  cardInventory(Player, Inventory),
  format('~nInventory: ~w~n', [Inventory]).

isCardValid(Card, Answer) :-
  cardlist(List),
  isElmt(List, Card, Answer).

moveToNearestTax(P) :-
  board(Board),
  indexOf(Board, tx1, Itx1),
  indexOf(Board, tx2, _),
  location(P, Loc),
  indexOf(Board, Loc, IdxLoc),
  IdxLoc < Itx1,
  movePlayerTo(P, tx1), !.

moveToNearestTax(P) :-
  board(Board),
  indexOf(Board, tx1, Itx1),
  indexOf(Board, tx2, Itx2),
  location(P, Loc),
  indexOf(Board, Loc, IdxLoc),
  IdxLoc > Itx1,
  IdxLoc < Itx2,
  movePlayerTo(P, tx2), !.

moveToNearestTax(P) :-
  board(Board),
  indexOf(Board, tx1, _),
  indexOf(Board, tx2, Itx2),
  location(P, Loc),
  indexOf(Board, Loc, IdxLoc),
  IdxLoc > Itx2,
  movePlayerTo(P, tx1), !.

checkPlayerDetail(Player) :-
  location(Player, Location),
  balance(Player, Balance),
  totalAsset(Player, Asset),
  netWorth(Player, Worth),
  format('Informasi Player ~w', [Player]), nl, nl,
  format('Lokasi \t\t\t: ~w', [Location]), nl,
  format('Total mora\t\t: ~d', [Balance]), nl,
  format('Total nilai properti\t: ~d', [Asset]), nl,
  format('Total asset\t\t: ~d', [Worth]), nl, nl,
  write('Daftar Kepemilikan Properti: '), nl,
  tileInventory(Player, Inventory),
  displayAssets(Inventory, 1), nl,
  write('Daftar Kepemilikan Card: '), nl,
  showInventory(Player).