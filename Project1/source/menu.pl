menu :-
  write('\33\[2J'),
  displayMenu,
  read(Option),
  nl,
  manageOptions(Option).

displayMenu :-
  nl,
  write('     ______                        ______                  _   \n'),
  sleep(0.1),
  write('    |  ____|                      |  ____|                | |  \n'),
  sleep(0.1),
  write('    | |__ _ __ ___ _______ _ __   | |__ ___  _ __ ___  ___| |_ \n'),
  sleep(0.1),
  write('    |  __| "__/ _ |_  / _ | "_ |  |  __/ _ || "__/ _ |/ __| __|\n'),
  sleep(0.1),
  write('    | |  | | | (_) / /  __/ | | | | | | (_) | | |  __/|__ | |_ \n'),
  sleep(0.1),
  write('    |_|  |_|  |___/___|___|_| |_| |_|  |___/|_|  |___||___/|__|\n\n\n'),
  sleep(0.1),
  write('      1) Play against your friends.\n'),
  sleep(0.1),
  nl,
  sleep(0.1),
  write('      2) Get destroyed by the Computer.\n'),
  sleep(0.1),
  nl,
  sleep(0.1),
  write('      3) Watch two machines battle each other.\n'),
  sleep(0.1),
  nl,
  sleep(0.1),
  write('      4) I want to leave this place.\n'),
  sleep(0.1),
  nl,
  sleep(0.1),
  write('Choose wisely the mode you would like to play: ').

manageOptions(1) :-
  write('\33\[2J'),
  write('You two have fun!\n'),
  initializeGame,
  menu.

manageOptions(2) :-
  write('\33\[2J'),
  write('Good luck...\n'),
  menu.

manageOptions(3) :-
  write('\33\[2J'),
  write('This is going to be interesting.\n'),
  menu.

manageOptions(4) :-
  write('\33\[2J'),
  write('KBye.\n').

manageOptions(_OTHER) :-
  write('I don\'t know what you just said but try again: '),
  read(Option),
  nl,
  manageOptions(Option).
