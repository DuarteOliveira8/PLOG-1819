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

/* Get player position */
getYukiPosition(YukiX, YukiY, Board) :-
  checkValueMultList(1, YukiX, YukiY, Board).

getMinaPosition(MinaX, MinaY, Board) :-
  checkValueMultList(2, MinaX, MinaY, Board).

getMinaPosition(MinaX, MinaY, Board) :-
  checkValueMultList(5, MinaX, MinaY, Board).
