/**
 * Board pieces.
 */
boardPiece(0,' ').
boardPiece(1,'s').
boardPiece(2,'q').
boardPiece(3,'d').
boardPiece(4,'t').
boardPiece(5,'c').
boardPiece(6,'k').
boardPiece(7,'h').

/**
 * Creates test boards.
 * If the first parameter is 0, a random board is generated.
 * A number higher than 0 creates static boards.
 * Note: All static boards come from thegriddle.net pdf.
 */
dynamicBoard(0, Board, Result, LineSums, N) :-
  random(4, 10, N),
  generateBoard(N, Board),
  fillBoard(Board),
  generateList(N, LineSums),
  generateLineSums(N, LineSums),
  generateBoard(N, Result).

dynamicBoard(1, Board, Result, LineSums, 7) :-
  Board = [['q','k',' ','d','q','c',' '],
           ['q','q','t','c','q','q',' '],
           ['c',' ','t','d','k','q','t'],
           ['h','q','t',' ','d',' ','q'],
           ['h','c','d','c','s','q','q'],
           ['q','t','q','q','q','q','k'],
           ['c','t','d',' ','c','q','t']],
  LineSums = [23,20,26,20,26,19,22],
  Result = [[_A1,_A2,_A3,_A4,_A5,_A6,_A7],
            [_B1,_B2,_B3,_B4,_B5,_B6,_B7],
            [_C1,_C2,_C3,_C4,_C5,_C6,_C7],
            [_D1,_D2,_D3,_D4,_D5,_D6,_D7],
            [_E1,_E2,_E3,_E4,_E5,_E6,_E7],
            [_F1,_F2,_F3,_F4,_F5,_F6,_F7],
            [_G1,_G2,_G3,_G4,_G5,_G6,_G7]].

dynamicBoard(2, Board, Result, LineSums, 7) :-
  Board = [['c',' ','d','k','k','c','h'],
           [' ','q','q','c','h','q','h'],
           ['t','q','h','d','h','q','c'],
           ['t',' ','h','c','q','q','h'],
           ['t','k','s','d','q','c','h'],
           ['t',' ','h','d','q','q','t'],
           ['q','q','h','d','q','c','t']],
  LineSums = [30,43,24,31,37,27,28],
  Result = [[_A1,_A2,_A3,_A4,_A5,_A6,_A7],
            [_B1,_B2,_B3,_B4,_B5,_B6,_B7],
            [_C1,_C2,_C3,_C4,_C5,_C6,_C7],
            [_D1,_D2,_D3,_D4,_D5,_D6,_D7],
            [_E1,_E2,_E3,_E4,_E5,_E6,_E7],
            [_F1,_F2,_F3,_F4,_F5,_F6,_F7],
            [_G1,_G2,_G3,_G4,_G5,_G6,_G7]].

dynamicBoard(3, Board, Result, LineSums, 7) :-
  Board = [['s',' ','c','d','q','q','q'],
           [' ','t','h','c','q','q','q'],
           ['t','t','h','d','q','c','h'],
           ['c','q','q','c','d','k','h'],
           ['h','q','d','c','h','h','q'],
           ['h','c','d','h','t','q','q'],
           ['k',' ','d','h','q','q','c']],
  LineSums = [19,29,21,18,25,39,17],
  Result = [[_A1,_A2,_A3,_A4,_A5,_A6,_A7],
            [_B1,_B2,_B3,_B4,_B5,_B6,_B7],
            [_C1,_C2,_C3,_C4,_C5,_C6,_C7],
            [_D1,_D2,_D3,_D4,_D5,_D6,_D7],
            [_E1,_E2,_E3,_E4,_E5,_E6,_E7],
            [_F1,_F2,_F3,_F4,_F5,_F6,_F7],
            [_G1,_G2,_G3,_G4,_G5,_G6,_G7]].

dynamicBoard(4, Board, Result, LineSums, 4) :-
  Board = [['s','c','d','q'],
           [' ','d','q','c'],
           ['q',' ','c','d'],
           ['q','c','s',' ']],
  LineSums = [19,22,14,23],
  Result = [[_A1,_A2,_A3,_A4],
            [_B1,_B2,_B3,_B4],
            [_C1,_C2,_C3,_C4],
            [_D1,_D2,_D3,_D4]].

/**
 * Generates a board (NxN) with a specified length N.
 */
generateBoard(N, Board) :-
  generateList(N, Board),
  maplist(generateList(N), Board).

/**
 * Generates an empty list with a specified length.
 */
generateList(N, List) :-
  length(List, N).

/**
 * Fills an empty board with board pieces.
 */
fillBoard([]).

fillBoard([B1 | B]) :-
  fillLine(B1),
  fillBoard(B), !.

/**
 * Fills an empty line of the board with board pieces.
 */
fillLine([]).

fillLine([L1 | L]) :-
  random(0, 8, Value),
  boardPiece(Value, L1),
  fillLine(L), !.

/**
 * Generates line sums for the board.
 */
generateLineSums(_N, []).

generateLineSums(N, [LS1 | LS]) :-
  Max is (N*9)+1,
  random(0, Max, LS1),
  generateLineSums(N, LS).


/**
 * Displays the board list as a multidimensional list.
 */
displayBoard([L1 | L], N) :-
  write('-'),
  writeUnderline(N),
  displayBoard([L1 | L], 0, 0, N).

displayBoard(_, _, N, N).

displayBoard(List, N, J, N) :-
  J < N,
  write('|'),
  NewJ is J+1,
  nl,
  write('-'),
  writeUnderline(N),
  displayBoard(List, 0, NewJ, N), !.

displayBoard([L1 | L], I, J, N) :-
  I < N,
  write('| '),
  write(L1),
  write(' '),
  NewI is I+1,
  displayBoard(L, NewI, J, N), !.

/**
 * Draws an underline according to the width of the board.
 */
writeUnderline(0) :- nl.

writeUnderline(N) :-
  N > 0,
  write('----'),
  NewN is N-1,
  writeUnderline(NewN), !.
