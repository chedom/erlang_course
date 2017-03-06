-module(week3_11).
-export([compose/1, twice/1]).

compose(Xs) ->
    fun(Z) -> compose(Xs, Z) end.

compose([], Z) ->
    Z;
compose([X | Xs], Z) ->
    X(compose(Xs, Z)).

twice(Func) ->
    fun(X) -> Func(Func(X)) end.