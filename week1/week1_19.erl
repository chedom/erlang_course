-module(week1_19).
-export([fib/1, pieces/1]).

fib(1) ->
    0;
fib(2) ->
    1;
fib(N) ->
    fib(N-1) + fib(N-2).

pieces(0) ->
    1;
pieces(N) ->
    N + pieces(N-1).