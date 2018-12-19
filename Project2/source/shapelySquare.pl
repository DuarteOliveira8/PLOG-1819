:- use_module(library(system)).
:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(clpfd)).
:- consult('auxiliar.pl').
:- consult('logic.pl').
:- consult('dynamicboard.pl').

/**
 * Main predicate of the application.
 */
ss :-
  Board = [['q','k',' ','d','q','c',' '],
           ['q','q','t','c','q','q',' '],
           ['c',' ','t','d','k','q','t'],
           ['h','q','t',' ','d',' ','q'],
           ['h','c','d','c','s','q','q'],
           ['q','t','q','q','q','q','k'],
           ['c','t','d',' ','c','q','t']],
  LineSums = [23,20,26,20,26,19,22],
  Result = [[A1,A2,A3,A4,A5,A6,A7],
            [B1,B2,B3,B4,B5,B6,B7],
            [C1,C2,C3,C4,C5,C6,C7],
            [D1,D2,D3,D4,D5,D6,D7],
            [E1,E2,E3,E4,E5,E6,E7],
            [F1,F2,F3,F4,F5,F6,F7],
            [G1,G2,G3,G4,G5,G6,G7]],
  setDomain(Result),
  setRestrictionsBoard(Board, LineSums, Result, 0, 0, 7),
  appendBoard(Result, [], Final),
  labeling([], Final),
  write(Final),nl,
  fail.
ss.
