:- use_module(library(system)).
:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(chr)).
:- consult('auxiliar.pl').

/**
 * Main predicate of the application.
 */
ss(Result) :-
  Board = [['q','k',' ','d','q','c',' ',23],
           ['q','q','t','c','q','q',' ',20],
           ['c',' ','t','d','k','q','t',26],
           ['h','q','t',' ','d',' ','q',20],
           ['h','c','d','c','s','q','q',26],
           ['q','t','q','q','q','q','k',19],
           ['c','t','d',' ','c','q','t',22]],
  Result = [[A1,A2,A3,A4,A5,A6,A7],
            [B1,B2,B3,B4,B5,B6,B7],
            [C1,C2,C3,C4,C5,C6,C7],
            [D1,D2,D3,D4,D5,D6,D7],
            [E1,E2,E3,E4,E5,E6,E7],
            [F1,F2,F3,F4,F5,F6,F7],
            [G1,G2,G3,G4,G5,G6,G7]],
  setDomain(Result),
  setRestrictionsBoard(Board, Result, 0, 0, 7),
  labelResult(Result).

/**
 * Predicates to set the domain to the result board.
 */
setDomain([]).

setDomain([R1 | R]) :-
  domain(R1, 0, 9),
  setDomain(R).

/**
 * Predicates to label the result board.
 */
labelResult([]).

labelResult([R1 | R]) :-
  labeling([], R1),
  labelResult(R).

/**
 * Predicates to set all restrictions to the result board.
 */
setRestrictionsBoard(_Board, _Result, _I, N, N).

setRestrictionsBoard(Board, Result, N, J, N) :-
  NewJ is J+1,
  setRestrictionsBoard(Board, Result, 0, NewJ, N).

setRestrictionsBoard(Board, Result, I, J, N) :-
  value(BoardList, I, J, Board)
  nth0(J, Board, BoardList),
  nth0(I, BoardList, BoardElem),
  nth0(J, Result, ResultList),
  nth0(I, ResultList, ResultElem),
  setRestriction(Board, Result, BoardElem, ResultElem, I, J, N),
  NewI is I+1,
  setRestrictionsBoard(Board, Result, NewI, J, N).

/**
 * Predicates to set restriction to a element of the result board.
 */
setRestriction(Board, Result, ' ', ResultElem, I, J, N).

setRestriction(Board, Result, 's', ResultElem, I, J, N).

setRestriction(Board, Result, 'q', ResultElem, I, J, N) :-
  ResultElem in {0, 5}.

setRestriction(Board, Result, 'd', ResultElem, I, J, N).

setRestriction(Board, Result, 't', ResultElem, I, J, N) :-


setRestriction(Board, Result, 'c', ResultElem, I, J, N).

setRestriction(Board, Result, 'k', ResultElem, I, J, N).

setRestriction(Board, Result, 'h', ResultElem, I, J, N).
