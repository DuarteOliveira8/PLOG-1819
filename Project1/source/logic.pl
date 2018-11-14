checkGameState(Player, ValidPlays, Board) :-
  \+ checkValidPlays(Player, ValidPlays),
  \+ checkNumTrees(Player, Board).

checkValidPlays(Player, ValidPlays) :-
  length(ValidPlays, 0),
  write('Game Over: '),
  write(Player),
  write(' wins!\n').

checkNumTrees(Player, Board) :-
  sumMultList(0, 93, Board),
  write('Game Over: '),
  write(Player),
  write(' wins!\n').

generateValidYukiPlays(OldX, OldY, MinaX, MinaY, Board, ValidPlays) :-
  findall([X,Y], checkValidYukiPlay(OldX, OldY, X, Y, MinaX, MinaY, Board), ValidPlays).

generateValidMinaPlays(OldX, OldY, YukiX, YukiY, Board, ValidPlays) :-
  findall([X,Y], checkValidMinaPlay(OldX, OldY, X, Y, YukiX, YukiY, Board), ValidPlays).

checkValidYukiPlay(OldX, OldY, X, Y, MinaX, MinaY, Board) :-
  between(1, 10, X),
  between(1, 10, Y),
  DX is abs(X-OldX),
  DY is abs(Y-OldY),
  between(0, 1, DX),
  between(0, 1, DY),
  \+ checkValueMultList(1, X, Y, Board),
  \+ checkValueMultList(2, X, Y, Board),
  \+ checkValueMultList(5, X, Y, Board),
  \+ checkValueMultList(0, X, Y, Board),
  isVisible(MinaX, MinaY, X, Y, Board).

/* remove ifs */
checkValidMinaPlay(OldX, OldY, X, Y, YukiX, YukiY, Board) :-
  between(1, 10, X),
  between(1, 10, Y),
  DX is abs(X-OldX),
  DY is abs(Y-OldY),
  (DX > 0, DY == 0 ; DX == 0, DY > 0 ; DX == DY, DX =\= 0),
  \+ checkValueMultList(1, X, Y, Board),
  \+ checkValueMultList(2, X, Y, Board),
  \+ checkValueMultList(5, X, Y, Board),
  \+ isVisible(X, Y, YukiX, YukiY, Board).

isVisible(MinaX, MinaY, YukiX, YukiY, Board) :-
  DX is MinaX-YukiX,
  DY is MinaY-YukiY,
  calcXYratios(DX, DY, RXY, RYX),
  GCD is gcd(DX,DY),
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
