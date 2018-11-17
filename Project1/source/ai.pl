chooseBestFirstPlay(MinaX, MinaY, Board) :-
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

chooseRandomFirstPlay(YukiX, YukiY) :-
  random(1, 11, YukiX),
  random(1, 11, YukiY).

chooseBestYukiPlay(YukiX, YukiY, Board, ValidPlays) :-
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

chooseBestYukiPlay(YukiX, YukiY, Board, ValidPlays) :-
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

chooseBestMinaPlay(MinaX, MinaY, Board, ValidPlays) :-
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
