dynamic_board :-
  random(4, Upper, Value)
  display_board(Value).

display_board(Value) :-
  N is Value-1,
  length(N, List),
  draw_line(List, N),


fill_line([L1 | L], N) :-
  random().
