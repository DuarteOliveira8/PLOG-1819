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
  board_display(Board, 'Yuki'),
  inputPosition(YukiX, YukiY),
  eatTree(YukiX, YukiY, Board, NoTreeBoard),
  addPlayerPosition(1, YukiX, YukiY, NoTreeBoard, YukiBoard),
  write('\33\[2J'),
  board_display(YukiBoard, 'Yuki'),
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
  generateValidYukiPlays(YukiX, YukiY, MinaX, MinaY, Board, ValidPlays),
  checkGameState('Mina', ValidPlays, Board),
  write(ValidPlays),nl,
  removePlayerPosition(1, YukiX, YukiY, Board, NoYukiBoard),
  askPlayerPosition(NewYukiX, NewYukiY, ValidPlays),
  eatTree(NewYukiX, NewYukiY, NoYukiBoard, NoTreeBoard),
  addPlayerPosition(1, NewYukiX, NewYukiY, NoTreeBoard, NewBoard).

eatTree(X, Y, Board, NBoard) :-
  addToMultListCell(-3, X, Y, Board, NBoard).

minaPlay(MinaX, MinaY, NewMinaX, NewMinaY, YukiX, YukiY, Board, NewBoard) :-
  write('\33\[2J'),
  board_display(Board, 'Mina'),
  generateValidMinaPlays(MinaX, MinaY, YukiX, YukiY, Board, ValidPlays),
  checkGameState('Mina', ValidPlays, Board),
  write(ValidPlays),nl,
  removePlayerPosition(2, MinaX, MinaY, Board, NoMinaBoard),
  askPlayerPosition(NewMinaX, NewMinaY, ValidPlays),
  addPlayerPosition(2, NewMinaX, NewMinaY, NoMinaBoard, NewBoard).

askPlayerPosition(NewX, NewY, ValidPlays) :-
  inputPosition(NewX2, NewY2),
  checkValidPlayerInput([NewX2, NewY2], NewX, NewY, ValidPlays).

inputPosition(X, Y) :-
  write('Type X coordinate: '),
  read(X),
  nl,
  write('Type Y coordinate: '),
  read(Y),
  nl.

checkValidPlayerInput([NewX2, NewY2], NewX, NewY, ValidPlays) :-
  member([NewX2, NewY2], ValidPlays),
  NewX is NewX2,
  NewY is NewY2.

checkValidPlayerInput([NewX2, NewY2], NewX, NewY, ValidPlays) :-
  \+ member([NewX2, NewY2], ValidPlays),
  write('Invalid move!\n'),
  askPlayerPosition(NewX, NewY, ValidPlays).

removePlayerPosition(Player, X, Y, Board, NBoard) :-
  addToMultListCell(-Player, X, Y, Board, NBoard).

addPlayerPosition(Player, X, Y, Board, NBoard) :-
  addToMultListCell(Player, X, Y, Board, NBoard).