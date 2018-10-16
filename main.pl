board_display([L1 | L]):- board_display([L1 | L], 10).

board_display([L1 | []]], nLines) :-
  line_display(L1, 10),
  nLine is 11-nLines,
  write(nLine).

board_display([L1 | L], nLines) :-
  line_display(L1, 10),
  nLine is 11-nLines,
  write(nLines),
  newNLines is nLines-1,
  board_display(newNLines).

line_display([C1 | []], nCols):-
  write(C1),
  write(' '),
  write(nCols),
  nl.

line_display([C1 | C], nCols):-
  write(C1),
  write(' '),
  newNCols is nCols-1,
  line_display(newNCols).
