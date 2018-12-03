:- consult('menu.pl').
:- consult('boardDisplay.pl').
:- consult('game.pl').
:- consult('logic.pl').
:- consult('ai.pl').
:- consult('auxiliar.pl').
:- use_module(library(system)).
:- use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(random)).

/* Main Game Predicate */
play :-
  menu.
