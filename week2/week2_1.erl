-module(week2_1).
-export([head/1, tail/1, second/1]).

head([X | _Xs]) -> X.

tail([_X | Xs]) -> Xs.

second(Xs) -> head(tail(Xs)).