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
  write(BoardElem),
  getElement(ResultElem, I, J, Result),
  write(ResultElem),
  setRestriction(Board, LineSums, Result, BoardElem, ResultElem, I, J, N),
  NewI is I+1,
  setRestrictionsBoard(Board, LineSums, Result, NewI, J, N).

/**
 * Predicate to set restriction to a free space element.
 */
setRestriction(_Board, _LineSums, _Result, ' ', _ResultElem, _I, _J, _N).

/**
 * Predicate to set restriction to a star element.
 */
setRestriction(Board, LineSums, Result, 's', ResultElem, I, J, N) :-
  restrictPrime(ResultElem),
  isNotPrime(Result, I+1, J),
  isNotPrime(Result, I-1, J),
  isNotPrime(Result, I, J+1),
  isNotPrime(Result, I, J-1).

/**
 * Predicate to set restriction to a quad element.
 */
setRestriction(Board, LineSums, Result, 'q', ResultElem, I, J, N).

/**
 * Predicate to set restriction to a diamond element.
 */
setRestriction(Board, LineSums, Result, 'd', ResultElem, I, J, N).

/**
 * Predicate to set restriction to a triangle element.
 */
setRestriction(Board, LineSums, Result, 't', ResultElem, I, J, N).

/**
 * Predicate to set restriction to a circle element.
 */
setRestriction(Board, LineSums, Result, 'c', ResultElem, I, J, N).

/**
 * Predicate to set restriction to a knight (chess) element.
 */
setRestriction(Board, LineSums, Result, 'k', ResultElem, I, J, N).

/**
 * Predicate to set restriction to a heart element.
 */
setRestriction(Board, LineSums, Result, 'h', ResultElem, I, J, N).
