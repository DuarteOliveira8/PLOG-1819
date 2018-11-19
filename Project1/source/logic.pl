game_over(Player, _Board, Winner, ValidPlays) :-
  checkValidPlays(ValidPlays),
  Winner = Player.

game_over(Player, Board, Winner, _ValidPlays) :-
  checkTotal(Board, Value),
  Value == 93,
  Winner = Player.

checkValidPlays(ValidPlays) :-
  length(ValidPlays, 0).

checkTotal(Board, Value) :-
  sumMultList(0, Value, Board).

valid_moves(Board, 'Yuki', ValidPlays) :-
  findall([X,Y], checkValidYukiPlay(X, Y, Board), ValidPlays).

valid_moves(Board, 'Mina', ValidPlays) :-
  findall([X,Y], checkValidMinaPlay(X, Y, Board), ValidPlays).

checkValidYukiPlay(X, Y, Board) :-
  between(1, 10, X),
  between(1, 10, Y),
  getYukiPosition(YukiX, YukiY, Board),
  DX is abs(X-YukiX),
  DY is abs(Y-YukiY),
  between(0, 1, DX),
  between(0, 1, DY),
  \+ value(1, X, Y, Board),
  \+ value(2, X, Y, Board),
  \+ value(5, X, Y, Board),
  \+ value(0, X, Y, Board),
  getMinaPosition(MinaX, MinaY, Board),
  isVisible(MinaX, MinaY, X, Y, Board).

/* remove ifs */
checkValidMinaPlay(X, Y, Board) :-
  between(1, 10, X),
  between(1, 10, Y),
  getMinaPosition(MinaX, MinaY, Board),
  DX is abs(X-MinaX),
  DY is abs(Y-MinaY),
  isOrtogonalOrDiagonal(DX, DY),
  \+ value(1, X, Y, Board),
  \+ value(2, X, Y, Board),
  \+ value(5, X, Y, Board),
  getYukiPosition(YukiX, YukiY, Board),
  \+ isVisible(X, Y, YukiX, YukiY, Board).

isOrtogonalOrDiagonal(DX, DY) :-
  DX > 0,
  DY == 0.

isOrtogonalOrDiagonal(DX, DY) :-
  DX == 0,
  DY > 0.

isOrtogonalOrDiagonal(DX, DY) :-
  DX == DY,
  DX =\= 0.

isVisible(MinaX, MinaY, YukiX, YukiY, Board) :-
  DX is MinaX-YukiX,
  DY is MinaY-YukiY,
  GCD is gcd(DX,DY),
  calcXYratios(DX, DY, 1, RXY, RYX),
  isDirectlyVisible(GCD, DX, DY, RXY, RYX, MinaX, MinaY, YukiX, YukiY, Board).

calcXYratios(DX, 0, _Mult, RXY, RYX) :-
  DX < 0,
  RXY is -1,
  RYX is 0.

calcXYratios(DX, 0, _Mult, RXY, RYX) :-
  DX > 0,
  RXY is 1,
  RYX is 0.

calcXYratios(0, DY, _Mult, RXY, RYX) :-
  DY < 0,
  RXY is 0,
  RYX is -1.

calcXYratios(0, DY, _Mult, RXY, RYX) :-
  DY > 0,
  RXY is 0,
  RYX is 1.

calcXYratios(DX, DY, Mult, RXY, RYX) :-
  DX =\= 0,
  DY =\= 0,
  RXY1 is (DX/DY)*Mult,
  RYX1 is (DY/DX)*Mult,
  UpperXY is float(ceiling(abs(RXY1))*sign(RXY1)),
  UpperYX is float(ceiling(abs(RYX1))*sign(RYX1)),
  RXY1 =\= UpperXY,
  RYX1 =\= UpperYX,
  NewMult is Mult+1,
  calcXYratios(DX, DY, NewMult, RXY, RYX).

calcXYratios(DX, DY, Mult, RXY, RYX) :-
  DX =\= 0,
  DY =\= 0,
  RXY1 is (DX/DY)*Mult,
  RYX1 is (DY/DX)*Mult,
  UpperXY is float(ceiling(abs(RXY1))*sign(RXY1)),
  RXY1 == UpperXY,
  RXY is RXY1,
  RYX is RYX1.

calcXYratios(DX, DY, Mult, RXY, RYX) :-
  DX =\= 0,
  DY =\= 0,
  RXY1 is (DX/DY)*Mult,
  RYX1 is (DY/DX)*Mult,
  UpperYX is float(ceiling(abs(RYX1))*sign(RYX1)),
  RYX1 == UpperYX,
  RXY is RXY1,
  RYX is RYX1.

isDirectlyVisible(1, _DX, _DY, _RXY, _RYX, _MinaX, _MinaY, _YukiX, _YukiY, _Board).

isDirectlyVisible(GCD, DX, DY, RXY, RYX, MinaX, MinaY, YukiX, YukiY, Board) :-
  GCD =\= 1,
  CRXY is ceiling(abs(RXY))*integer(sign(RXY)),
  CRYX is ceiling(abs(RYX))*integer(sign(RYX)),
  calcNextMinaCoords(DX, DY, MinaX, MinaY, CRXY, CRYX, NewMinaX, NewMinaY),
  value(Value, NewMinaX, NewMinaY, Board),
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
  write('Player 1 wins with both characters! He\'s the hide and seek master!').

announceSetWinner(Score, _CharWinner, _Game1Board, _Game2Board) :-
  checkValueList(2, 2, Score),
  write('Player 2 wins with both characters! He\'s the hide and seek master!').

announceSetWinner(Score, 'Yuki', G1B, G2B) :-
  checkValueList(1, 1, Score),
  checkValueList(1, 2, Score),
  removePlayersBoard(G1B, NoPlayersG1B),
  removePlayersBoard(G2B, NoPlayersG2B),
  sumMultList(0, TotalG1, NoPlayersG1B),
  sumMultList(0, TotalG2, NoPlayersG2B),
  NumTreesG1 is (300-TotalG1-3)/3,
  NumTreesG2 is (300-TotalG2-3)/3,
  getFinalWinner('Yuki', NumTreesG1, NumTreesG2).

announceSetWinner(Score, 'Mina', G1B, G2B) :-
  checkValueList(1, 1, Score),
  checkValueList(1, 2, Score),
  removePlayersBoard(G1B, NoPlayersG1B),
  removePlayersBoard(G2B, NoPlayersG2B),
  sumMultList(0, TotalG1, NoPlayersG1B),
  sumMultList(0, TotalG2, NoPlayersG2B),
  NumTreesG1 is (300-TotalG1-3)/3,
  NumTreesG2 is (300-TotalG2-3)/3,
  getFinalWinner('Mina', NumTreesG1, NumTreesG2).

getFinalWinner('Yuki', NumTreesG1, NumTreesG2) :-
  NumTreesG1 < NumTreesG2,
  write('Both players won as Yuki.\n'),
  write('Player 1 won the set with only '),write(NumTreesG1),write(' trees eaten versus '),write(NumTreesG2),write(' trees eaten from Player 2!').

getFinalWinner('Yuki', NumTreesG1, NumTreesG2) :-
  NumTreesG1 > NumTreesG2,
  write('Both players won as Yuki.\n'),
  write('Player 2 won the set with only '),write(NumTreesG2),write(' trees eaten versus '),write(NumTreesG1),write(' trees eaten from Player 1!').

getFinalWinner('Mina', NumTreesG1, NumTreesG2) :-
  NumTreesG1 > NumTreesG2,
  write('Both players won as Mina.\n'),
  write('Player 1 won the set by having a better performance as yuki eating '),write(NumTreesG1),write(' trees versus '),write(NumTreesG2),write(' trees from Player 2!').

getFinalWinner('Mina', NumTreesG1, NumTreesG2) :-
  NumTreesG1 < NumTreesG2,
  write('Both players won as Mina.\n'),
  write('Player 2 won the set by having a better performance as yuki eating '),write(NumTreesG2),write(' trees versus '),write(NumTreesG1),write(' trees from Player 1!').

getFinalWinner(_CharWinner, NumTreesG1, NumTreesG2) :-
  NumTreesG1 == NumTreesG2,
  write('It\'s a draw').
