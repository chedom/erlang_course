-module(week3_11).
-export([compose/1, twice/1, iterate/1]).

compose(Xs) ->
    fun(Z) -> compose(Xs, Z) end.

compose([], Z) ->
    Z;
compose([X | Xs], Z) ->
    X(compose(Xs, Z)).

twice(Func) ->
    fun(X) -> Func(Func(X)) end.

id(X) -> 
    X.

iterate(N) ->
    fun(F) -> iterate(N, F) end.

iterate(0, _F) ->
    fun id/1;
iterate(N, F) ->
    F(),
    iterate(N - 1, F).
