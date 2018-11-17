game_over(Player, _Board, Winner, ValidPlays) :-
  checkValidPlays(ValidPlays),
  Winner = Player.

game_over(Player, Board, Winner, _ValidPlays) :-
  value(Board, Value),
  Value == 93,
  Winner = Player.

checkValidPlays(ValidPlays) :-
  length(ValidPlays, 0).

value(Board, Value) :-
  sumMultList(0, Value, Board).

valid_moves(Board, Player, ValidPlays) :-
  Player == 'Yuki',
  findall([X,Y], checkValidYukiPlay(X, Y, Board), ValidPlays).

valid_moves(Board, Player, ValidPlays) :-
  Player == 'Mina',
  findall([X,Y], checkValidMinaPlay(X, Y, Board), ValidPlays).

checkValidYukiPlay(X, Y, Board) :-
  between(1, 10, X),
  between(1, 10, Y),
  getYukiPosition(YukiX, YukiY, Board),
  DX is abs(X-YukiX),
  DY is abs(Y-YukiY),
  between(0, 1, DX),
  between(0, 1, DY),
  \+ checkValueMultList(1, X, Y, Board),
  \+ checkValueMultList(2, X, Y, Board),
  \+ checkValueMultList(5, X, Y, Board),
  \+ checkValueMultList(0, X, Y, Board),
  getMinaPosition(MinaX, MinaY, Board),
  isVisible(MinaX, MinaY, X, Y, Board).

/* remove ifs */
checkValidMinaPlay(X, Y, Board) :-
  between(1, 10, X),
  between(1, 10, Y),
  getMinaPosition(MinaX, MinaY, Board),
  DX is abs(X-MinaX),
  DY is abs(Y-MinaY),
  (DX > 0, DY == 0 ; DX == 0, DY > 0 ; DX == DY, DX =\= 0),
  \+ checkValueMultList(1, X, Y, Board),
  \+ checkValueMultList(2, X, Y, Board),
  \+ checkValueMultList(5, X, Y, Board),
  getYukiPosition(YukiX, YukiY, Board),
  \+ isVisible(X, Y, YukiX, YukiY, Board).

isVisible(MinaX, MinaY, YukiX, YukiY, Board) :-
  DX is MinaX-YukiX,
  DY is MinaY-YukiY,
  GCD is gcd(DX,DY),
  calcXYratios(DX, DY, RXY, RYX),
  isDirectlyVisible(GCD, DX, DY, RXY, RYX, MinaX, MinaY, YukiX, YukiY, Board).

calcXYratios(DX, 0, RXY, RYX) :-
  DX < 0,
  RXY is -1,
  RYX is 0.

calcXYratios(DX, 0, RXY, RYX) :-
  DX > 0,
  RXY is 1,
  RYX is 0.

calcXYratios(0, DY, RXY, RYX) :-
  DY < 0,
  RXY is 0,
  RYX is -1.

calcXYratios(0, DY, RXY, RYX) :-
  DY > 0,
  RXY is 0,
  RYX is 1.

calcXYratios(DX, DY, RXY, RYX) :-
  DX =\= 0,
  DY =\= 0,
  RXY is DX/DY,
  RYX is DY/DX.

isDirectlyVisible(1, _DX, _DY, _RXY, _RYX, _MinaX, _MinaY, _YukiX, _YukiY, _Board).

isDirectlyVisible(GCD, DX, DY, RXY, RYX, MinaX, MinaY, YukiX, YukiY, Board) :-
  GCD =\= 1,
  CRXY is ceiling(RXY),
  CRYX is ceiling(RYX),
  calcNextMinaCoords(DX, DY, MinaX, MinaY, CRXY, CRYX, NewMinaX, NewMinaY),
  checkValueMultList(Value, NewMinaX, NewMinaY, Board),
  isUndirectlyVisible(Value, NewMinaX, NewMinaY, YukiX, YukiY, Board).

isUndirectlyVisible(3, _NewMinaX, _NewMinaY, _YukiX, _YukiY, _Board) :-
  fail.

isUndirectlyVisible(1, _NewMinaX, _NewMinaY, _YukiX, _YukiY, _Board).

isUndirectlyVisible(0, NewMinaX, NewMinaY, YukiX, YukiY, Board) :-
  isVisible(NewMinaX, NewMinaY, YukiX, YukiY, Board).

calcNextMinaCoords(DX, DY, MinaX, MinaY, CRXY, CRYX, NewMinaX, NewMinaY) :-
  DX < 0, DY < 0,
  NewMinaX is MinaX+CRXY,
  NewMinaY is MinaY+CRYX.

calcNextMinaCoords(DX, DY, MinaX, MinaY, CRXY, CRYX, NewMinaX, NewMinaY) :-
  DX > 0, DY < 0,
  NewMinaX is MinaX+CRXY,
  NewMinaY is MinaY-CRYX.

calcNextMinaCoords(DX, DY, MinaX, MinaY, CRXY, CRYX, NewMinaX, NewMinaY) :-
  DX < 0, DY > 0,
  NewMinaX is MinaX-CRXY,
  NewMinaY is MinaY+CRYX.

calcNextMinaCoords(DX, DY, MinaX, MinaY, CRXY, CRYX, NewMinaX, NewMinaY) :-
  DX > 0, DY > 0,
  NewMinaX is MinaX-CRXY,
  NewMinaY is MinaY-CRYX.

calcNextMinaCoords(DX, _DY, _MinaX, MinaY, _CRXY, CRYX, _NewMinaX, NewMinaY) :-
  DX == 0,
  NewMinaY is MinaY-CRYX.

calcNextMinaCoords(_DX, DY, MinaX, _MinaY, CRXY, _CRYX, NewMinaX, _NewMinaY) :-
  DY == 0,
  NewMinaX is MinaX-CRXY.

updateGame1Score(Score, 'Yuki', NewScore) :-
  addToListCell(1, 1, Score, NewScore).

updateGame1Score(Score, 'Mina', NewScore) :-
  addToListCell(1, 2, Score, NewScore).

updateGame2Score(Score, 'Yuki', NewScore) :-
  addToListCell(1, 2, Score, NewScore).

updateGame2Score(Score, 'Mina', NewScore) :-
  addToListCell(1, 1, Score, NewScore).

announceSetWinner(Score, _CharWinner, _Game1Board, _Game2Board) :-
  checkValueList(2, 1, Score),
  write('Player 1 wins!').

announceSetWinner(Score, _CharWinner, _Game1Board, _Game2Board) :-
  checkValueList(2, 2, Score),
  write('Player 2 wins!').

announceSetWinner(Score, 'Yuki', G1B, G2B) :-
  checkValueList(1, 1, Score),
  checkValueList(1, 2, Score),
  removePlayersBoard(G1B, NoPlayersG1B),
  removePlayersBoard(G2B, NoPlayersG2B),
  sumMultList(0, NumTreesG1, NoPlayersG1B),
  sumMultList(0, NumTreesG2, NoPlayersG2B),
  getFinalWinner('Yuki', NumTreesG1, NumTreesG2).

announceSetWinner(Score, 'Mina', G1B, G2B) :-
  checkValueList(1, 1, Score),
  checkValueList(1, 2, Score),
  removePlayersBoard(G1B, NoPlayersG1B),
  removePlayersBoard(G2B, NoPlayersG2B),
  sumMultList(0, NumTreesG1, NoPlayersG1B),
  sumMultList(0, NumTreesG2, NoPlayersG2B),
  getFinalWinner('Mina', NumTreesG1, NumTreesG2).

getFinalWinner('Yuki', NumTreesG1, NumTreesG2) :-
  NumTreesG1 < NumTreesG2,
  write('Player 1 wins!').

getFinalWinner('Yuki', NumTreesG1, NumTreesG2) :-
  NumTreesG1 > NumTreesG2,
  write('Player 2 wins!').

getFinalWinner('Mina', NumTreesG1, NumTreesG2) :-
  NumTreesG1 > NumTreesG2,
  write('Player 1 wins!').

getFinalWinner('Mina', NumTreesG1, NumTreesG2) :-
  NumTreesG1 < NumTreesG2,
  write('Player 2 wins!').

getFinalWinner(_CharWinner, NumTreesG1, NumTreesG2) :-
  NumTreesG1 == NumTreesG2,
  write('It\'s a draw').
