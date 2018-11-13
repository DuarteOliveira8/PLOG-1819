/* add element to a list cell */
addToListCell(Value, 1, [L1 | L], [NewL1 | L]) :-
  NewL1 is L1+Value.

addToListCell(Value, X, [L1 | L], [L1 | NB]) :-
  X > 1,
  NewX is X-1,
  addToListCell(Value, NewX, L, NB).

addToMultListCell(Value, X, 1, [B1 | B], [NB | B]) :-
  addToListCell(Value, X, B1, NB).

addToMultListCell(Value, X, Y, [B1 | B], [B1 | NB]) :-
  Y > 1,
  NewY is Y-1,
  addToMultListCell(Value, X, NewY, B, NB).

/* Replace element in a list */
replaceList(Value, 1, [_L1 | L], [Value | L]).

replaceList(Value, X, [L1 | L], [L1 | NB]) :-
  X > 1,
  NewX is X-1,
  replaceList(Value, NewX, L, NB).

replaceMultList(Value, X, 1, [B1 | B], [NB | B]) :-
  replaceList(Value, X, B1, NB).

replaceMultList(Value, X, Y, [B1 | B], [B1 | NB]) :-
  Y > 1,
  NewY is Y-1,
  replaceMultList(Value, X, NewY, B, NB).

/* check if element exists in a list */
checkValueMultList(Value, X, Y, Board) :-
  nth1(Y, Board, SubList),
  nth1(X, SubList, Value).

/* Add all elements of list */
sumMultList(Sum, Sum, []).
sumMultList(Sum, Total, [B1 | B]) :-
  sumlist(B1, TotalList),
  NewSum is Sum+TotalList,
  sumMultList(NewSum, Total, B).

/* gets element in list TODO */

/* updates the game board TODO */
setBoard(Game, NewGame, NewBoard) :-
  replaceList(NewBoard, 1, Game, NewGame).

/* updates Yuki X coordinate */
setYukiX(Game, NewGame, YukiX) :-
  replaceList(YukiX, 2, Game, NewGame).

/* updates Yuki Y coordinate */
setYukiY(Game, NewGame, YukiY) :-
  replaceList(YukiY, 3, Game, NewGame).

/* updates Mina X coordinate */
setMinaX(Game, NewGame, MinaX) :-
  replaceList(MinaX, 4, Game, NewGame).

/* updates Mina Y coordinate */
setMinaY(Game, NewGame, MinaY) :-
  replaceList(MinaY, 5, Game, NewGame).

/* updates Player 1 points */
setP1P(Game, NewGame, P1P) :-
  replaceList(P1P, 6, Game, NewGame).

/* updates Player 2 points */
setP2P(Game, NewGame, P2P) :-
  replaceList(P2P, 7, Game, NewGame).
