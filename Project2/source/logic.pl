/**
 * Predicates to set the domain to the result board.
 */
setDomain([]).

setDomain([R1 | R]) :-
  domain(R1, 0, 9),
  setDomain(R), !.

/**
 * Calculates the line sumatories.
 */
calcSums([], []).

calcSums([R1 | R], [LS1 | LS]) :-
  sum(R1, #=, LS1),
  calcSums(R, LS), !.

/**
 * Predicates to set all restrictions to the result board.
 */
setRestrictionsBoard(_Board, _LineSums, _Result, _I, N, N).

setRestrictionsBoard(Board, LineSums, Result, N, J, N) :-
  NewJ is J+1,
  setRestrictionsBoard(Board, LineSums, Result, 0, NewJ, N), !. % ! ??

setRestrictionsBoard(Board, LineSums, Result, I, J, N) :-
  getElement(BoardElem, I, J, Board),
  getElement(ResultElem, I, J, Result),
  setRestriction(Board, LineSums, Result, BoardElem, ResultElem, I, J, N),
  NewI is I+1,
  setRestrictionsBoard(Board, LineSums, Result, NewI, J, N), !. % ! ??

/**
 * Predicate to set restriction to a star element. Must be prime, at least 2, have no
 * neighbors orthogonally that are prime or are 1.
 */
setRestriction(_Board, _LineSums, Result, 's', ResultElem, I, J, _N) :-
  restrictPrime(ResultElem),
  getOrthogonals(_, Result, I, J, _, ResultElems),
  restrictNotPrimeOrOne(ResultElems).

/**
 * Predicate to set restriction to a quad element. Must be either 0 or 5 but not have the
 * same digit as a neighbor unless the neighbor is a diamond.
 */
setRestriction(Board, _LineSums, Result, 'q', ResultElem, I, J, _N) :-
  ResultElem #= 0 #\/ ResultElem #= 5,
  getOrthogonals(Board, Result, I, J, BoardElems, ResultElems),
  restrictDifferentExceptDiamond(ResultElems, BoardElems, ResultElem).

/**
 * Predicate to set restriction to a diamond element. Is odd and is the sum of all digits left
 * of it in the row.
 */
setRestriction(_Board, _LineSums, Result, 'd', ResultElem, I, J, _N) :-
  restrictOdd(ResultElem),
  LeftI is I-1,
  getLeftElements(Result, LeftI, J, [], Left),
  sum(Left, #=, ResultElem).

/**
 * Predicate to set restriction to a triangle element. Located directly below an even digit
 * & less than it (but not 0).
 */
setRestriction(_Board, _LineSums, Result, 't', ResultElem, I, J, _N) :-
  ResultElem #\= 0,
  J > 0,
  TopJ is J-1,
  getElement(TopElem, I, TopJ, Result),
  restrictEven(TopElem),
  TopElem #> ResultElem.

/**
 * Predicate to set restriction to a circle element. Not a multiple of 3.
 */
setRestriction(_Board, _LineSums, _Result, 'c', ResultElem, _I, _J, _N) :-
  restrictNotMultiple3(ResultElem).

/**
 * Predicate to set restriction to a knight (chess) element. Chess knight - tells amount of even digits
 * (incl. 0) in its attack range.
 */
setRestriction(_Board, _LineSums, Result, 'k', ResultElem, I, J, _N) :-
  getKnightRange(Result, I, J, ResultElems),
  getElementsParity(ResultElems, [], Parity),
  sum(Parity, #=, ResultElem).

/**
 * Predicate to set restriction to a heart element. Neighboring hearts must add together
 * to a sum of 10.
 */
setRestriction(Board, _LineSums, Result, 'h', ResultElem, I, J, _N) :-
  getOrthogonals(Board, Result, I, J, BoardElems, ResultElems),
  getNeighboringHearts(ResultElems, BoardElems, [], NeighboringHearts),
  append(NeighboringHearts, [ResultElem], Hearts),
  sum(Hearts, #=, 10).

/**
 * Exception. No restrictions.
 */
setRestriction(_Board, _LineSums, _Result, ' ', _ResultElem, _I, _J, _N).

/**
 * Predicate to set restrictions to all circles. All copies are
 * the same digit within the specific grid.
 */
setCircleRestrictions(Board, Result) :-
  getAllCirclesBoard(Board, Result, [], Circles),
  applyCirclesEqual(Circles).
