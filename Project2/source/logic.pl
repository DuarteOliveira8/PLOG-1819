/**
 * Predicates to set the domain to the result board.
 */
setDomain([]).

setDomain([R1 | R]) :-
  domain(R1, 0, 9),
  setDomain(R).

/**
 * Calculates the line sumatories.
 */
calcSums([], []).

calcSums([R1 | R], [LS1 | LS]) :-
  sum(R1, #=, LS1),
  calcSums(R, LS).

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

  getElementRelative(Result, I-1, J, LeftElem),
  append([], LeftElem, List1),

  getElementRelative(Result, I+1, J, RightElem),
  append(List1, RightElem, List2),

  getElementRelative(Result, I, J-1, UpElem),
  append(List2, UpElem, List3),

  getElementRelative(Result, I, J+1, DownElem),
  append(List3, DownElem, List4),

  restrictNotPrimeOrOne(List4).

/**
 * Predicate to set restriction to a quad element. Must be either 0 or 5 but not have the
 * same digit as a neighbor unless the neighbor is a diamond.
 */
setRestriction(Board, _LineSums, Result, 'q', ResultElem, I, J, _N) :-
  ResultElem #= 0 #\/ ResultElem #= 5,

  getElementRelative(Result, I-1, J, LeftElemResult),
  getElementRelative(Board, I-1, J, LeftElemBoard),
  append([], LeftElemResult, List1Result),
  append([], LeftElemBoard, List1Board),

  getElementRelative(Result, I+1, J, RightElemResult),
  getElementRelative(Board, I+1, J, RightElemBoard),
  append(List1Result, RightElemResult, List2Result),
  append(List1Board, RightElemBoard, List2Board),

  getElementRelative(Result, I, J-1, UpElemResult),
  getElementRelative(Board, I, J-1, UpElemBoard),
  append(List2Result, UpElemResult, List3Result),
  append(List2Board, UpElemBoard, List3Board),

  getElementRelative(Result, I, J+1, DownElemResult),
  getElementRelative(Board, I, J+1, DownElemBoard),
  append(List3Result, DownElemResult, List4Result),
  append(List3Board, DownElemBoard, List4Board),

  restrictDifferentExceptDiamond(List4Result, List4Board, ResultElem).

/**
 * Predicate to set restriction to a diamond element. Is odd and is the sum of all digits left
 * of it in the row.
 */
setRestriction(_Board, _LineSums, Result, 'd', ResultElem, I, J, _N) :-
  restrictOdd(ResultElem),
  LeftI is I-1,
  getLeftElements(Result, LeftI, J, [], Left),
  write(Left),nl,
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
 * Predicate to set restriction to a circle element. Not a multiple of 3, and all copies are
 * the same digit within the specific grid.
 */
setRestriction(Board, _LineSums, Result, 'c', ResultElem, I, J, _N) :-
  restrictNotMultiple3(ResultElem),

  getElementRelative(Result, I-1, J-1, TopLeftElemResult),
  getElementRelative(Board, I-1, J-1, TopLeftElemBoard),
  append([], TopLeftElemResult, List1Result),
  append([], TopLeftElemBoard, List1Board),

  getElementRelative(Result, I, J-1, TopElemResult),
  getElementRelative(Board, I, J-1, TopElemBoard),
  append(List1Result, TopElemResult, List2Result),
  append(List1Board, TopElemBoard, List2Board),

  getElementRelative(Result, I+1, J-1, TopRightElemResult),
  getElementRelative(Board, I+1, J-1, TopRightElemBoard),
  append(List2Result, TopRightElemResult, List3Result),
  append(List2Board, TopRightElemBoard, List3Board),

  getElementRelative(Result, I-1, J, LeftElemResult),
  getElementRelative(Board, I-1, J, LeftElemBoard),
  append(List3Result, LeftElemResult, List4Result),
  append(List3Board, LeftElemBoard, List4Board),

  getElementRelative(Result, I+1, J, RightElemResult),
  getElementRelative(Board, I+1, J, RightElemBoard),
  append(List4Result, RightElemResult, List5Result),
  append(List4Board, RightElemBoard, List5Board),

  getElementRelative(Result, I-1, J+1, BotLeftElemResult),
  getElementRelative(Board, I-1, J+1, BotLeftElemBoard),
  append(List5Result, BotLeftElemResult, List6Result),
  append(List5Board, BotLeftElemBoard, List6Board),

  getElementRelative(Result, I, J+1, BotElemResult),
  getElementRelative(Board, I, J+1, BotElemBoard),
  append(List6Result, BotElemResult, List7Result),
  append(List6Board, BotElemBoard, List7Board),

  getElementRelative(Result, I+1, J+1, BotRightElemResult),
  getElementRelative(Board, I+1, J+1, BotRightElemBoard),
  append(List7Result, BotRightElemResult, List8Result),
  append(List7Board, BotRightElemBoard, List8Board),

  restrictEqualCircles(List8Result, List8Board, ResultElem).

/**
 * Predicate to set restriction to a knight (chess) element. Chess knight - tells amount of even digits
 * (incl. 0) in its attack range.
 */
setRestriction(_Board, _LineSums, Result, 'k', ResultElem, I, J, _N) :-
  getElementRelative(Result, I-2, J-1, TLHResult),
  append([], TLHResult, List1Result),

  getElementRelative(Result, I-1, J-2, TLVResult),
  append(List1Result, TLVResult, List2Result),

  getElementRelative(Result, I+2, J-1, TRHResult),
  append(List2Result, TRHResult, List3Result),

  getElementRelative(Result, I+1, J-2, TRVResult),
  append(List3Result, TRVResult, List4Result),

  getElementRelative(Result, I-2, J+1, BLHResult),
  append(List4Result, BLHResult, List5Result),

  getElementRelative(Result, I-1, J+2, BLVResult),
  append(List5Result, BLVResult, List6Result),

  getElementRelative(Result, I+2, J+1, BRHResult),
  append(List6Result, BRHResult, List7Result),

  getElementRelative(Result, I+1, J+2, BRVResult),
  append(List7Result, BRVResult, List8Result),

  getElementsParity(List8Result, [], Parity),
  sum(Parity, #=, ResultElem).

/**
 * Predicate to set restriction to a heart element. Neighboring hearts must add together
 * to a sum of 10.
 */
setRestriction(Board, _LineSums, Result, 'h', ResultElem, I, J, _N) :-
  getElementRelative(Result, I-1, J, LeftElemResult),
  getElementRelative(Board, I-1, J, LeftElemBoard),
  append([], LeftElemResult, List1Result),
  append([], LeftElemBoard, List1Board),

  getElementRelative(Result, I+1, J, RightElemResult),
  getElementRelative(Board, I+1, J, RightElemBoard),
  append(List1Result, RightElemResult, List2Result),
  append(List1Board, RightElemBoard, List2Board),

  getElementRelative(Result, I, J-1, UpElemResult),
  getElementRelative(Board, I, J-1, UpElemBoard),
  append(List2Result, UpElemResult, List3Result),
  append(List2Board, UpElemBoard, List3Board),

  getElementRelative(Result, I, J+1, DownElemResult),
  getElementRelative(Board, I, J+1, DownElemBoard),
  append(List3Result, DownElemResult, List4Result),
  append(List3Board, DownElemBoard, List4Board),

  getNeighboringHearts(List4Result, List4Board, [], NeighboringHearts),
  append(NeighboringHearts, [ResultElem], Hearts),
  sum(Hearts, #=, 10).
