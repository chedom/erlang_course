-module(week3_5).
-export([
    doubleAll/1, 
    evens/1, 
    product/1,
    zip/2,
    zip_with/3,
    zip_with_2/3
]).

doubleAll(Xs) ->
    lists:map(fun(X) -> X * 2 end, Xs).

evens(Xs) ->
    lists:filter(fun(X) -> X rem 2 == 0 end, Xs).
    
product(Xs) ->
    lists:foldr(fun(X, Acc) -> Acc * X end, 1, Xs).

zip([], _Ys) ->
    [];
zip(_Xs, []) ->
    [];
zip([X | Xs], [Y | Ys]) ->
    [{X, Y} | zip(Xs, Ys)].

zip_with(_F, [], _Ys) ->
    [];
zip_with(_F, _Xs, []) ->
    [];
zip_with(F, [X | Xs], [Y | Ys]) ->
    [F(X, Y) | zip_with(F, Xs, Ys)].

zip_with_2(F, Xs, Ys) ->
    lists:map(fun({X, Y}) -> F(X, Y) end, zip(Xs, Ys)).