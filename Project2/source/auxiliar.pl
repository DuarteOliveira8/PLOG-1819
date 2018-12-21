/**
 * Gets an element on a determined position
 */
getElement(Value, X, Y, Board) :-
  nth0(Y, Board, SubList),
  nth0(X, SubList, Value).

/**
 * Predicates to append the board.
 */
appendBoard([], Final, Final).

appendBoard([R1 | R], Temp, Final) :-
  append(Temp, R1, NewTemp),
  appendBoard(R, NewTemp, Final).

/**
 * Restricts number to be prime.
 */
restrictPrime(Number) :-
  Number #= 2 #\/ Number #= 3 #\/ Number #= 5 #\/ Number #= 7.

/**
 * Restricts number not to be prime or 1.
 */
restrictNotPrimeOrOne(Number) :-
  Number #= 4 #\/ Number #= 6 #\/ Number #= 8 #\/ Number #= 9.
