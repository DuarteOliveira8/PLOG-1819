board_display([L1], Player) :-
  line_display(L1),
  nl,
  write(Player),
  write(' turn').

board_display([L1 | L], Player) :-
  line_display(L1),
  nl,
  board_display(L, Player).

line_display([C1]):-
  write(C1),
  write(' ').

line_display([C1 | C]):-
  write(C1),
  write(' '),
  line_display(C).
