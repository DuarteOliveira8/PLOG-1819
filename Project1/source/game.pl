initializeGame('p', 'p') :-
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
  board_display(YukiBoard, 'Mina'),
  inputPosition(MinaX, MinaY),
  addPlayerPosition(2, MinaX, MinaY, YukiBoard, MinaBoard),
  write('\33\[2J'),
  gameCycle(1, MinaBoard, Winner),
  write('Winner is '), write(Winner), nl.

initializeGame('p', 'c').

initializeGame('c', 'c').

gameCycle(1, Board, Winner) :-
  valid_moves(Board, 1, ValidPlays),
  \+ game_over(2, Board, Winner, ValidPlays),
  yukiTurn(Board, YukiBoard, ValidPlays),
  gameCycle(2, YukiBoard, Winner).

gameCycle(1, Board, Winner) :-
  valid_moves(Board, 1, ValidPlays),
  game_over(2, Board, Winner, ValidPlays).

gameCycle(2, Board, Winner) :-
  valid_moves(Board, 2, ValidPlays),
  \+ game_over(1, Board, Winner, ValidPlays),
  minaTurn(Board, MinaBoard, ValidPlays),
  gameCycle(1, MinaBoard, Winner).

gameCycle(2, Board, Winner) :-
  valid_moves(Board, 2, ValidPlays),
  game_over(1, Board, Winner, ValidPlays).

yukiTurn(Board, NewBoard, ValidPlays) :-
  write('\33\[2J'),
  board_display(Board, 'Yuki'),
  write(ValidPlays),nl,
  askPlayerPosition(1, ValidPlays, Board, NewBoard).

minaTurn(Board, NewBoard, ValidPlays) :-
  write('\33\[2J'),
  board_display(Board, 'Mina'),
  write(ValidPlays),nl,
  askPlayerPosition(2, ValidPlays, Board, NewBoard).

askPlayerPosition(Player, ValidPlays, Board, NewBoard) :-
  inputPosition(X, Y),
  move(Player, X, Y, ValidPlays, Board, NewBoard).

move(1, X, Y, ValidPlays, Board, NewBoard) :-
  getYukiPosition(YukiX, YukiY, Board),
  removePlayerPosition(1, YukiX, YukiY, Board, NoYukiBoard),
  checkValidPlayerInput(1, [X, Y], NewX, NewY, ValidPlays),
  eatTree(NewX, NewY, NoYukiBoard, NoTreeBoard),
  addPlayerPosition(1, NewX, NewY, NoTreeBoard, NewBoard).

move(2, X, Y, ValidPlays, Board, NewBoard) :-
  getMinaPosition(MinaX, MinaY, Board),
  removePlayerPosition(2, MinaX, MinaY, Board, NoMinaBoard),
  checkValidPlayerInput(2, [X, Y], NewX, NewY, ValidPlays),
  addPlayerPosition(2, NewX, NewY, NoMinaBoard, NewBoard).

eatTree(X, Y, Board, NBoard) :-
  addToMultListCell(-3, X, Y, Board, NBoard).

inputPosition(ValidX, ValidY) :-
  write('Type X coordinate: '),
  read(X),
  nl,
  write('Type Y coordinate: '),
  read(Y),
  nl,
  validPosition(X, Y, ValidX, ValidY).

validPosition(X, Y, ValidX, ValidY) :-
  number(X),
  number(Y),
  between(1, 10, X),
  between(1, 10, Y),
  ValidX is X,
  ValidY is Y.

validPosition(X, _Y, ValidX, ValidY) :-
  number(X),
  \+ between(1, 10, X),
  write('Not a valid coordinate! Try again:\n'),
  inputPosition(ValidX, ValidY).

validPosition(_X, Y, ValidX, ValidY) :-
  number(Y),
  \+ between(1, 10, Y),
  write('Not a valid coordinate! Try again:\n'),
  inputPosition(ValidX, ValidY).

validPosition(X, _Y, ValidX, ValidY) :-
  \+ number(X),
  write('Not a valid coordinate! Try again:\n'),
  inputPosition(ValidX, ValidY).

validPosition(_X, Y, ValidX, ValidY) :-
  \+ number(Y),
  write('Not a valid coordinate! Try again:\n'),
  inputPosition(ValidX, ValidY).

checkValidPlayerInput(_Player, [NewX, NewY], ValidX, ValidY, ValidPlays) :-
  member([NewX, NewY], ValidPlays),
  ValidX is NewX,
  ValidY is NewY.

checkValidPlayerInput(Player, [NewX, NewY], ValidX, ValidY, ValidPlays) :-
  \+ member([NewX, NewY], ValidPlays),
  write('Invalid move!\n'),
  inputPosition(NewX2, NewY2),
  checkValidPlayerInput(Player, [NewX2, NewY2], ValidX, ValidY, ValidPlays).

removePlayerPosition(Player, X, Y, Board, NBoard) :-
  addToMultListCell(-Player, X, Y, Board, NBoard).

addPlayerPosition(Player, X, Y, Board, NBoard) :-
  addToMultListCell(Player, X, Y, Board, NBoard).
