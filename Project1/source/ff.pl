:- consult('menu.pl').
:- consult('boardDisplay.pl').
:- consult('game.pl').
:- consult('logic.pl').
:- consult('ai.pl').
:- consult('aux.pl').
:- use_module(library(system)).
:- use_module(library(lists)).

play :-
  menu.
