-module(week1_21).
-export([fac/1, loop/1, fib/1, perfect/1]).

fac(N) ->
    fac(N, 1).

fac(0, P) ->
    P;
fac(N, P) when N>0 ->
    fac(N-1, P*N).

loop(N) when N>0 ->
    io:format("~p~n", [N]),
    loop(N-1);

loop(_) ->
    io:format("bye~n").

fib(N) ->
    fib(N, 0, 1).

fib(1, ACCUM1, _) ->
    ACCUM1;
fib(2, _, ACCUM2) ->
    ACCUM2;
fib(N, ACCUM1, ACCUM2) ->
    fib(N-1, ACCUM2, ACCUM1 + ACCUM2).

perfect(0) ->
    false;
perfect(1) ->
    true;
perfect(N) ->
    perfect(N, 1, 0).

perfect(N, N, ACCUM) ->
    N == ACCUM;

perfect(N, CURR, ACCUM) when N rem CURR == 0 ->
    perfect(N, CURR+1, ACCUM + CURR);

perfect(N, CURR, ACCUM) when N rem CURR /= 0 ->
    perfect(N, CURR+1, ACCUM).
