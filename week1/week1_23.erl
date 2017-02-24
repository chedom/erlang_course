-module(week1_23).
-export([fib/1, area/1]).

fibP(0) ->
    {0, 1};
fibP(N) ->
    {P,C} = fibP(N-1),
    {C, P+C}.

fib(N) ->
    {P,_} = fibP(N),
    P.

area({circle, _, R}) ->
    math:pi()*R*R;
area({rectangle, _, H,W}) ->
    H*W.