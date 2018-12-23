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
ss :-
  testBoard(3, Board, Result, LineSums),
  setDomain(Result),
  setRestrictionsBoard(Board, LineSums, Result, 0, 0, 7),
  setCircleRestrictions(Board, Result),
  calcSums(Result, LineSums),
  appendBoard(Result, [], Final),
  labeling([], Final),
  display_board(Final, 7),nl,
  fail.
ss.
