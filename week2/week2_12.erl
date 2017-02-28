-module(week2_12).
-export([split/2]).

-spec split(integer(), [T]) -> { [T], [T] }.
split(N, Xs) when N > 0 ->
    split(N, Xs, []).
split(0, Xs, First) ->
    {First, Xs};    
split(N, [X | Xs], First) ->
    split(N - 1, Xs, [X | First]).

