/**
 * Predicates to set the domain to the result board.
 */
setDomain([]).

setDomain([R1 | R]) :-
  domain(R1, 0, 9),
  setDomain(R).

/**
 * Predicates to set all restrictions to the result board.
 */
setRestrictionsBoard(_Board, _LineSums, _Result, _I, N, N).

setRestrictionsBoard(Board, LineSums, Result, N, J, N) :-
  NewJ is J+1,
  setRestrictionsBoard(Board, LineSums, Result, 0, NewJ, N).

setRestrictionsBoard(Board, LineSums, Result, I, J, N) :-
  getElement(BoardElem, I, J, Board),
  getElement(ResultElem, I, J, Result),
  setRestriction(Board, LineSums, Result, BoardElem, ResultElem, I, J, N),
  NewI is I+1,
  setRestrictionsBoard(Board, LineSums, Result, NewI, J, N).

/**
 * Predicate to set restriction to a free space element. No restrictions.
 */
setRestriction(_Board, _LineSums, _Result, ' ', _ResultElem, _I, _J, _N).

/**
 * Predicate to set restriction to a star element. Must be prime, at least 2, have no
 * neighbors orthogonally that are prime or are 1.
 */
setRestriction(_Board, _LineSums, Result, 's', ResultElem, I, J, _N) :-
  restrictPrime(ResultElem),
  LeftI is I-1,
  RightI is I+1,
  TopJ is J-1,
  BotJ is J+1,
  getElement(LeftElem, LeftI, J, Result),
  getElement(RightElem, RightI, J, Result),
  getElement(TopElem, I, TopJ, Result),
  getElement(DownElem, I, BotJ, Result),
  restrictNotPrimeOrOne(LeftElem),
  restrictNotPrimeOrOne(RightElem),
  restrictNotPrimeOrOne(TopElem),
  restrictNotPrimeOrOne(DownElem).

/**
 * Predicate to set restriction to a quad element. Must be either 0 or 5 but not have the
 * same digit as a neighbor unless the neighbor is a diamond.
 */
setRestriction(_Board, _LineSums, _Result, 'q', ResultElem, _I, _J, _N) :-
  ResultElem #= 0 #\/ ResultElem #= 5.

/**
 * Predicate to set restriction to a diamond element. Is odd and is the sum of all digits left
 * of it in the row.
 */
setRestriction(_Board, _LineSums, _Result, 'd', _ResultElem, _I, _J, _N).

/**
 * Predicate to set restriction to a triangle element. Located directly below an even digit
 * & less than it (but not 0).
 */
setRestriction(_Board, _LineSums, _Result, 't', _ResultElem, _I, _J, _N).

/**
 * Predicate to set restriction to a circle element. Not a multiple of 3, and all copies are
 * the same digit within the specific grid.
 */
setRestriction(_Board, _LineSums, _Result, 'c', _ResultElem, _I, _J, _N).

/**
 * Predicate to set restriction to a knight (chess) element. Chess knight - tells amount of even digits
 * (incl. 0) in its attack range.
 */
setRestriction(_Board, _LineSums, _Result, 'k', _ResultElem, _I, _J, _N).

/**
 * Predicate to set restriction to a heart element. Neighboring hearts must add together
 * to a sum of 10.
 */
setRestriction(_Board, _LineSums, _Result, 'h', _ResultElem, _I, _J, _N).
