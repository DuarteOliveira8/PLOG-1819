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
  display_board(List, 0, NewJ, N).

display_board([L1 | L], I, J, N) :-
  I < N,
  write('| '),
  write(L1),
  write(' '),
  NewI is I+1,
  display_board(L, NewI, J, N).

writeUnderline(0) :- nl.

writeUnderline(N) :-
  N > 0,
  write('----'),
  NewN is N-1,
  writeUnderline(NewN).
