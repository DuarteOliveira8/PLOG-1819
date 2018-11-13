/* use between(low, high, X) */
checkValidYukiInput(OldX, OldY, X, Y, MinaX, MinaY, Board) :-
  X > 0,
  X < 11,
  Y > 0,
  Y < 11,
  X < OldX+2,
  X > OldX-2,
  Y < OldY+2,
  Y > OldY-2,
  DX is abs(X-OldX),
  DY is abs(Y-OldY),
  (DX =\= 0, DY =\= 0),
  \+ checkValueMultList(0, X, Y, Board),
  isVisible(MinaX, MinaY, X, Y, Board).

/* use between(low, high, X) */
checkValidMinaInput(OldX, OldY, X, Y, YukiX, YukiY, Board) :-
  X > 0,
  X < 11,
  Y > 0,
  Y < 11,
  DX is abs(X-OldX),
  DY is abs(Y-OldY),
  (DX > 0, DY == 0 ; DX == 0, DY > 0 ; DX == DY, DX =\= 0),
  \+ isVisible(X, Y, YukiX, YukiY, Board).

/* remove ifs */
isVisible(MinaX, MinaY, YukiX, YukiY, Board) :-
  DX is MinaX-YukiX,
  DY is MinaY-YukiY,
  (DY == 0 -> (DX < 0 -> RXY is -1; RXY is 1) ; RXY is DX/DY),
  (DX == 0 -> (DY < 0 -> RYX is -1; RYX is 1) ; RYX is DY/DX),
  AbsDX is abs(DX),
  AbsDY is abs(DY),
  GCD is gcd(AbsDX,AbsDY),
  (GCD == 1 ->
    write(visible1),nl,
    true
  ;
    CRXY is ceiling(RXY),
    CRYX is ceiling(RYX),
    calcNextMinaX(DX, DY, MinaX, MinaY, CRXY, CRYX, NewMinaX, NewMinaY),
    (checkValueMultList(3, NewMinaX, NewMinaY, Board) ->
      write('not visible'),nl,
      fail
    ;checkValueMultList(1, NewMinaX, NewMinaY, Board) ->
      write(visible2),nl,
      true
    ;checkValueMultList(0, NewMinaX, NewMinaY, Board) ->
      (isVisible(NewMinaX, NewMinaY, YukiX, YukiY, Board) -> true ; fail)
    )
  ).

calcNextMinaX(DX, DY, MinaX, MinaY, CRXY, CRYX, NewMinaX, NewMinaY) :-
  DX < 0, DY < 0,
  NewMinaX is MinaX+CRXY,
  NewMinaY is MinaY+CRYX.

calcNextMinaX(DX, DY, MinaX, MinaY, CRXY, CRYX, NewMinaX, NewMinaY) :-
  DX > 0, DY < 0,
  NewMinaX is MinaX+CRXY,
  NewMinaY is MinaY-CRYX.

calcNextMinaX(DX, DY, MinaX, MinaY, CRXY, CRYX, NewMinaX, NewMinaY) :-
  DX < 0, DY > 0,
  NewMinaX is MinaX-CRXY,
  NewMinaY is MinaY+CRYX.

calcNextMinaX(DX, DY, MinaX, MinaY, CRXY, CRYX, NewMinaX, NewMinaY) :-
  DX > 0, DY > 0,
  NewMinaX is MinaX-CRXY,
  NewMinaY is MinaY-CRYX.
