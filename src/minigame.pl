:- dynamic(guessSuccess/1).
:- dynamic(isMinigame/1).

isMinigame(0).
guessSuccess(0).

startMinigame :- 
  retract(isMinigame(_)),
  asserta(isMinigame(1)),
  write('Kamu sekarang memasuki minigame! Lakukan command head atau tail untuk menebak!'), nl.

getMinigamePrize(X, Prize) :-
  getElmt([0, 2000, 4000, 8000], X, Prize).

endMinigame :-
  isMinigame(1),
  retract(guessSuccess(X)),
  asserta(guessSuccess(0)),
  getMinigamePrize(X, Prize),
  write('Minigame berakhir!'), nl,
  retract(isMinigame(_)),
  asserta(isMinigame(0)),
  (Prize =:= 0 -> (
    write('Selamat! Kamu tidak mendapatkan mora sepeserpun!'), nl
  ) ; ( 
    format('Selamat! Kamu mendapatkan ~d mora!', [Prize]), nl,
    turn(Player, 1), !,
    addBalance(Player, Prize),
    balance(Player, Balance),
    format('Sekarang kamu memiliki ~d mora!', [Balance]), nl
  )). 

stopGuess :- 
  isMinigame(1),
  guessSuccess(X),
  X > 0,
  endMinigame.

head :- guessCoin(0).
tail :- guessCoin(1).
guessCoin(Guess) :-
  isMinigame(1),
  randomize,
  get_seed(R),
  C is R mod 2,
  (C =:= Guess -> (
    retract(guessSuccess(X)),
    Y is X + 1,
    format('Kamu berhasil berhasil menebak dengan benar sebanyak ~d kali!', [Y]), nl, nl,
    asserta(guessSuccess(Y)),
    (Y =:= 3 -> (
      endMinigame 
    ) ; (
      write('head atau tail untuk menebak kembali dan mendapatkan hadiah 2 kali lipat.\nstopGuess untuk berhenti minigame dan mengambil hadiah.\nPerlu diingat bahwa apabila gagal menebak, maka hadiah akan hangus!'), nl, nl,
      getMinigamePrize(Y, Prize),
      format('Jika kamu stopGuess sekarang, kamu akan mendapatkan ~d mora.', [Prize]), nl
    ))) ; (
    write('Kamu gagal menebak! '), 
    retract(guessSuccess(X)),
    (X > 0 -> (
      write('Yah, hadiah kamu hangus!'), nl
    ) ; (
      doNothing
    )),
    asserta(guessSuccess(0)),
    endMinigame
  )),
  !.
  


