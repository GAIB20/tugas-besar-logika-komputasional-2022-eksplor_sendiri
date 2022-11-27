player(v).
player(w).

:- dynamic(location/2).
:- dynamic(cardInventory/2).
:- dynamic(balance/2).

cardlist([tax, prize, getout, gotojail]).

location(v, go).
location(w, go).

balance(v, 20000).
balance(w, 20000).

cardInventory(v, []).
cardInventory(w, []).


addBalance(Player, Amount) :-
  player(Player),
  balance(Player, X),
  NewX is X + Amount,
  retract(balance(Player, _)),
  asserta(balance(Player,NewX)).

subtractBalance(Player, Amount) :-
  player(Player),
  balance(Player, X),
  NewX is X - Amount,
  retract(balance(Player, _)),
  asserta(balance(Player,NewX)).

netWorth(Player, Net) :-
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
  Ans =:= 0,
  retract(cardInventory(Player, Inventory)),
  insertElmtLast(Inventory, Card, A),
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