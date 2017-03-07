-module(week3_11).
-export([compose/1, twice/1, iterate/1]).

compose(Xs) ->
    fun(Z) -> compose(Xs, Z) end.

compose([], Z) ->
    Z;
compose([X | Xs], Z) ->
    X(compose(Xs, Z)).

compose2(F, G) ->
    fun(X) -> F(G(X)) end.

twice(Func) ->
    fun(X) -> Func(Func(X)) end.

id(X) -> 
    X.

iterate(0) ->
    fun(_F) -> fun id/1 end;
iterate(N) ->
    fun(F) -> compose2(F, (iterate(N-1))(F)) end.