-module(week2_9).
-export([double/1, evens/1]).

% double
double([]) -> 
    [];
double([X | Xs]) ->
    [X | [X | double(Xs)]].

% evens
evens([]) ->
    [];
evens([X | Xs]) when X rem 2 == 0 ->
    [X | evens(Xs)];
evens([X | Xs]) ->
    evens(Xs).

