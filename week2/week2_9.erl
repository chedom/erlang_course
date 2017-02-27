-module(week2_9).
-export([double/1, evens/1, median/1]).

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
evens([_X | Xs]) ->
    evens(Xs).

%sum aux
sum([]) -> 0;
sum([X | Xs]) -> X + sum(Xs).

% median
median(Xs) when length(Xs) rem 2 == 1 ->
   median(Xs, 1, (length(Xs) div 2) + 1);
median(Xs) ->
   (median(Xs, 1, (length(Xs) div 2) + 1) + median(Xs, 1, length(Xs) div 2)) div 2.

median([X | _Xs], CURR, FIND) when CURR == FIND ->
    X;
median([_X | Xs], CURR, FIND) ->
median(Xs, CURR + 1, FIND).

%make median with func composition sum!
