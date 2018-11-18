initializeSet('p', 'p') :-
  Score = [0, 0],
  write('Player 1 plays as Yuki and Player 2 plays as Mina!\n'),
  sleep(3),
  initializeGame('p', 'p', CharWinner1, Game1Board),
  sleep(3),
  write('\33\[2J'),
  write('Game winner is '), write(CharWinner1), nl,
  updateGame1Score(Score, CharWinner1, Game1Score),
  sleep(3),
  write('\33\[2J'),
  write('Change sides and prepare for the next game!\n'),
  sleep(3),
  write('\33\[2J'),
  initializeGame('p', 'p', CharWinner2, Game2Board),
  sleep(3),
  write('\33\[2J'),
  write('Game winner is '), write(CharWinner2), nl,
  sleep(3),
  write('\33\[2J'),
  updateGame2Score(Game1Score, CharWinner2, Game2Score),
  announceSetWinner(Game2Score, CharWinner2, Game1Board, Game2Board),
  sleep(3),
  write('\33\[2J').

initializeSet('p', 'c') :-
  Score = [0, 0],
  write('Player plays as Yuki and Computer plays as Mina!\n'),
  sleep(3),
  initializeGame('p', 'c', CharWinner1, Game1Board),
  sleep(3),
  write('\33\[2J'),
  write('Game winner is '), write(CharWinner1), nl,
  updateGame1Score(Score, CharWinner1, Game1Score),
  sleep(3),
  write('\33\[2J'),
  write('Change sides and prepare for the next game!\n'),
  sleep(3),
  write('\33\[2J'),
  initializeGame('c', 'p', CharWinner2, Game2Board),
  sleep(3),
  write('\33\[2J'),
  write('Game winner is '), write(CharWinner2), nl,
  sleep(3),
  write('\33\[2J'),
  updateGame2Score(Game1Score, CharWinner2, Game2Score),
  announceSetWinner(Game2Score, CharWinner2, Game1Board, Game2Board),
  sleep(3),
  write('\33\[2J').

initializeSet('c', 'p') :-
  Score = [0, 0],
  write('Player plays as Yuki and Computer plays as Mina!\n'),
  sleep(3),
  initializeGame('c', 'p', CharWinner1, Game1Board),
  sleep(3),
  write('\33\[2J'),
  write('Game winner is '), write(CharWinner1), nl,
  updateGame1Score(Score, CharWinner1, Game1Score),
  sleep(3),
  write('\33\[2J'),
  write('Change sides and prepare for the next game!\n'),
  sleep(3),
  write('\33\[2J'),
  initializeGame('p', 'c', CharWinner2, Game2Board),
  sleep(3),
  write('\33\[2J'),
  write('Game winner is '), write(CharWinner2), nl,
  sleep(3),
  write('\33\[2J'),
  updateGame2Score(Game1Score, CharWinner2, Game2Score),
  announceSetWinner(Game2Score, CharWinner2, Game1Board, Game2Board),
  sleep(3),
  write('\33\[2J').

initializeSet('c', 'c') :-
  Score = [0, 0],
  write('Computer 1 plays as Yuki and Computer 2 plays as Mina!\n'),
  sleep(3),
  initializeGame('c', 'c', CharWinner1, Game1Board),
  sleep(3),
  write('\33\[2J'),
  write('Game winner is '), write(CharWinner1), nl,
  updateGame1Score(Score, CharWinner1, Game1Score),
  sleep(3),
  write('\33\[2J'),
  write('Change sides and prepare for the next game!\n'),
  sleep(3),
  write('\33\[2J'),
  initializeGame('c', 'c', CharWinner2, Game2Board),
  sleep(3),
  write('\33\[2J'),
  write('Game winner is '), write(CharWinner2), nl,
  sleep(3),
  write('\33\[2J'),
  updateGame2Score(Game1Score, CharWinner2, Game2Score),
  announceSetWinner(Game2Score, CharWinner2, Game1Board, Game2Board),
  sleep(3),
  write('\33\[2J').

initializeGame('p', 'p', Winner, FinalBoard) :-
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
  isValidFirstPlay(MinaX, MinaY, ValidMinaX, ValidMinaY, YukiX, YukiY, YukiBoard),
  addPlayerPosition(2, ValidMinaX, ValidMinaY, YukiBoard, MinaBoard),
  write('\33\[2J'),
  gameCycle('Yuki', 'p', 1, MinaBoard, Winner, FinalBoard).

initializeGame('p', 'c', Winner, FinalBoard) :-
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
  writeChoosingMessage,
  chooseBestFirstPlay(MinaX, MinaY, YukiBoard),
  addPlayerPosition(2, MinaX, MinaY, YukiBoard, MinaBoard),
  write('\33\[2J'),
  gameCycle('Yuki', 'p', 2, MinaBoard, Winner, FinalBoard).

initializeGame('c', 'p', Winner, FinalBoard) :-
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
  writeChoosingMessage,
  chooseRandomFirstPlay(YukiX, YukiY),
  eatTree(YukiX, YukiY, Board, NoTreeBoard),
  addPlayerPosition(1, YukiX, YukiY, NoTreeBoard, YukiBoard),
  write('\33\[2J'),
  board_display(YukiBoard, 'Mina'),
  inputPosition(MinaX, MinaY),
  isValidFirstPlay(MinaX, MinaY, ValidMinaX, ValidMinaY, YukiX, YukiY, YukiBoard),
  addPlayerPosition(2, ValidMinaX, ValidMinaY, YukiBoard, MinaBoard),
  write('\33\[2J'),
  gameCycle('Yuki', 'c', 2, MinaBoard, Winner, FinalBoard).

initializeGame('c', 'c', Winner, FinalBoard) :-
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
  writeChoosingMessage,
  chooseRandomFirstPlay(YukiX, YukiY),
  eatTree(YukiX, YukiY, Board, NoTreeBoard),
  addPlayerPosition(1, YukiX, YukiY, NoTreeBoard, YukiBoard),
  write('\33\[2J'),
  board_display(YukiBoard, 'Mina'),
  writeChoosingMessage,
  chooseBestFirstPlay(MinaX, MinaY, YukiBoard),
  addPlayerPosition(2, MinaX, MinaY, YukiBoard, MinaBoard),
  write('\33\[2J'),
  gameCycle('Yuki', 'c', 3, MinaBoard, Winner, FinalBoard).

gameCycle(Player, Type, Mode, Board, Winner, FinalBoard) :-
  valid_moves(Board, Player, ValidPlays),
  getOppositePlayer(Player, NextPlayer),
  \+ game_over(NextPlayer, Board, Winner, ValidPlays),
  playerTurn(Player, Type, Board, MinaBoard, ValidPlays),
  getNextType(Type, Mode, NewType),
  write(NewType),nl,
  gameCycle(NextPlayer, NewType, Mode, MinaBoard, Winner, FinalBoard).

gameCycle(Player, _Type, _Mode, Board, Winner, FinalBoard) :-
  valid_moves(Board, Player, ValidPlays),
  getOppositePlayer(Player, NextPlayer),
  game_over(NextPlayer, Board, Winner, ValidPlays),
  write('\33\[2J'),
  board_display(Board, Player),
  FinalBoard = Board.

playerTurn('Yuki', 'p', Board, NewBoard, ValidPlays) :-
  write('\33\[2J'),
  board_display(Board, 'Yuki'),
  write(ValidPlays),nl,
  askPlayerPosition('Yuki', ValidPlays, Board, NewBoard).

playerTurn('Yuki', 'c', Board, NewBoard, ValidPlays) :-
  write('\33\[2J'),
  board_display(Board, 'Yuki'),
  write(ValidPlays),nl,
  getYukiPosition(YukiX, YukiY, Board),
  removePlayerPosition(1, YukiX, YukiY, Board, NoYukiBoard),
  writeChoosingMessage,
  chooseBestYukiPlay(NewYukiX, NewYukiY, Board, ValidPlays),
  eatTree(NewYukiX, NewYukiY, NoYukiBoard, NoTreeBoard),
  addPlayerPosition(1, NewYukiX, NewYukiY, NoTreeBoard, NewBoard).

playerTurn('Mina', 'p', Board, NewBoard, ValidPlays) :-
  write('\33\[2J'),
  board_display(Board, 'Mina'),
  write(ValidPlays),nl,
  askPlayerPosition('Mina', ValidPlays, Board, NewBoard).

playerTurn('Mina', 'c', Board, NewBoard, ValidPlays) :-
  write('\33\[2J'),
  board_display(Board, 'Mina'),
  write(ValidPlays),nl,
  getMinaPosition(MinaX, MinaY, Board),
  removePlayerPosition(2, MinaX, MinaY, Board, NoMinaBoard),
  writeChoosingMessage,
  chooseBestMinaPlay(NewMinaX, NewMinaY, Board, ValidPlays),
  addPlayerPosition(2, NewMinaX, NewMinaY, NoMinaBoard, NewBoard).

askPlayerPosition(Player, ValidPlays, Board, NewBoard) :-
  inputPosition(X, Y),
  move(Player, X, Y, ValidPlays, Board, NewBoard).

move('Yuki', X, Y, ValidPlays, Board, NewBoard) :-
  getYukiPosition(YukiX, YukiY, Board),
  removePlayerPosition(1, YukiX, YukiY, Board, NoYukiBoard),
  checkValidPlayerInput([X, Y], NewX, NewY, ValidPlays),
  eatTree(NewX, NewY, NoYukiBoard, NoTreeBoard),
  addPlayerPosition(1, NewX, NewY, NoTreeBoard, NewBoard).

move('Mina', X, Y, ValidPlays, Board, NewBoard) :-
  getMinaPosition(MinaX, MinaY, Board),
  removePlayerPosition(2, MinaX, MinaY, Board, NoMinaBoard),
  checkValidPlayerInput([X, Y], NewX, NewY, ValidPlays),
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

checkValidPlayerInput([NewX, NewY], ValidX, ValidY, ValidPlays) :-
  member([NewX, NewY], ValidPlays),
  ValidX is NewX,
  ValidY is NewY.

checkValidPlayerInput([NewX, NewY], ValidX, ValidY, ValidPlays) :-
  \+ member([NewX, NewY], ValidPlays),
  write('Invalid move!\n'),
  inputPosition(NewX2, NewY2),
  checkValidPlayerInput([NewX2, NewY2], ValidX, ValidY, ValidPlays).

isValidFirstPlay(MinaX, MinaY, ValidMinaX, ValidMinaY, YukiX, YukiY, Board) :-
  \+ isVisible(MinaX, MinaY, YukiX, YukiY, Board),
  \+ checkValueMultList(1, MinaX, MinaY, Board),
  ValidMinaX is MinaX,
  ValidMinaY is MinaY.

isValidFirstPlay(MinaX, MinaY, ValidMinaX, ValidMinaY, YukiX, YukiY, Board) :-
  isVisible(MinaX, MinaY, YukiX, YukiY, Board),
  write('Invalid first coordinates! Try again:\n'),
  inputPosition(MinaX2, MinaY2),
  isValidFirstPlay(MinaX2, MinaY2, ValidMinaX, ValidMinaY, YukiX, YukiY, Board).

isValidFirstPlay(MinaX, MinaY, ValidMinaX, ValidMinaY, YukiX, YukiY, Board) :-
  checkValueMultList(1, MinaX, MinaY, Board),
  write('Invalid first coordinates! Try again:\n'),
  inputPosition(MinaX2, MinaY2),
  isValidFirstPlay(MinaX2, MinaY2, ValidMinaX, ValidMinaY, YukiX, YukiY, Board).
