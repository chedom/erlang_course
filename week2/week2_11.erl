-module(week2_11).
-export([take/2]).

-spec take(integer(), [T]) -> [T].
take(0, _) ->
    [];
take(_, []) ->
    [];
take(N, [X | Xs]) ->
    [X | take(N - 1, Xs)].