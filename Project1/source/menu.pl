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
  write('    |  __| \'__/ _ |_  / _ | \'_ |  |  __/ _ || \'__/ _ |/ __| __|\n'),
  sleep(0.1),
  write('    | |  | | | (_) / /  __/ | | | | | | (_) | | |  __/|__ | |_ \n'),
  sleep(0.1),
  write('    |_|  |_|  |___/___|___|_| |_| |_|  |___/|_|  |___||___/|__|\n\n\n'),
  sleep(0.1),
  write('      1) Play against your friends.\n'),
  sleep(0.1),
  nl,
  sleep(0.1),
  write('      2) Get destroyed by Elon Musk\'s AI.\n'),
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
  initializeSet('p', 'p'),
  menu.

manageOptions(2) :-
  write('\33\[2J'),
  chooseFirstPlayer,
  menu.

manageOptions(3) :-
  write('\33\[2J'),
  write('This is going to be interesting.\n'),
  initializeSet('c', 'c'),
  menu.

manageOptions(4) :-
  write('\33\[2J'),
  write('KBye.\n').

manageOptions(OTHER) :-
  OTHER =\= 1,
  OTHER =\= 2,
  OTHER =\= 3,
  OTHER =\= 4,
  write('I don\'t know what you just said but try again: '),
  read(Option),
  nl,
  manageOptions(Option).

chooseFirstPlayer :-
  write('Who plays first?\n'),
  write('1) Player.\n'),
  write('2) Elon Musk\'s beast AI.\n'),
  read(FirstPlayer),
  manageFirstPlayerOption(FirstPlayer).

manageFirstPlayerOption(1) :-
  write('\33\[2J'),
  write('Good luck...\n'),
  initializeSet('p', 'c').

manageFirstPlayerOption(2) :-
  write('\33\[2J'),
  write('Good luck...\n'),
  initializeSet('c', 'p').

manageFirstPlayerOption(OTHER) :-
  OTHER =\= 1,
  OTHER =\= 2,
  write('I don\'t know what you just said but try again: '),
  read(FirstPlayer),
  nl,
  manageFirstPlayerOption(FirstPlayer).
