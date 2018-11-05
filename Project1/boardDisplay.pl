numToChar(1, C):-C='Y'.
numToChar(2, C):-C='M'.
numToChar(0, C):-C='O'.
numToChar(3, C):-C='+'.

board_display([L1 | L], Player) :-
  board_display([L1 | L], Player, 1).

board_display([], Player, 11) :-
  write('-----------------------------------------\n'),
  write('  1   2   3   4   5   6   7   8   9   10\n'),
  write(Player),
  write(' turn\n').

board_display([L1 | L], Player, NLine) :-
  write('-----------------------------------------\n'),
  line_display(L1),
  write(' '),
  write(NLine),
  nl,
  NewNLine is NLine+1,
  board_display(L, Player, NewNLine).

line_display([]):-
  write('|').

line_display([C1 | C]):-
  numToChar(C1, Symbol),
  write('| '),
  write(Symbol),
  write(' '),
  line_display(C).
