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
checkValueList(Value, 1, [L1 | _L]) :-
  Value is L1.

checkValueList(Value, X, [_L1 | L]) :-
  X > 1,
  NewX is X-1,
  checkValueList(Value, NewX, L).

checkValueMultList(Value, X, 1, [B1 | _B]) :-
  checkValueList(Value, X, B1).

checkValueMultList(Value, X, Y, [_B1 | B]) :-
  Y > 1,
  NewY is Y-1,
  checkValueMultList(Value, X, NewY, B).
