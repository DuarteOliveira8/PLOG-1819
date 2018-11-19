/* Replaces number 1 on board with Yuki character */
numToChar(1, C):-C='Y'.
/* Replaces number 2 on board with Mina character (empty space) */
numToChar(2, C):-C='M'.
/* Replaces number 5 on board with Mina character (on a tree) */
numToChar(5, C):-C='M'.
/* Replaces number 0 on board with empty space character */
numToChar(0, C):-C='O'.
/* Replaces number 3 on board with tree character */
numToChar(3, C):-C='+'.

/* Board Display Predicate */
board_display([L1 | L], Player) :-
  board_display([L1 | L], Player, 1).

/* When we reach line number 11, we print the board lower limit, column coordinates and player turn */
board_display([], Player, 11) :-
  write('-----------------------------------------\n'),
  write('  1   2   3   4   5   6   7   8   9   10\n'),
  write(Player),
  write('\'s turn.\n').

/* Prints all line content until line 11 and line formatting */
board_display([L1 | L], Player, NLine) :-
  write('-----------------------------------------\n'),
  line_display(L1),
  write(' '),
  write(NLine),
  nl,
  NewNLine is NLine+1,
  board_display(L, Player, NewNLine).

/* Prints the last character that defines the end of line border */
line_display([]):-
  write('|').

/* Prints line content and the character between cells */
line_display([C1 | C]):-
  numToChar(C1, Symbol),
  write('| '),
  write(Symbol),
  write(' '),
  line_display(C).
