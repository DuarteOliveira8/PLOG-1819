chooseBestFirstMinaPlay(MinaX, MinaY, Board) :-
  checkValueMultList(1, YukiX, YukiY, Board),
  findall([X,Y], (between(1,10,X), between(1,10,Y), \+isVisible(X, Y, YukiX, YukiY, Board)), ValidPlays),
  calcDistances(ValidPlays, YukiX, YukiY, Distances),
  max_member(MaxD, Distances),
  getIndexesOf(MaxD, 1, Distances, Indexes),
  length(Indexes, ILength),
  Upper is ILength+1,
  random(1, Upper, Index),
  checkValueList(ValidPlayIndex, Index, Indexes),
  checkValueList(Position, ValidPlayIndex, ValidPlays),
  checkValueList(MinaX, 1, Position),
  checkValueList(MinaY, 2, Position).

chooseRandomFirstPlay('Mina', MinaX, MinaY, Board) :-
  checkValueMultList(1, YukiX, YukiY, Board),
  findall([X,Y], (between(1,10,X), between(1,10,Y), \+isVisible(X, Y, YukiX, YukiY, Board)), ValidPlays),
  length(ValidPlays, Length),
  Upper is Length+1,
  random(1, Upper, Index),
  checkValueList(Position, Index, ValidPlays),
  checkValueList(MinaX, 1, Position),
  checkValueList(MinaY, 2, Position).

chooseRandomFirstPlay('Yuki', YukiX, YukiY, _Board) :-
  random(1, 11, YukiX),
  random(1, 11, YukiY).

chooseFirstPlay(Player, 1, X, Y, Board) :-
  chooseRandomFirstPlay(Player, X, Y, Board).

chooseFirstPlay('Mina', 2, X, Y, Board) :-
  chooseBestFirstMinaPlay(X, Y, Board).

chooseFirstPlay('Yuki', 2, X, Y, Board) :-
  chooseRandomFirstPlay('Yuki', X, Y, Board).

chooseBestPlay('Yuki', YukiX, YukiY, Board, ValidPlays) :-
  checkValueMultList(2, MinaX, MinaY, Board),
  calcDistances(ValidPlays, MinaX, MinaY, Distances),
  min_member(MaxD, Distances),
  getIndexesOf(MaxD, 1, Distances, Indexes),
  length(Indexes, ILength),
  Upper is ILength+1,
  random(1, Upper, Index),
  checkValueList(ValidPlayIndex, Index, Indexes),
  checkValueList(Position, ValidPlayIndex, ValidPlays),
  checkValueList(YukiX, 1, Position),
  checkValueList(YukiY, 2, Position).

chooseBestPlay('Yuki', YukiX, YukiY, Board, ValidPlays) :-
  checkValueMultList(5, MinaX, MinaY, Board),
  calcDistances(ValidPlays, MinaX, MinaY, Distances),
  min_member(MaxD, Distances),
  getIndexesOf(MaxD, 1, Distances, Indexes),
  length(Indexes, ILength),
  Upper is ILength+1,
  random(1, Upper, Index),
  checkValueList(ValidPlayIndex, Index, Indexes),
  checkValueList(Position, ValidPlayIndex, ValidPlays),
  checkValueList(YukiX, 1, Position),
  checkValueList(YukiY, 2, Position).

chooseBestPlay('Mina', MinaX, MinaY, Board, ValidPlays) :-
  checkValueMultList(1, YukiX, YukiY, Board),
  calcDistances(ValidPlays, YukiX, YukiY, Distances),
  max_member(MaxD, Distances),
  getIndexesOf(MaxD, 1, Distances, Indexes),
  length(Indexes, ILength),
  Upper is ILength+1,
  random(1, Upper, Index),
  checkValueList(ValidPlayIndex, Index, Indexes),
  checkValueList(Position, ValidPlayIndex, ValidPlays),
  checkValueList(MinaX, 1, Position),
  checkValueList(MinaY, 2, Position).

chooseRandomPlay(X, Y, ValidPlays) :-
  length(ValidPlays, Length),
  Upper is Length+1,
  random(1, Upper, Index),
  checkValueList(Position, Index, ValidPlays),
  checkValueList(X, 1, Position),
  checkValueList(Y, 2, Position).

choosePlay(_Player, 1, X, Y, _Board, ValidPlays) :-
  chooseRandomPlay(X, Y, ValidPlays).

choosePlay(Player, 2, X, Y, Board, ValidPlays) :-
  chooseBestPlay(Player, X, Y, Board, ValidPlays).

writeChoosingMessage :-
  write('Elon Musk\'s best AI is thinking'),
  sleep(0.5),
  write('.'),
  sleep(0.5),
  write('.'),
  sleep(0.5),
  write('.'),
  sleep(0.5),
  nl.
