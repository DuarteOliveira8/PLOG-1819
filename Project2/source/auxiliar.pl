/**
 * Add element to a list cell
 */
addToListCell(Value, 1, [L1 | L], [NewL1 | L]) :-
  NewL1 is L1+Value.

/**
 * Decrease X until arriving to needed X value
 */
addToListCell(Value, X, [L1 | L], [L1 | NB]) :-
  X > 1,
  NewX is X-1,
  addToListCell(Value, NewX, L, NB).

/**
 * Add element to multi dimensional list cell
 */
addToMultListCell(Value, X, 1, [B1 | B], [NB | B]) :-
  addToListCell(Value, X, B1, NB).

/**
 * Decrease Y until arriving to needed Y value
 */
addToMultListCell(Value, X, Y, [B1 | B], [B1 | NB]) :-
  Y > 1,
  NewY is Y-1,
  addToMultListCell(Value, X, NewY, B, NB).

/**
 * Replace element in a list
 */
replaceList(Value, 1, [_L1 | L], [Value | L]).

/**
 * Decrease X until arriving to needed X value
 */
replaceList(Value, X, [L1 | L], [L1 | NB]) :-
  X > 1,
  NewX is X-1,
  replaceList(Value, NewX, L, NB).

/**
 * Replace list element value in a multi dimensional list cell
 */
replaceMultList(Value, X, 1, [B1 | B], [NB | B]) :-
  replaceList(Value, X, B1, NB).

/**
 * Decrease Y until arriving to needed Y value
 */
replaceMultList(Value, X, Y, [B1 | B], [B1 | NB]) :-
  Y > 1,
  NewY is Y-1,
  replaceMultList(Value, X, NewY, B, NB).

/**
 * Check if element exists in a list
 */
checkValueList(Value, X, List) :-
  nth0(X, List, Value).

/**
 * Verifies if determined value is on determined position
 */
value(Value, X, Y, Board) :-
  nth0(Y, Board, SubList),
  nth0(X, SubList, Value).

/**
 * Add all elements of list
 */
sumMultList(Sum, Sum, []).
sumMultList(Sum, Total, [B1 | B]) :-
  sumlist(B1, TotalList),
  NewSum is Sum+TotalList,
  sumMultList(NewSum, Total, B).

/**
 * Removes player from the board
 */
removePlayerPosition(Player, X, Y, Board, NBoard) :-
  addToMultListCell(-Player, X, Y, Board, NBoard).

/**
 * Adds player to the board
 */
addPlayerPosition(Player, X, Y, Board, NBoard) :-
  addToMultListCell(Player, X, Y, Board, NBoard).

/**
 * Gets all indexes of element X from given list
 */
getIndexesOf(_X, _Index, [], []).

getIndexesOf(X, Index, [L1 | L], Indexes) :-
  L1 =\= X,
  NewIndex is Index+1,
  getIndexesOf(X, NewIndex, L, Indexes).

getIndexesOf(X, Index, [L1 | L], [I1 | I]) :-
  L1 == X,
  I1 is Index,
  NewIndex is Index+1,
  getIndexesOf(X, NewIndex, L, I).

/**
 * Restricts number to be prime.
 */
restrictPrime(Number) :-
  Number #= 2 #\/ Number #= 3 #\/ Number #= 5 #\/ Number #= 7.
