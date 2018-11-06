initializeGame(Yuki, Mina) :-
  Board = [[3,3,3,3,3,3,3,3,3,3],
           [3,3,3,3,3,3,3,3,3,3],
           [3,3,3,3,3,3,3,3,3,3],
           [3,3,3,3,3,3,3,3,3,3],
           [3,3,3,3,3,3,3,3,3,3],
           [3,3,3,3,3,3,3,3,3,3],
           [3,3,3,3,3,3,3,3,3,3],
           [3,3,3,3,3,3,3,3,3,3],
           [3,3,3,3,3,3,3,3,3,3],
           [3,3,3,3,3,3,3,3,3,3]],
  board_display(Board, 'Yuki'),
  askYukiInput(YukiX, YukiY, Board),
  gameCycle(Yuki, YukiX, YukiY, Mina, Board).

gameCycle(Yuki, YukiX, YukiY, Mina, Board) :-
  board_display(Board, 'Yuki'),
  eatTree(YukiX, YukiY, Board),
  askYukiInput(NewYukiX, NewYukiY, Board),
  gameCycle(Yuki, NewYukiX, NewYukiY, Mina, Board).

eatTree(X, Y, Board) :-
  replaceMultList(0, X, Y, Board, Board).

askYukiInput(X, Y, Board) :-
  write('Type X coordinate: '),
  get_char(X),
  skip_line,
  nl,
  write('Type Y coordinate: '),
  get_char(Y),
  skip_line,
  nl,
  changeYukiPosition(X, Y, Board).

changeYukiPosition(X, Y, Board) :-
  write('hello\n').

replaceList(Value, 1, [L1 | L]) :-
  L1 is Value.

replaceList(Value, X, [L1 | L]) :-
  NewX is X-1,
  replaceList(Value, NewX, L).

replaceMultList(Value, X, 1, [B1 | B]) :-
  replaceList(Value, X, B1).

replaceMultList(Value, X, Y, [B1 | B]) :-
  NewY is Y-1,
  replaceMultList(Value, X, NewY, B).
