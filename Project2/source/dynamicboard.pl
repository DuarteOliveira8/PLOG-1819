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

display_board([L1 | L]) :-
  display_line(L1),
  display_board(L).

display_board([]).

display_line([L1 | L]) :-
  write(L1),
  write('|'),
  display_line(L).

display_line([]) :-
  write('end of line'),
  write('|'),
  nl.
