:- use_module(library(system)).
:- use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(random)).
:- use_module(library(clpfd)).
:- consult('auxiliar.pl').
:- consult('logic.pl').
:- consult('dynamicboard.pl').

/**
 * Main predicate of the application.
 */
ss(Mode) :-
  repeat,
    dynamicBoard(Mode, Board, Result, LineSums, N),
    setDomain(Result),
    setRestrictionsBoard(Board, LineSums, Result, 0, 0, N),
    setCircleRestrictions(Board, Result),
    calcSums(Result, LineSums),
    appendBoard(Result, [], FinalResult),
    labeling([], FinalResult),
  !,
  write(N), nl,
  appendBoard(Board, [], FinalBoard),
  displayBoard(FinalBoard, N),
  write(LineSums), nl,
  displayBoard(FinalResult, N),nl.
