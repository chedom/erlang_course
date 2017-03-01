-module(week2_14).
-export([nub/1, bun/1]).

-spec nub([T]) -> [T].
nub([]) ->
    [];
nub([X | Xs]) ->
    [X | nub(removeAll(X, Xs))].

removeAll(_X, []) ->
    [];
removeAll(X, [X | Xs]) ->
    removeAll(X, Xs);
removeAll(X, [Y | Ys]) ->
    [Y | removeAll(X, Ys)].

-spec bun([T]) -> [T].
bun([]) ->
    [];
bun([X | Xs]) ->
    case member(X, Xs) of
        true -> bun(Xs);
        false -> [X | bun(Xs)]
    end.

member(_, []) ->
    false;
member(X, [X | _Xs]) ->
    true;
member(X, [_Y | Xs]) ->
    member(X, Xs).