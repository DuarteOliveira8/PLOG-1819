initializeGame :-
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
  GameState = [Board, YukiX, YukiY, MinaX, MinaY, 0, 0],
  board_display(Board, 'Yuki'),
  inputPosition(YukiX, YukiY),
  eatTree(YukiX, YukiY, Board, NoTreeBoard),
  addPlayerPosition(1, YukiX, YukiY, NoTreeBoard, YukiBoard),
  write('\33\[2J'),
  board_display(YukiBoard, 'Mina'),
  inputPosition(MinaX, MinaY),
  addPlayerPosition(2, MinaX, MinaY, YukiBoard, MinaBoard),
  write('\33\[2J'),
  gameCycle(YukiX, YukiY, MinaX, MinaY, MinaBoard).

gameCycle(YukiX, YukiY, MinaX, MinaY, Board) :-
  yukiPlay(YukiX, YukiY, NewYukiX, NewYukiY, MinaX, MinaY, Board, YukiBoard),
  minaPlay(MinaX, MinaY, NewMinaX, NewMinaY, NewYukiX, NewYukiY, YukiBoard, MinaBoard),
  gameCycle(NewYukiX, NewYukiY, NewMinaX, NewMinaY, MinaBoard).

yukiPlay(YukiX, YukiY, NewYukiX, NewYukiY, MinaX, MinaY, Board, NewBoard) :-
  write('\33\[2J'),
  board_display(Board, 'Yuki'),
  removePlayerPosition(1, YukiX, YukiY, Board, NoYukiBoard),
  askPlayerPosition(y, YukiX, YukiY, NewYukiX, NewYukiY, MinaX, MinaY, Board),
  eatTree(NewYukiX, NewYukiY, NoYukiBoard, NoTreeBoard),
  addPlayerPosition(1, NewYukiX, NewYukiY, NoTreeBoard, NewBoard).

eatTree(X, Y, Board, NBoard) :-
  addToMultListCell(-3, X, Y, Board, NBoard).

minaPlay(MinaX, MinaY, NewMinaX, NewMinaY, YukiX, YukiY, Board, NewBoard) :-
  write('\33\[2J'),
  board_display(Board, 'Mina'),
  removePlayerPosition(2, MinaX, MinaY, Board, NoMinaBoard),
  askPlayerPosition(m, MinaX, MinaY, NewMinaX, NewMinaY, YukiX, YukiY, Board),
  addPlayerPosition(2, NewMinaX, NewMinaY, NoMinaBoard, NewBoard).

askPlayerPosition(Player, X, Y, NewX, NewY, OponentX, OponentY, Board) :-
  inputPosition(NewX2, NewY2),
  (Player = y ->
    (checkValidYukiInput(X, Y, NewX2, NewY2, OponentX, OponentY, Board) ->
      NewX is NewX2,
      NewY is NewY2
    ;
      write('Invalid move!\n'),
      askPlayerPosition(Player, X, Y, NewX, NewY, OponentX, OponentY, Board)
    )
  ;
    (checkValidMinaInput(X, Y, NewX2, NewY2, OponentX, OponentY, Board) ->
      NewX is NewX2,
      NewY is NewY2
    ;
      write('Invalid move!\n'),
      askPlayerPosition(Player, X, Y, NewX, NewY, OponentX, OponentY, Board)
    )
  ).

inputPosition(X, Y) :-
  write('Type X coordinate: '),
  read(X),
  nl,
  write('Type Y coordinate: '),
  read(Y),
  nl.

removePlayerPosition(Player, X, Y, Board, NBoard) :-
  addToMultListCell(-Player, X, Y, Board, NBoard).

addPlayerPosition(Player, X, Y, Board, NBoard) :-
  addToMultListCell(Player, X, Y, Board, NBoard).
