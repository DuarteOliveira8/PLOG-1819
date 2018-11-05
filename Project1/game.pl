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
  board_display(Board, 'Yuki'),
  gameCycle(Yuki, YukiX, YukiY, Mina, Board).

gameCycle(Yuki, YukiX, YukiY, Mina, Board) :-
  board_display(Board, 'Yuki'),
  eatTree(YukiX, YukiY),
  askYukiInput(NewYukiX, NewYukiY, Board),
  gameCycle(Yuki, NewYukiX, NewYukiY, Mina, Board).

eatTree(X, Y, Board) :-
  nth1(Y, Board, SubList),
  nth1(X, SubList, Position),
  Position is 0.

askYukiInput(X, Y, Board) :-
  write('Type X coordinate: '),
  read(X),
  nl,
  write('Type Y coordinate: '),
  read(Y),
  nl,
  changeYukiPosition(X, Y, Board).

changeYukiPosition(X, Y, Board) :-
  nth1(Y, Board, SubList),
  nth1(X, SubList, Position),
  Position is 1.
