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
  askYukiInput(YukiX, YukiY, Board, YukiBoard),
  write('\33\[2J'),
  board_display(YukiBoard, 'Mina'),
  askMinaInput(MinaX, MinaY, YukiBoard, MinaBoard),
  write('\33\[2J'),
  gameCycle(Yuki, YukiX, YukiY, Mina, MinaX, MinaY, MinaBoard).

gameCycle(Yuki, YukiX, YukiY, Mina, MinaX, MinaY, Board) :-
  board_display(Board, 'Yuki'),
  eatTree(YukiX, YukiY, Board, NoTreeBoard),
  askYukiInput(NewYukiX, NewYukiY, NoTreeBoard, YukiBoard),
  board_display(YukiBoard, 'Mina'),
  askMinaInput(NewMinaX, NewMinaY, YukiBoard, MinaBoard),
  gameCycle(Yuki, NewYukiX, NewYukiY, Mina, NewMinaX, NewMinaY, MinaBoard).

eatTree(X, Y, Board, NBoard) :-
  replaceMultList(0, X, Y, Board, NBoard).

askYukiInput(X, Y, Board, NBoard) :-
  askPosition(X, Y),
  changePlayerPosition(1, X, Y, Board, NBoard).

askMinaInput(X, Y, Board, NBoard) :-
  askPosition(X, Y),
  changePlayerPosition(2, X, Y, Board, NBoard).

askPosition(X, Y) :-
  write('Type X coordinate: '),
  read(X),
  nl,
  write('Type Y coordinate: '),
  read(Y),
  nl.

changePlayerPosition(Player, X, Y, Board, NBoard) :-
  replaceMultList(Player, X, Y, Board, NBoard).

replaceList(Value, 1, [_L1 | L], [Value | L]).

replaceList(Value, X, [L1 | L], [L1 | NB]) :-
  X > 1,
  NewX is X-1,
  replaceList(Value, NewX, L, NB).

replaceMultList(Value, X, 1, [B1 | B], [NB | B]) :-
  replaceList(Value, X, B1, NB).

replaceMultList(Value, X, Y, [B1 | B], [B1 | NB]) :-
  Y > 1,
  NewY is Y-1,
  replaceMultList(Value, X, NewY, B, NB).
