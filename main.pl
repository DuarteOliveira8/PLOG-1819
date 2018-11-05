board_display([L1 | L], Player) :-
  board_display([L1 | L], Player, 1).

board_display([L1], Player, NLine) :-
  write('-----------------------------------------'),
  nl,
  line_display(L1),
  write(' '),
  write(NLine),
  nl,
  write('-----------------------------------------'),
  nl,
  write('  1   2   3   4   5   6   7   8   9   10'),
  nl,
  write(Player),
  write(' turn').

board_display([L1 | L], Player, NLine) :-
  write('-----------------------------------------'),
  nl,
  line_display(L1),
  write(' '),
  write(NLine),
  nl,
  NewNLine is NLine+1,
  board_display(L, Player, NewNLine).

line_display([C1]):-
  write('| '),
  write(C1),
  write(' '),
  write('|').

line_display([C1 | C]):-
  write('| '),
  write(C1),
  write(' '),
  line_display(C).
