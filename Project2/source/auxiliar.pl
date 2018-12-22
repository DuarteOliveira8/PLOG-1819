/**
 * Gets an element on a determined position.
 */
getElement(Value, I, J, Board) :-
  nth0(J, Board, SubList),
  nth0(I, SubList, Value).

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
restrictNotPrimeOrOne([]).

restrictNotPrimeOrOne([N1 | N]) :-
  N1 #= 0 #\/ N1 #= 4 #\/ N1 #= 6 #\/ N1 #= 8 #\/ N1 #= 9,
  restrictNotPrimeOrOne(N).

/**
 * Gets a neighbour element.
 */
getElementRelative(Board, I, J, [Elem]) :-
  AroundI is I,
  AroundJ is J,
  getElement(Elem, AroundI, AroundJ, Board), !.

getElementRelative(_Board, _I, _J, []).

/**
 * Gets all orthogonally neighbours.
 */
getOrthogonals(Board, Result, I, J, BoardElems, ResultElems) :-
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
  append(List3Result, DownElemResult, ResultElems),
  append(List3Board, DownElemBoard, BoardElems).

/**
 * Gets all grid range elements.
 */
getGridRange(Board, Result, I, J, BoardElems, ResultElems) :-
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
  append(List7Result, BotRightElemResult, ResultElems),
  append(List7Board, BotRightElemBoard, BoardElems).

/**
 * Gets elements in chess knight attack range.
 */
getGridRange(Result, I, J, ResultElems) :-
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
  append(List7Result, BRVResult, ResultElems).

/**
 * Restricts Elements around to be different than the element in question. If the element is a diamond, no restrictions is added.
 */
restrictDifferentExceptDiamond([], [], _ResultElem).

restrictDifferentExceptDiamond([_R1 | R], ['d' | B], ResultElem) :-
  restrictDifferentExceptDiamond(R, B, ResultElem).

restrictDifferentExceptDiamond([R1 | R], [_B1 | B], ResultElem) :-
  ResultElem #\= R1,
  restrictDifferentExceptDiamond(R, B, ResultElem).

/**
 * Restricts Circles around to be equal to the element in question.
 */
restrictEqualCircles([], [], _ResultElem).

restrictEqualCircles([R1 | R], ['c' | B], ResultElem) :-
  ResultElem #= R1,
  restrictEqualCircles(R, B, ResultElem).

restrictEqualCircles([_R1 | R], [_B1 | B], ResultElem) :-
  restrictEqualCircles(R, B, ResultElem).

/**
 * Get neighboring hearts around heart.
 */
getNeighboringHearts([], [], Final, Final).

getNeighboringHearts([R1 | R], ['h' | B], Temp, Final) :-
  getNeighboringHearts(R, B, [R1 | Temp], Final).

getNeighboringHearts([_R1 | R], [_B1 | B], Temp, Final) :-
  getNeighboringHearts(R, B, Temp, Final).

/**
 * Restricts element to be odd.
 */
restrictOdd(Number) :-
  Number #= 1 #\/ Number #= 3 #\/ Number #= 5 #\/ Number #= 7 #\/ Number #= 9.

/**
 * Restricts element to be even.
 */
restrictEven(Number) :-
  Number #= 0 #\/ Number #= 2 #\/ Number #= 4 #\/ Number #= 6 #\/ Number #= 8.

/**
 * Restricts elements not to be a multiple of 3.
 */
restrictNotMultiple3(Number) :-
  Number #\= 3 #/\ Number #\= 6 #/\ Number #\= 9.

/**
 * Gets all elemnts to the left of its position.
 */
getLeftElements(_Result, -1, _J, Final, Final).

getLeftElements(Result, I, J, Temp, Final) :-
  I >= 0,
  getElement(Elem, I, J, Result),
  NewI is I-1,
  getLeftElements(Result, NewI, J, [Elem | Temp], Final).

/**
 * Gets all elements parity
 */
getElementsParity([], Final, Final).

getElementsParity([L1 | L], Temp, Final) :-
  (L1 #= 0 #\/ L1 #= 2 #\/ L1 #= 4 #\/ L1 #= 6 #\/ L1 #= 8) #<=> B,
  getElementsParity(L, [B | Temp], Final).
