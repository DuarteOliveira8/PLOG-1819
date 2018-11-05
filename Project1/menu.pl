menu :-
  displayMenu,
  read(Option),
  nl,
  manageOptions(Option).

displayMenu :-
  nl,
  write('    ----------------------------\n'),
  write('    | Welcome to Frozen Forest |\n'),
  write('    ----------------------------\n\n\n'),
  write('    1) Play against your friends.\n\n'),
  write('    2) Get destroyed by the Computer.\n\n'),
  write('    3) Watch two machines battle each other.\n\n'),
  write('    4) I want to leave this place.\n\n'),
  write('Choose wisely the mode you would like to play: ').

manageOptions(1) :-
  write('You two have fun!\n'),
  initializeGame(p1, p2).

manageOptions(2) :-
  write('Good luck...\n').

manageOptions(3) :-
  write('This is going to be interesting.\n').

manageOptions(4) :-
  write('KBye.\n').

manageOptions(_OTHER) :-
  write('I don\'t know what you just said but try again: '),
  read(Option),
  nl,
  manageOptions(Option).
