dynamic_board :-
  random(4, 30, Value),
  write(Value),
  nl,
  generate_board(Value, Board),
  display_board(Board).

generate_board(Value, Board) :-
  generate_list(Value, Board),
  maplist(generate_list(Value), Board).

generate_list(Value, List) :-
  length(List, Value).

display_board([L1 | L], N) :-
  write('-'),
  writeUnderline(N),
  display_board([L1 | L], 0, 0, N).

display_board(_, _, N, N).

display_board(List, N, J, N) :-
  J < N,
  write('|'),
  NewJ is J+1,
  nl,
  write('-'),
  writeUnderline(N),
  display_board(List, 0, NewJ, N), !.

display_board([L1 | L], I, J, N) :-
  I < N,
  write('| '),
  write(L1),
  write(' '),
  NewI is I+1,
  display_board(L, NewI, J, N), !.

writeUnderline(0) :- nl.

writeUnderline(N) :-
  N > 0,
  write('----'),
  NewN is N-1,
  writeUnderline(NewN), !.

/**
 * Predicates to create test boards. All boards come from thegriddle.net pdf.
 */
testBoard(1, Board, Result, LineSums) :-
  Board = [['q','k',' ','d','q','c',' '],
           ['q','q','t','c','q','q',' '],
           ['c',' ','t','d','k','q','t'],
           ['h','q','t',' ','d',' ','q'],
           ['h','c','d','c','s','q','q'],
           ['q','t','q','q','q','q','k'],
           ['c','t','d',' ','c','q','t']],
  LineSums = [23,20,26,20,26,19,22],
  Result = [[A1,A2,A3,A4,A5,A6,A7],
            [B1,B2,B3,B4,B5,B6,B7],
            [C1,C2,C3,C4,C5,C6,C7],
            [D1,D2,D3,D4,D5,D6,D7],
            [E1,E2,E3,E4,E5,E6,E7],
            [F1,F2,F3,F4,F5,F6,F7],
            [G1,G2,G3,G4,G5,G6,G7]].

testBoard(2, Board, Result, LineSums) :-
  Board = [['c',' ','d','k','k','c','h'],
           [' ','q','q','c','h','q','h'],
           ['t','q','h','d','h','q','c'],
           ['t',' ','h','c','q','q','h'],
           ['t','k','s','d','q','c','h'],
           ['t',' ','h','d','q','q','t'],
           ['q','q','h','d','q','c','t']],
  LineSums = [30,43,24,31,37,27,28],
  Result = [[A1,A2,A3,A4,A5,A6,A7],
            [B1,B2,B3,B4,B5,B6,B7],
            [C1,C2,C3,C4,C5,C6,C7],
            [D1,D2,D3,D4,D5,D6,D7],
            [E1,E2,E3,E4,E5,E6,E7],
            [F1,F2,F3,F4,F5,F6,F7],
            [G1,G2,G3,G4,G5,G6,G7]].

testBoard(3, Board, Result, LineSums) :-
  Board = [['s',' ','c','d','q','q','q'],
           [' ','t','h','c','q','q','q'],
           ['t','t','h','d','q','c','h'],
           ['c','q','q','c','d','k','h'],
           ['h','q','d','c','h','h','q'],
           ['h','c','d','h','t','q','q'],
           ['k',' ','d','h','q','q','c']],
  LineSums = [19,29,21,18,25,39,17],
  Result = [[A1,A2,A3,A4,A5,A6,A7],
            [B1,B2,B3,B4,B5,B6,B7],
            [C1,C2,C3,C4,C5,C6,C7],
            [D1,D2,D3,D4,D5,D6,D7],
            [E1,E2,E3,E4,E5,E6,E7],
            [F1,F2,F3,F4,F5,F6,F7],
            [G1,G2,G3,G4,G5,G6,G7]].
