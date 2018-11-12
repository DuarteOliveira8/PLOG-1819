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

checkValidMinaInput(OldX, OldY, X, Y, YukiX, YukiY, Board) :-
  X > 0,
  X < 11,
  Y > 0,
  Y < 11,
  DX is abs(X-OldX),
  DY is abs(Y-OldY),
  (DX > 0, DY == 0 ; DX == 0, DY > 0 ; DX == DY, DX =\= 0),
  \+ isVisible(X, Y, YukiX, YukiY, Board).

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
    (DX < 0, DY < 0 ->
      NewMinaX is MinaX+CRXY,
      NewMinaY is MinaY+CRYX
    ;DX > 0, DY < 0 ->
      NewMinaX is MinaX+CRXY,
      NewMinaY is MinaY-CRYX
    ;DX < 0, DY > 0 ->
      NewMinaX is MinaX-CRXY,
      NewMinaY is MinaY+CRYX
    ;DX > 0, DY > 0 ->
      NewMinaX is MinaX-CRXY,
      NewMinaY is MinaY-CRYX
    ),
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

checkGameState(y, X, Y, MinaX, MinaY, Board) :-
  sumMultList(0, Total, Board),
  Total > 93,
  checkAround(X-1, Y-1, 3, 3, MinaX, MinaY, Board).

checkAround(_X, _Y, 0, 0, _MinaX, _MinaY, _Board).

checkAround(X, Y, 0, DY, MinaX, MinaY, Board) :-
  NewDY is DY-1,
  NewY is Y+1,
  NewX is X-2,
  checkAround(NewX, NewY, 3, NewDY, MinaX, MinaY, Board).

checkAround(X, Y, DX, DY, MinaX, MinaY, Board) :-
  checkValueMultList(0, X, Y, Board),
  \+ isVisible(MinaX, MinaY, X, Y, Board),
  NewX is X+1,
  NewDX is DX-1,
  checkAround(NewX, Y, NewDX, DY, MinaX, MinaY, Board).
