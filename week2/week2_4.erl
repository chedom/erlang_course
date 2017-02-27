-module(week2_4).
-export([sum/1]).

sum([]) -> 0;
sum([X | Xs]) -> X + sum(Xs).