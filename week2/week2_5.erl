-module(week2_5).
-export([sum/1]).

sum(Xs) -> sum(Xs, 0).

sum([], ACCUM) -> ACCUM;
sum([X | Xs], ACCUM) -> sum(Xs, ACCUM + X).