-module(week2_13).
-export([nub/1]).

exist([], _Val) ->
    false;
exist([X | Xs], Val) ->
    (X == Val) or exist(Xs, Val).

nub([]) -> 
    [];
nub([X | Xs]) ->
    case exist(Xs, X) of
        true -> nub(Xs);
        _ -> [X | nub(Xs)]
    end.