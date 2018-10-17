board_display([L1]) :-
  line_display(L1),
  nl.

board_display([L1 | L]) :-
  line_display(L1),
  nl,
  board_display(L).

line_display([C1]):-
  write(C1),
  write(' ').

line_display([C1 | C]):-
  write(C1),
  write(' '),
  line_display(C).
