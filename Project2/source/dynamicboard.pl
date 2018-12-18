:-use_module(library(random)).
:-use_module(library(lists)).

dynamic_board :-
  random(4, 20, Value),
  write(Value),
  generate_board(Value, Board),
  write(Board).

generate_board(Value, Board) :-
  generate_list(Value, Board),
  maplist(generate_list(Value), Board).

generate_list(Value, List) :-
  length(List, Value).
